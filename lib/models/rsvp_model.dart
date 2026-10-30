class RSVPModel {
  final String id;
  final String guestName;
  final String email;
  final String phone;
  final int partySize;
  final String attendanceStatus; // 'Attending', 'Declined', 'Undecided'
  final List<String> attendingEventIds;
  final String dietaryPreference;
  final String note;
  final DateTime submittedAt;

  const RSVPModel({
    required this.id,
    required this.guestName,
    required this.email,
    required this.phone,
    required this.partySize,
    required this.attendanceStatus,
    required this.attendingEventIds,
    required this.dietaryPreference,
    required this.note,
    required this.submittedAt,
  });
}
