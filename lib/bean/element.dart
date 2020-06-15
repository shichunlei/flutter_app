import 'dart:ui';

/// number : 1
/// name : "Hydrogen"
/// symbol : "H"
/// extract : "Hydrogen is a chemical element with symbol H and atomic number 1. With a standard atomic weight of 1.008, hydrogen is the lightest element in the periodic table. Its monatomic form (H) is the most abundant chemical substance in the Universe, constituting roughly 75% of all baryonic mass. Non-remnant stars are mainly composed of hydrogen in the plasma state. The most common isotope of hydrogen, termed protium (name rarely used, symbol 1H), has one proton and no neutrons."
/// source : "https://en.wikipedia.org/wiki/Hydrogen"
/// category : "Reactive Nonmetal"
/// atomic_weight : "1.008 u(±)"
/// colors : [4283657726,4287535603]

class ElementData {
  int number;
  String name;
  String symbol;
  String extract;
  String source;
  String category;
  String atomicWeight;
  List<Color> colors;

  static ElementData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ElementData elementBean = ElementData();
    elementBean.number = map['number'];
    elementBean.name = map['name'];
    elementBean.symbol = map['symbol'];
    elementBean.extract = map['extract'];
    elementBean.source = map['source'];
    elementBean.category = map['category'];
    elementBean.atomicWeight = map['atomic_weight'];
    elementBean.colors = List()
      ..addAll((map['colors'] as List ?? []).map((o) => Color(o)));
    return elementBean;
  }

  Map toJson() => {
        "number": number,
        "name": name,
        "symbol": symbol,
        "extract": extract,
        "source": source,
        "category": category,
        "atomic_weight": atomicWeight,
        "colors": colors,
      };

  static List<ElementData> fromMapList(dynamic mapList) {
    List<ElementData> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
