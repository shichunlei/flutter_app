import 'dart:math';

import 'package:flutter/material.dart';

class Wave extends StatefulWidget {
  final CConfig config;
  final Size size;
  final double waveAmplitude;
  final double wavePhase;
  final double waveFrequency;
  final double heightPercentange;
  final int duration;
  final Color backgroundColor;

  Wave({
    @required this.config,
    this.duration = 6000,
    @required this.size,
    this.waveAmplitude = 20.0,
    this.waveFrequency = 1.6,
    this.wavePhase = 10.0,
    this.backgroundColor,
    this.heightPercentange = 0.2,
  });

  @override
  State<StatefulWidget> createState() => _WaveState();
}

class _WaveState extends State<Wave> with TickerProviderStateMixin {
  List<AnimationController> _waveControllers;
  List<Animation<double>> _wavePhaseValues;

  List<double> _waveAmplitudes = [];
  Map<Animation<double>, AnimationController> valueList;

  _initAnimations() {
    if (widget.config.colorMode == ColorMode.custom) {
      _waveControllers =
          (widget.config as CustomConfig).durations.map((duration) {
        _waveAmplitudes.add(widget.waveAmplitude + 10);
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: duration));
      }).toList();

      _wavePhaseValues = _waveControllers.map((controller) {
        CurvedAnimation _curve =
            CurvedAnimation(parent: controller, curve: Curves.easeInOut);
        Animation<double> value = Tween(
          begin: widget.wavePhase,
          end: 360 + widget.wavePhase,
        ).animate(
          _curve,
        );
        value.addStatusListener((status) {
          switch (status) {
            case AnimationStatus.completed:
              controller.reverse();
              break;
            case AnimationStatus.dismissed:
              controller.forward();
              break;
            default:
              break;
          }
        });
        controller.forward();
        return value;
      }).toList();
    }
  }

  _buildPaints() {
    List<Widget> paints = [];
    if (widget.config.colorMode == ColorMode.custom) {
      List<Color> _colors = (widget.config as CustomConfig).colors;
      List<List<Color>> _gradients = (widget.config as CustomConfig).gradients;
      Alignment begin = (widget.config as CustomConfig).gradientBegin;
      Alignment end = (widget.config as CustomConfig).gradientEnd;
      for (int i = 0; i < _wavePhaseValues.length; i++) {
        paints.add(
          Container(
            child: CustomPaint(
              painter: _CustomWavePainter(
                color: _colors == null ? null : _colors[i],
                gradient: _gradients == null ? null : _gradients[i],
                gradientBegin: begin,
                gradientEnd: end,
                heightPercentange:
                    (widget.config as CustomConfig).heightPercentages[i],
                repaint: _waveControllers[i],
                waveFrequency: widget.waveFrequency,
                wavePhaseValue: _wavePhaseValues[i],
                waveAmplitude: _waveAmplitudes[i],
                blur: (widget.config as CustomConfig).blur,
              ),
              size: widget.size,
            ),
          ),
        );
      }
    }
    return paints;
  }

  _disposeAnimations() {
    _waveControllers.forEach((controller) {
      controller.dispose();
    });
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Stack(
        children: _buildPaints(),
      ),
    );
  }
}

/// Meta data of layer
class Layer {
  final Color color;
  final List<Color> gradient;
  final MaskFilter blur;
  final Path path;
  final double amplitude;
  final double phase;

  Layer({
    this.color,
    this.gradient,
    this.blur,
    this.path,
    this.amplitude,
    this.phase,
  });
}

class _CustomWavePainter extends CustomPainter {
  final ColorMode colorMode;
  final Color color;
  final List<Color> gradient;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final MaskFilter blur;

  double waveAmplitude;

  Animation<double> wavePhaseValue;

  double waveFrequency;

  double heightPercentange;

  double _tempA = 0.0;
  double _tempB = 0.0;
  double viewWidth = 0.0;
  Paint _paint = Paint();

  _CustomWavePainter(
      {this.colorMode,
      this.color,
      this.gradient,
      this.gradientBegin,
      this.gradientEnd,
      this.blur,
      this.heightPercentange,
      this.waveFrequency,
      this.wavePhaseValue,
      this.waveAmplitude,
      Listenable repaint})
      : super(repaint: repaint);

