import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import '../models/room_model.dart';
import '../state/flat_registry_provider.dart';
import '../widgets/gift_sqft_sheet.dart';

class FloorPlanScreen extends ConsumerStatefulWidget {
  const FloorPlanScreen({super.key});

  @override
  ConsumerState<FloorPlanScreen> createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends ConsumerState<FloorPlanScreen> {
  int _selectedPresetSft = 5;
  final TextEditingController _customSftController = TextEditingController();

  @override
  void dispose() {
    _customSftController.dispose();
    super.dispose();
  }

  void _openGiftSheet(RoomModel? room) {
    int sqFtToGift = _selectedPresetSft;
    if (_customSftController.text.trim().isNotEmpty) {
      final parsed = int.tryParse(_customSftController.text.trim());
      if (parsed != null && parsed > 0) {
        sqFtToGift = parsed;
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GiftSqFtSheet(
        initialRoom: room,
        initialSqFt: sqFtToGift,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(flatRegistryProvider);

    return Scaffold(
      backgroundColor: AppTheme.ivoryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.ivoryBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.crimsonMaroon, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Plot Their Future',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: AppTheme.royalGold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppTheme.crimsonMaroon),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Header
            Text(
              'Interactive 2 BHK Floor Plan',
              style: GoogleFonts.playfairDisplay(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '1,200 SFT Target • Rate: ₹4,500 / Sq.Ft.',
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // 2D ARCHITECTURAL BLUEPRINT (Exact Replica of WhatsApp Screen 03)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFDFBF7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD6C28F), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Top Balcony & Master Bedroom Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 3),
                      // Balcony (80 SFT - Funded)
                      Expanded(
                        flex: 4,
                        child: _buildRoomBlueprintBox(
                          title: 'Balcony',
                          sft: '80 SFT',
                          cost: '₹3,60,000',
                          isFunded: true,
                          showFundedBadge: true,
                          gridRows: 2,
                          gridCols: 4,
                          onTap: () => _openGiftSheet(registry.getRoomById('balcony')),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Master Bedroom (250 SFT - Funded)
                      Expanded(
                        flex: 6,
                        child: _buildRoomBlueprintBox(
                          title: 'Master Bedroom',
                          sft: '250 SFT',
                          cost: '₹11,25,000',
                          isFunded: true,
                          showFundedBadge: true,
                          gridRows: 3,
                          gridCols: 4,
                          onTap: () => _openGiftSheet(registry.getRoomById('master_bedroom')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Middle Row: Living & Dining
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Living & Dining (400 SFT - Partially Funded)
                      Expanded(
                        flex: 5,
                        child: _buildLivingRoomBlueprintBox(
                          title: 'Living & Dining',
                          sft: '400 SFT',
                          cost: '₹18,00,000',
                          fundedCells: 14,
                          totalCells: 24,
                          onTap: () => _openGiftSheet(registry.getRoomById('living_room')),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Kitchen & Bedroom 2 Stack
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            // Kitchen (120 SFT - Available)
                            _buildRoomBlueprintBox(
                              title: 'Kitchen',
                              sft: '120 SFT',
                              cost: '₹5,40,000',
                              isFunded: false,
                              showFundedBadge: false,
                              gridRows: 2,
                              gridCols: 3,
                              onTap: () => _openGiftSheet(registry.getRoomById('kitchen')),
                            ),
                            const SizedBox(height: 8),
                            // Bedroom 2 (200 SFT - Available)
                            _buildRoomBlueprintBox(
                              title: 'Bedroom 2',
                              sft: '200 SFT',
                              cost: '₹9,00,000',
                              isFunded: false,
                              showFundedBadge: false,
                              gridRows: 2,
                              gridCols: 3,
                              onTap: () => _openGiftSheet(registry.getRoomById('bedroom_2')),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Bottom Row: Bathrooms & Utility
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildRoomBlueprintBox(
                          title: 'Bathrooms & Utility',
                          sft: '150 SFT',
                          cost: '₹6,75,000',
                          isFunded: false,
                          showFundedBadge: false,
                          gridRows: 1,
                          gridCols: 4,
                          onTap: () => _openGiftSheet(registry.getRoomById('utility')),
                        ),
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Legend Row (Exact from WhatsApp Mock)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8C252),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Text('Funded', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
                const SizedBox(width: 20),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                ),
                const SizedBox(width: 6),
                Text('Available', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
              ],
            ),
            const SizedBox(height: 12),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: registry.overallProgress,
                minHeight: 10,
                backgroundColor: const Color(0xFFE2E8F0),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.royalGold),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${registry.totalGiftedSqFt} / ${registry.totalSqFt} SFT Funded (${(registry.overallProgress * 100).toStringAsFixed(0)}%)',
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.crimsonMaroon,
              ),
            ),
            const SizedBox(height: 18),

            // BOTTOM SHEET: SELECT AREA TO GIFT (Exact from Mock)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEBDAB0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select Area to Gift',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 3 Preset Buttons
                  Row(
                    children: [
                      _buildPresetChip(1, '1 SFT', '(₹4,500)'),
                      const SizedBox(width: 8),
                      _buildPresetChip(5, '5 SFT', '(₹22,500)'),
                      const SizedBox(width: 8),
                      _buildPresetChip(10, '10 SFT', '(₹45,000)'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Custom SFT Input
                  Row(
                    children: [
                      Text(
                        'Custom SFT',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: TextField(
                          controller: _customSftController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            hintText: 'Enter Sq.Ft.',
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Gift This Space Button (Deep Crimson)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => _openGiftSheet(null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.crimsonMaroon,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 4,
                      ),
                      child: Text(
                        'Gift This Space',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetChip(int sft, String label, String price) {
    final isSelected = _selectedPresetSft == sft && _customSftController.text.isEmpty;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPresetSft = sft;
            _customSftController.clear();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFAF3DC) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.royalGold : const Color(0xFFDCD5C5),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              Text(
                price,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: AppTheme.crimsonMaroon,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomBlueprintBox({
    required String title,
    required String sft,
    required String cost,
    required bool isFunded,
    required bool showFundedBadge,
    required int gridRows,
    required int gridCols,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isFunded ? const Color(0xFFF3D26A) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF6B5824), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showFundedBadge)
              Text(
                'Funded',
                style: GoogleFonts.outfit(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5B3900),
                ),
              ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            Text(
              sft,
              style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF334155)),
            ),
            Text(
              cost,
              style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF1E232A)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLivingRoomBlueprintBox({
    required String title,
    required String sft,
    required String cost,
    required int fundedCells,
    required int totalCells,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF6B5824), width: 1.2),
        ),
        child: Stack(
          children: [
            // Internal Grid Cells
            Positioned.fill(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemCount: totalCells,
                itemBuilder: (context, index) {
                  final isFundedCell = index < fundedCells;
                  return Container(
                    decoration: BoxDecoration(
                      color: isFundedCell ? const Color(0xFFF3D26A) : const Color(0xFFFDFBF7),
                      border: Border.all(color: const Color(0xFFD6C28F).withOpacity(0.5), width: 0.5),
                    ),
                  );
                },
              ),
            ),
            // Text Label Overlay
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.royalGold.withOpacity(0.5)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E232A),
                      ),
                    ),
                    Text(
                      sft,
                      style: GoogleFonts.outfit(fontSize: 10, color: const Color(0xFF334155)),
                    ),
                    Text(
                      cost,
                      style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.crimsonMaroon),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
