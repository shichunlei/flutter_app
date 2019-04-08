import 'package:flutter_app/utils/time_utils.dart';

///(xx)Configurable output.
///(xx)为可配置输出.
enum DayFormat {
  ///(less than 10s->just now)、x minutes、x hours、(Yesterday)、x days.
  ///(小于10s->刚刚)、x分钟、x小时、(昨天)、x天.
  Simple,

  ///(less than 10s->just now)、x minutes、x hours、[This year:(Yesterday/a day ago)、(two days age)、MM-dd ]、[past years: yyyy-MM-dd]
  ///(小于10s->刚刚)、x分钟、x小时、[今年: (昨天/1天前)、(2天前)、MM-dd],[往年: yyyy-MM-dd].
  Common,

  ///日期 + HH:mm
  ///(less than 10s->just now)、x minutes、x hours、[This year:(Yesterday HH:mm/a day ago)、(two days age)、MM-dd HH:mm]、[past years: yyyy-MM-dd HH:mm]
  ///小于10s->刚刚)、x分钟、x小时、[今年: (昨天 HH:mm/1天前)、(2天前)、MM-dd HH:mm],[往年: yyyy-MM-dd HH:mm].
  Full,
}

///Timeline information configuration.
///Timeline信息配置.
abstract class TimelineInfo {
  String suffixAgo(); //suffix ago(后缀 后).

  String suffixAfter(); //suffix after(后缀 前).

  String lessThanTenSecond() => ''; //just now(刚刚).

  String customYesterday() => ''; //Yesterday(昨天).优先级高于keepOneDay

  bool keepOneDay(); //保持1天,example: true -> 1天前, false -> MM-dd.

  bool keepTwoDays(); //保持2天,example: true -> 2天前, false -> MM-dd.

  String oneMinute(int minutes); //a minute(1分钟).

  String minutes(int minutes); //x minutes(x分钟).

  String anHour(int hours); //an hour(1小时).

  String hours(int hours); //x hours(x小时).

  String oneDay(int days); //a day(1天).

  String days(int days); //x days(x天).
}

class ZhInfo implements TimelineInfo {
  String suffixAgo() => '前';

  String suffixAfter() => '后';

  String lessThanTenSecond() => '刚刚';

  String customYesterday() => '昨天';

  bool keepOneDay() => true;

  bool keepTwoDays() => true;

  String oneMinute(int minutes) => '$minutes分钟';

  String minutes(int minutes) => '$minutes分钟';

  String anHour(int hours) => '$hours小时';

  String hours(int hours) => '$hours小时';

  String oneDay(int days) => '$days天';

  String days(int days) => '$days天';
}

class EnInfo implements TimelineInfo {
  String suffixAgo() => ' ago';

  String suffixAfter() => ' after';

  String lessThanTenSecond() => 'just now';

  String customYesterday() => 'Yesterday';

  bool keepOneDay() => true;

  bool keepTwoDays() => true;

  String oneMinute(int minutes) => 'a minute';

  String minutes(int minutes) => '$minutes minutes';

  String anHour(int hours) => 'an hour';

  String hours(int hours) => '$hours hours';

  String oneDay(int days) => 'a day';

  String days(int days) => '$days days';
}

class ZhNormalInfo implements TimelineInfo {
  String suffixAgo() => '前';

  String suffixAfter() => '后';

  String lessThanTenSecond() => '刚刚';

  String customYesterday() => '昨天';

  bool keepOneDay() => true;

  bool keepTwoDays() => false;

  String oneMinute(int minutes) => '$minutes分钟';

  String minutes(int minutes) => '$minutes分钟';

  String anHour(int hours) => '$hours小时';

  String hours(int hours) => '$hours小时';

  String oneDay(int days) => '$days天';

  String days(int days) => '$days天';
}

class EnNormalInfo implements TimelineInfo {
  String suffixAgo() => ' ago';

  String suffixAfter() => ' after';

  String lessThanTenSecond() => 'just now';

  String customYesterday() => 'Yesterday';

  bool keepOneDay() => true;

  bool keepTwoDays() => false;

  String oneMinute(int minutes) => 'a minute';

  String minutes(int minutes) => '$minutes minutes';

  String anHour(int hours) => 'an hour';

  String hours(int hours) => '$hours hours';

  String oneDay(int days) => 'a day';

  String days(int days) => '$days days';
}

Map<String, TimelineInfo> _timelineInfoMap = {
  'zh': ZhInfo(),
  'en': EnInfo(),
  'zh_normal': ZhNormalInfo(), //keepTwoDays() => false
  'en_normal': EnNormalInfo(), //keepTwoDays() => false
};

