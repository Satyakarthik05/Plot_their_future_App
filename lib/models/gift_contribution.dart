class GiftContribution {
  final String id;
  final String donorName;
  final String relationship;
  final int sqFt;
  final double amount;
  final String roomId;
  final String roomName;
  final String blessingMessage;
  final DateTime timestamp;
  final String deedToken;
  final String paymentMethod;

  const GiftContribution({
    required this.id,
    required this.donorName,
    required this.relationship,
    required this.sqFt,
    required this.amount,
    required this.roomId,
    required this.roomName,
    required this.blessingMessage,
    required this.timestamp,
    required this.deedToken,
    this.paymentMethod = "Simulated Card",
  });
}
