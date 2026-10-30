import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/rsvp_model.dart';

class RSVPState extends ChangeNotifier {
  final List<RSVPModel> _rsvps = [
    RSVPModel(
      id: 'rsvp_1',
      guestName: 'Anil & Meenakshi Verma',
      email: 'anil.verma@example.com',
      phone: '+1 408-555-0199',
      partySize: 2,
      attendanceStatus: 'Attending',
      attendingEventIds: ['sangeet', 'ceremony', 'reception'],
      dietaryPreference: 'Vegetarian',
      note: 'We cannot wait to celebrate this auspicious union with your families!',
      submittedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    RSVPModel(
      id: 'rsvp_2',
      guestName: 'David & Sarah Chen',
      email: 'david.chen@example.com',
      phone: '+1 650-555-0284',
      partySize: 2,
      attendanceStatus: 'Attending',
      attendingEventIds: ['ceremony', 'reception'],
      dietaryPreference: 'Vegan',
      note: 'Heartiest congratulations Aarav & Meera! So thrilled for you both.',
      submittedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  List<RSVPModel> get rsvps => List.unmodifiable(_rsvps);
  int get totalAttendingGuests => _rsvps.fold(0, (sum, r) => r.attendanceStatus == 'Attending' ? sum + r.partySize : sum);

  void submitRSVP({
    required String guestName,
    required String email,
    required String phone,
    required int partySize,
    required String attendanceStatus,
    required List<String> attendingEventIds,
    required String dietaryPreference,
    required String note,
  }) {
    final newRSVP = RSVPModel(
      id: 'rsvp_${DateTime.now().millisecondsSinceEpoch}',
      guestName: guestName,
      email: email,
      phone: phone,
      partySize: partySize,
      attendanceStatus: attendanceStatus,
      attendingEventIds: attendingEventIds,
      dietaryPreference: dietaryPreference,
      note: note,
      submittedAt: DateTime.now(),
    );
    _rsvps.insert(0, newRSVP);
    notifyListeners();
  }
}

final rsvpProvider = ChangeNotifierProvider<RSVPState>((ref) {
  return RSVPState();
});
