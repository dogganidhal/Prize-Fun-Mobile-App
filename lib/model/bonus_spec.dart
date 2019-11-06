
enum BonusType {
  STAR,
  COIN
}

class BonusSpec {
  final double distance;
  final double y;
  final double width;
  final double height;
  final int value;
  final BonusType type;
  bool visible = true;

  BonusSpec({this.distance, this.y, this.width, this.height, this.type, this.value});

  factory BonusSpec.star({double distance, double y, int bonus}) => BonusSpec(
    distance: distance, y: y,
    width: 48, height: 48,
    value: bonus, type: BonusType.STAR
  );
}