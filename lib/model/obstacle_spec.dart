
enum ObstacleType {
  TABLE,
  GUARD
}


class ObstacleSpec {
  final double width;
  final double height;
  final ObstacleType type;

  ObstacleSpec({this.height, this.width, this.type});

  factory ObstacleSpec.fromJson(Map<String, dynamic> json) => ObstacleSpec(
    width: json["column"],
    height: json["height"],
    type: _type(json["type"])
  );

  static ObstacleType _type(String rawType) {
    for (final type in ObstacleType.values) {
      if (type.toString() == "ObstacleType.${rawType.toUpperCase()}}") {
        return type;
      }
    }
    return null;
  }
}