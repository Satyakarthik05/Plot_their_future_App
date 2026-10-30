import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../models/room_model.dart';
import '../state/flat_registry_provider.dart';
import 'deed_certificate_modal.dart';

class GiftSqFtSheet extends ConsumerStatefulWidget {
  final RoomModel? initialRoom;
  final int initialSqFt;

  const GiftSqFtSheet({
    super.key,
    this.initialRoom,
    this.initialSqFt = 5,
  });

  @override
  ConsumerState<GiftSqFtSheet> createState() => _GiftSqFtSheetState();
}

class _GiftSqFtSheetState extends ConsumerState<GiftSqFtSheet> {
  late int _selectedSqFt;
  late String _selectedRoomId;
  final _nameController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _blessingController = TextEditingController();
  String _selectedPaymentMethod = 'Apple Pay / Google Pay';
  bool _isSubmitting = false;

  final List<int> _presetOptions = [1, 5, 10, 25, 50];
  final List<String> _relationshipSuggestions = [
    'College Bestie',
    'Bride\'s Family',
    'Groom\'s Family',
    'Colleague',
    'Childhood Friend',
  ];

  final List<String> _blessingSuggestions = [
    'May your home be overflowing with love, peace, and endless chai!',
    'Here is to late-night laughter, cozy movie nights, and warm memories.',
    'Wishing you both lifetime harmony in your beautiful forever home.',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSqFt = widget.initialSqFt;
    _selectedRoomId = widget.initialRoom?.id ?? 'living_room';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationshipController.dispose();
    _blessingController.dispose();
    super.dispose();
  }

  void _handleCompleteGift() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name so the couple knows who to thank!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    final registry = ref.read(flatRegistryProvider);
    final contribution = registry.giftSqFt(
      donorName: _nameController.text.trim(),
      relationship: _relationshipController.text.trim().isEmpty ? 'Loving Guest' : _relationshipController.text.trim(),
      sqFt: _selectedSqFt,
      roomId: _selectedRoomId,
      blessingMessage: _blessingController.text.trim().isEmpty
          ? 'Wishing you both boundless happiness and a lifetime of love!'
          : _blessingController.text.trim(),
      paymentMethod: _selectedPaymentMethod,
    );

    if (!mounted) return;

    Navigator.of(context).pop(); // Close sheet

    // Show celebratory Deed Certificate Modal
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => DeedCertificateModal(contribution: contribution),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(flatRegistryProvider);
    final double currentCost = (_selectedSqFt * registry.pricePerSqFt).toDouble();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1424),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border.all(color: AppTheme.goldBorder, width: 1.5),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GIFT SQUARE FOOTAGE',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cinzel(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        'Lay a foundation stone in their forever home',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white70),
                ),
              ],
            ),
            const Divider(color: Color(0xFF1E293B), height: 24),

            // STEP 1: Select SqFt
            Text(
              '1. SELECT SQUARE FEET TO GIFT',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),

            // Preset options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _presetOptions.map((sqFt) {
                final isSelected = _selectedSqFt == sqFt;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: InkWell(
                      onTap: () => setState(() => _selectedSqFt = sqFt),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryGold : AppTheme.surfaceCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryGold : AppTheme.goldBorder,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$sqFt',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.white,
                              ),
                            ),
                            Text(
                              'sq.ft.',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                color: isSelected ? Colors.black87 : AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),

            // Stepper / Counter Row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.goldBorder.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Custom Sq.Ft.:',
                      style: GoogleFonts.outfit(color: AppTheme.textMuted, fontSize: 13),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        onPressed: _selectedSqFt > 1
                            ? () => setState(() => _selectedSqFt--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.primaryGold, size: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '$_selectedSqFt sq.ft.',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightGold,
                          ),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        onPressed: _selectedSqFt < registry.remainingSqFt
                            ? () => setState(() => _selectedSqFt++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline, color: AppTheme.primaryGold, size: 22),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // STEP 2: Select Room
            Text(
              '2. DEDICATE TO ROOM',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.goldBorder.withOpacity(0.5)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: AppTheme.darkSurface,
                  value: _selectedRoomId,
                  items: registry.rooms.map((room) {
                    return DropdownMenuItem<String>(
                      value: room.id,
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(room.colorValue),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${room.name} (${room.remainingSqFt} sq.ft. left)',
                              style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedRoomId = val);
                  },
                ),
              ),
            ),
            const SizedBox(height: 18),

            // STEP 3: Guest Info
            Text(
              '3. YOUR DETAILS',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Your Full Name (e.g., Rohan & Neha)',
                prefixIcon: Icon(Icons.person_outline, color: AppTheme.primaryGold, size: 20),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _relationshipController,
              decoration: const InputDecoration(
                hintText: 'Relationship (e.g., College Bestie, Cousin)',
                prefixIcon: Icon(Icons.people_outline, color: AppTheme.primaryGold, size: 20),
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: _relationshipSuggestions.map((rel) {
                return InkWell(
                  onTap: () => setState(() => _relationshipController.text = rel),
                  child: Chip(
                    label: Text(rel, style: GoogleFonts.outfit(fontSize: 10, color: AppTheme.textMuted)),
                    backgroundColor: const Color(0xFF141C2E),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // STEP 4: Blessing Note
            Text(
              '4. HEARTFELT BLESSING & WISH',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _blessingController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Write a warm blessing to be forever pinned to their home deed...',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Icon(Icons.favorite_border, color: AppTheme.primaryGold, size: 20),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: _blessingSuggestions.map((bless) {
                return InkWell(
                  onTap: () => setState(() => _blessingController.text = bless),
                  child: Chip(
                    label: Text(
                      bless.length > 32 ? '${bless.substring(0, 32)}...' : bless,
                      style: GoogleFonts.outfit(fontSize: 10, color: AppTheme.lightGold.withOpacity(0.8)),
                    ),
                    backgroundColor: const Color(0xFF141C2E),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),

            // STEP 5: Payment Method
            Text(
              '5. SIMULATED PAYMENT METHOD',
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: ['Apple Pay / Google Pay', 'Credit / Debit Card', 'UPI'].map((method) {
                final isSelected = _selectedPaymentMethod == method;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: InkWell(
                      onTap: () => setState(() => _selectedPaymentMethod = method),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryGold.withOpacity(0.15) : AppTheme.surfaceCard,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? AppTheme.primaryGold : Colors.white12,
                          ),
                        ),
                        child: Text(
                          method,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppTheme.lightGold : AppTheme.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Total and Checkout Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2D),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.goldBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'TOTAL FOUNDATION GIFT',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textMuted,
                            letterSpacing: 0.8,
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Formatters.formatCurrency(currentCost, inINR: registry.useINR),
                            style: GoogleFonts.cinzel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightGold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _handleCompleteGift,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGold,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 6,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                          )
                        : Text(
                            'Gift & Mint Deed',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
