
enum ObstacleType {
  BOX
}

class ObstacleSpec {
  final double width;
  final double height;
  final double distance;
  final ObstacleType type;

  ObstacleSpec({
    this.distance, this.height, this.width,
    this.type = ObstacleType.BOX
  });

  factory ObstacleSpec.standardBox({double distance}) => ObstacleSpec(
    width: 48, height: 48,
    distance: distance, type: ObstacleType.BOX
  );
}