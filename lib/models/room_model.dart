class RoomModel {
  final String id;
  final String name;
  final int totalSqFt;
  final int giftedSqFt;
  final String description;
  final String iconName;
  final int colorValue;
  final int startTileIndex;

  const RoomModel({
    required this.id,
    required this.name,
    required this.totalSqFt,
    required this.giftedSqFt,
    required this.description,
    required this.iconName,
    required this.colorValue,
    required this.startTileIndex,
  });

  int get remainingSqFt => (totalSqFt - giftedSqFt).clamp(0, totalSqFt);
  double get progressPercentage => totalSqFt == 0 ? 0.0 : (giftedSqFt / totalSqFt).clamp(0.0, 1.0);
  bool get isFullyGifted => giftedSqFt >= totalSqFt;

  RoomModel copyWith({
    String? id,
    String? name,
    int? totalSqFt,
    int? giftedSqFt,
    String? description,
    String? iconName,
    int? colorValue,
    int? startTileIndex,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      totalSqFt: totalSqFt ?? this.totalSqFt,
      giftedSqFt: giftedSqFt ?? this.giftedSqFt,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      colorValue: colorValue ?? this.colorValue,
      startTileIndex: startTileIndex ?? this.startTileIndex,
    );
  }
}