  _setPaths(double viewCenterY, Size size, Canvas canvas) {
    Layer _layer = Layer(
      path: Path(),
      color: color,
      gradient: gradient,
      blur: blur,
      amplitude: (-1.6 + 0.8) * waveAmplitude,
      phase: wavePhaseValue.value * 2 + 30,
    );

    _layer.path.reset();
    _layer.path.moveTo(
        0.0,
        viewCenterY +
            _layer.amplitude * _getSinY(_layer.phase, waveFrequency, -1));
    for (int i = 1; i < size.width + 1; i++) {
      _layer.path.lineTo(
          i.toDouble(),
          viewCenterY +
              _layer.amplitude * _getSinY(_layer.phase, waveFrequency, i));
    }

    _layer.path.lineTo(size.width, size.height);
    _layer.path.lineTo(0.0, size.height);
    _layer.path.close();
    if (_layer.color != null) {
      _paint.color = _layer.color;
    }
    if (_layer.gradient != null) {
      var rect = Offset.zero &
          Size(size.width, size.height - viewCenterY * heightPercentange);
      _paint.shader = LinearGradient(
              begin: gradientBegin == null
                  ? Alignment.bottomCenter
                  : gradientBegin,
              end: gradientEnd == null ? Alignment.topCenter : gradientEnd,
              colors: _layer.gradient)
          .createShader(rect);
    }
    if (_layer.blur != null) {
      _paint.maskFilter = _layer.blur;
    }

    _paint.style = PaintingStyle.fill;
    canvas.drawPath(_layer.path, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double viewCenterY = size.height * (heightPercentange + 0.1);
    viewWidth = size.width;
    _setPaths(viewCenterY, size, canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double _getSinY(
      double startradius, double waveFrequency, int currentposition) {
    if (_tempA == 0) {
      _tempA = pi / viewWidth;
    }
    if (_tempB == 0) {
      _tempB = 2 * pi / 360.0;
    }

    return (sin(
        _tempA * waveFrequency * (currentposition + 1) + startradius * _tempB));
  }
}

enum ColorMode {
  /// Waves with *single* **color** but different **alpha** and **amplitude**.
  single,

  /// Waves using *random* **color**, **alpha** and **amplitude**.
  random,

  /// Waves' colors must be set, and [colors]'s length must equal with [layers]
  custom,
}

abstract class CConfig {
  final ColorMode colorMode;

  CConfig({this.colorMode});

  void throwNullError(String colorModeStr, String configStr) {
    throw FlutterError(
        'When using `ColorMode.$colorModeStr`, `$configStr` must be set.');
  }
}

class CustomConfig extends CConfig {
  final List<Color> colors;
  final List<List<Color>> gradients;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final List<int> durations;
  final List<double> heightPercentages;
  final MaskFilter blur;

  CustomConfig({
    this.colors,
    this.gradients,
    this.gradientBegin,
    this.gradientEnd,
    @required this.durations,
    @required this.heightPercentages,
    this.blur,
  })  : assert(() {
          if (colors == null && gradients == null) {
            throwNullError('custom', 'colors` or `gradients');
          }
          return true;
        }()),
        assert(() {
          if (gradients == null &&
              (gradientBegin != null || gradientEnd != null)) {
            throw FlutterError(
                'You set a gradient direction but forgot setting `gradients`.');
          }
          return true;
        }()),
        assert(() {
          if (durations == null) {
            throwNullError('custom', 'durations');
          }
          return true;
        }()),
        assert(() {
          if (heightPercentages == null) {
            throwNullError('custom', 'heightPercentages');
          }
          return true;
        }()),
        assert(() {
          if (colors != null) {
            if (colors.length != durations.length ||
                colors.length != heightPercentages.length) {
              throw FlutterError(
                  'Length of `colors`, `durations` and `heightPercentages` must be equal.');
            }
          }
          return true;
        }()),
        assert(colors == null || gradients == null,
            'Cannot provide both colors and gradients.'),
        super(colorMode: ColorMode.custom);
}

/// todo
class RandomConfig extends CConfig {
  RandomConfig() : super(colorMode: ColorMode.random);
}

/// todo
class SingleConfig extends CConfig {
  SingleConfig() : super(colorMode: ColorMode.single);
}