///add custom configuration.
void setLocaleInfo(String locale, TimelineInfo timelineInfo) {
  assert(locale != null, '[locale] must not be null');
  assert(timelineInfo != null, '[timelineInfo] must not be null');
  _timelineInfoMap[locale] = timelineInfo;
}

/// TimelineUtil
class TimelineUtil {
  /// format time by DateTime.
  /// dateTime
  /// locDateTime: current time or schedule time.
  /// locale: output key.
  static String formatByDateTime(DateTime dateTime,
      {DateTime locDateTime, String locale, DayFormat dayFormat}) {
    int _locDateTime =
        (locDateTime == null ? null : locDateTime.millisecondsSinceEpoch);
    return format(dateTime.millisecondsSinceEpoch,
        locTimeMillis: _locDateTime, locale: locale, dayFormat: dayFormat);
  }

  /// format time by millis.
  /// dateTime : millis.
  /// locDateTime: current time or schedule time. millis.
  /// locale: output key.
  static String format(int timeMillis,
      {int locTimeMillis, String locale, DayFormat dayFormat}) {
    int _locTimeMillis = locTimeMillis ?? DateTime.now().millisecondsSinceEpoch;
    String _locale = locale ?? 'zh';
    TimelineInfo _info = _timelineInfoMap[_locale] ?? ZhInfo();
    DayFormat _dayFormat = dayFormat ?? DayFormat.Common;

    int elapsed = _locTimeMillis - timeMillis;
    String suffix;
    if (elapsed < 0) {
      elapsed = elapsed.abs();
      suffix = _info.suffixAfter();
      _dayFormat = DayFormat.Simple;
    } else {
      suffix = _info.suffixAgo();
    }

    String timeline;
    if (_info.customYesterday().isNotEmpty &&
        TimeUtils.isYesterdayByMillis(timeMillis, _locTimeMillis)) {
      return _getYesterday(timeMillis, _info, _dayFormat);
    }

    if (!TimeUtils.yearIsEqualByMillis(timeMillis, _locTimeMillis)) {
      timeline = _getYear(timeMillis, _dayFormat);
      if (timeline.isNotEmpty) return timeline;
    }

    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    if (seconds < 120) {
      timeline = _info.oneMinute(1);
      if (suffix != _info.suffixAfter() &&
          _info.lessThanTenSecond().isNotEmpty &&
          seconds < 10) {
        timeline = _info.lessThanTenSecond();
        suffix = "";
      }
    } else if (minutes < 60) {
      timeline = _info.minutes(minutes.round());
    } else if (hours < 24) {
      timeline = _info.hours(hours.round());
    } else {
      if ((days.round() == 1 && _info.keepOneDay() == true) ||
          (days.round() == 2 && _info.keepTwoDays() == true)) {
        _dayFormat = DayFormat.Simple;
      }
      timeline = _formatDays(timeMillis, days.round(), _info, _dayFormat);
      suffix = (_dayFormat == DayFormat.Simple ? suffix : "");
    }
    return timeline + suffix;
  }

  /// get Yesterday.
  /// 获取昨天.
  static String _getYesterday(
      int timeMillis, TimelineInfo info, DayFormat dayFormat) {
    return info.customYesterday() +
        (dayFormat == DayFormat.Full
            ? (" " +
                TimeUtils.getDateStrByMs(timeMillis,
                    format: DateFormat.HOUR_MINUTE))
            : "");
  }

  /// get is not year info.
  /// 获取非今年信息.
  static String _getYear(int timeMillis, DayFormat dayFormat) {
    if (dayFormat != DayFormat.Simple) {
      return TimeUtils.getDateStrByMs(timeMillis,
          format: (dayFormat == DayFormat.Common
              ? DateFormat.YEAR_MONTH_DAY
              : DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE));
    }
    return "";
  }

  /// format Days.
  static String _formatDays(int timeMillis, num days, TimelineInfo timelineInfo,
      DayFormat dayFormat) {
    String timeline;
    switch (dayFormat) {
      case DayFormat.Simple:
        timeline = (days == 1
            ? timelineInfo.oneDay(days.round())
            : timelineInfo.days(days.round()));
        break;
      case DayFormat.Common:
        timeline =
            TimeUtils.getDateStrByMs(timeMillis, format: DateFormat.MONTH_DAY);
        break;
      case DayFormat.Full:
        timeline = TimeUtils.getDateStrByMs(timeMillis,
            format: DateFormat.MONTH_DAY_HOUR_MINUTE);
        break;
    }
    return timeline;
  }
}
