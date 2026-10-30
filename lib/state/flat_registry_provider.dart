import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../core/constants/app_constants.dart';
import '../models/gift_contribution.dart';
import '../models/room_model.dart';

class FlatRegistryState extends ChangeNotifier {
  bool _useINR = true;
  String _selectedRoomId = 'all';

  // Exact 2 BHK Room Cell Breakdown from Spec & Mocks
  List<RoomModel> _rooms = [
    const RoomModel(
      id: 'living_room',
      name: 'Living & Dining',
      totalSqFt: 400,
      giftedSqFt: 140,
      description: 'The vibrant heart of the home for morning chai, family gatherings, and festivals.',
      iconName: 'weekend_outlined',
      colorValue: 0xFFD4AF37,
      startTileIndex: 0,
    ),
    const RoomModel(
      id: 'master_bedroom',
      name: 'Master Bedroom',
      totalSqFt: 250,
      giftedSqFt: 200,
      description: 'A peaceful haven for restful nights and sweet dreams for the newlyweds.',
      iconName: 'king_bed_outlined',
      colorValue: 0xFFD4AF37,
      startTileIndex: 400,
    ),
    const RoomModel(
      id: 'balcony',
      name: 'Balcony',
      totalSqFt: 80,
      giftedSqFt: 80,
      description: 'Sunset vista and potted garden for evening breezes and endless conversations.',
      iconName: 'balcony_outlined',
      colorValue: 0xFFD4AF37,
      startTileIndex: 650,
    ),
    const RoomModel(
      id: 'kitchen',
      name: 'Kitchen',
      totalSqFt: 120,
      giftedSqFt: 0,
      description: 'Where traditional aroma and modern recipes combine to feed a happy life.',
      iconName: 'kitchen_outlined',
      colorValue: 0xFF64748B,
      startTileIndex: 730,
    ),
    const RoomModel(
      id: 'bedroom_2',
      name: 'Bedroom 2',
      totalSqFt: 200,
      giftedSqFt: 0,
      description: 'Comfortable guest sanctuary ensuring parents and relatives are always welcomed.',
      iconName: 'single_bed_outlined',
      colorValue: 0xFF64748B,
      startTileIndex: 850,
    ),
    const RoomModel(
      id: 'utility',
      name: 'Bathrooms & Utility',
      totalSqFt: 150,
      giftedSqFt: 0,
      description: 'Essential utility, smart storage, and refreshing wellness spaces.',
      iconName: 'bathtub_outlined',
      colorValue: 0xFF64748B,
      startTileIndex: 1050,
    ),
  ];

  // Authentic Pre-seeded contributions
  final List<GiftContribution> _contributions = [
    GiftContribution(
      id: 'contrib_1',
      donorName: 'Ramesh Varma & Family',
      relationship: 'Groom\'s Paternal Uncle',
      sqFt: 10,
      amount: 10 * AppConstants.ratePerSqFt,
      roomId: 'living_room',
      roomName: 'Living & Dining',
      blessingMessage: 'May your home be blessed with health, abundant joy, and harmony! So proud of Santosh and Sanvi.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      deedToken: 'PTF-ESC-89210',
      paymentMethod: 'UPI Confirmed',
    ),
    GiftContribution(
      id: 'contrib_2',
      donorName: 'Priya & Rahul Rao',
      relationship: 'Bride\'s Sister & Family',
      sqFt: 5,
      amount: 5 * AppConstants.ratePerSqFt,
      roomId: 'balcony',
      roomName: 'Balcony',
      blessingMessage: 'Gifting a breeze in your balcony for your morning coffees together! Lots of love.',
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      deedToken: 'PTF-ESC-77412',
      paymentMethod: 'UPI Confirmed',
    ),
    GiftContribution(
      id: 'contrib_3',
      donorName: 'Karthik & Tech College Friends',
      relationship: 'College Gang',
      sqFt: 10,
      amount: 10 * AppConstants.ratePerSqFt,
      roomId: 'living_room',
      roomName: 'Living & Dining',
      blessingMessage: 'Can\'t wait for weekend movie marathons and cricket matches on this living room couch!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      deedToken: 'PTF-ESC-66104',
      paymentMethod: 'UPI Confirmed',
    ),
  ];

  // Getters
  bool get useINR => _useINR;
  String get selectedRoomId => _selectedRoomId;
  List<RoomModel> get rooms => _rooms;
  List<GiftContribution> get contributions => List.unmodifiable(_contributions);

  int get totalSqFt => AppConstants.totalSqFt;
  int get totalGiftedSqFt => _rooms.fold(0, (sum, room) => sum + room.giftedSqFt);
  int get remainingSqFt => (totalSqFt - totalGiftedSqFt).clamp(0, totalSqFt);
  double get overallProgress => totalSqFt == 0 ? 0.0 : (totalGiftedSqFt / totalSqFt).clamp(0.0, 1.0);
  double get pricePerSqFt => AppConstants.ratePerSqFt;
  double get totalRaisedAmount => totalGiftedSqFt * pricePerSqFt;
  double get totalTargetAmount => totalSqFt * pricePerSqFt;
  int get totalContributors => _contributions.length + 12; // Includes pre-funded group donors

  void toggleCurrency() {
    _useINR = !_useINR;
    notifyListeners();
  }

  void selectRoom(String roomId) {
    _selectedRoomId = roomId;
    notifyListeners();
  }

  RoomModel? getRoomById(String id) {
    try {
      return _rooms.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }

  GiftContribution giftSqFt({
    required String donorName,
    required String relationship,
    required int sqFt,
    required String roomId,
    required String blessingMessage,
    String paymentMethod = "UPI Confirmed",
  }) {
    final effectiveRoomId = roomId == 'all' ? _rooms.first.id : roomId;
    final room = getRoomById(effectiveRoomId) ?? _rooms.first;

    // Update room allocation
    _rooms = _rooms.map((r) {
      if (r.id == room.id) {
        return r.copyWith(giftedSqFt: r.giftedSqFt + sqFt);
      }
      return r;
    }).toList();

    final deedToken = 'PTF-ESC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final newContribution = GiftContribution(
      id: 'contrib_${DateTime.now().millisecondsSinceEpoch}',
      donorName: donorName.trim().isEmpty ? 'Loving Guest' : donorName.trim(),
      relationship: relationship.trim().isEmpty ? 'Family & Friends' : relationship.trim(),
      sqFt: sqFt,
      amount: sqFt * pricePerSqFt,
      roomId: room.id,
      roomName: room.name,
      blessingMessage: blessingMessage.trim().isEmpty
          ? 'Hearty congratulations Sanvi & Santosh on your new beginning!'
          : blessingMessage.trim(),
      timestamp: DateTime.now(),
      deedToken: deedToken,
      paymentMethod: paymentMethod,
    );

    _contributions.insert(0, newContribution);
    notifyListeners();
    return newContribution;
  }
}

final flatRegistryProvider = ChangeNotifierProvider<FlatRegistryState>((ref) {
  return FlatRegistryState();
});
