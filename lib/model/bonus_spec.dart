

enum BonusType {
  BEER,
  COIN
}

class BonusSpec {
  final double x;
  final double y;
  final double width;
  final double height;
  final BonusType type;

  BonusSpec({this.x, this.y, this.width, this.height, this.type});

  factory BonusSpec.fromJson(Map<String, dynamic> json) => BonusSpec(
    x: json["x"],
    y: json["y"],
    width: json["width"],
    height: json["height"],
    type: _type(json["type"])
  );

  static BonusType _type(String rawType) {
    for (final type in BonusType.values) {
      if (type.toString() == "BonusType.${rawType.toUpperCase()}}") {
        return type;
      }
    }
    return null;
  }
}