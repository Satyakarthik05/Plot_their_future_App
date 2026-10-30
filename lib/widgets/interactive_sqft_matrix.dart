import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../models/gift_contribution.dart';
import '../models/room_model.dart';
import '../state/flat_registry_provider.dart';
import 'luxury_card.dart';

class InteractiveSqFtMatrixWidget extends ConsumerStatefulWidget {
  final Function(RoomModel, int sqFt) onGiftTileTapped;

  const InteractiveSqFtMatrixWidget({
    super.key,
    required this.onGiftTileTapped,
  });

  @override
  ConsumerState<InteractiveSqFtMatrixWidget> createState() => _InteractiveSqFtMatrixWidgetState();
}

class _InteractiveSqFtMatrixWidgetState extends ConsumerState<InteractiveSqFtMatrixWidget> {

  // Find which room owns tile index
  RoomModel? _getRoomForTile(int index, List<RoomModel> rooms) {
    for (final room in rooms) {
      if (index >= room.startTileIndex && index < (room.startTileIndex + room.totalSqFt)) {
        return room;
      }
    }
    return null;
  }

  // Check if tile is already gifted
  bool _isTileGifted(int index, RoomModel room) {
    final offset = index - room.startTileIndex;
    return offset < room.giftedSqFt;
  }

  // Find which contribution gifted this tile (simulated association)
  GiftContribution? _getContributionForTile(int index, RoomModel room, List<GiftContribution> contributions) {
    final roomContribs = contributions.where((c) => c.roomId == room.id).toList();
    if (roomContribs.isEmpty) return null;
    final hash = (index * 7) % roomContribs.length;
    return roomContribs[hash];
  }

  void _showTileDetailsModal(BuildContext context, int tileIndex, RoomModel room, bool isGifted, GiftContribution? contrib, FlatRegistryState registry) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: AppTheme.goldBorder, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 30,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(room.colorValue).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.grid_4x4, color: Color(room.colorValue), size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Square Foot #${tileIndex + 1}',
                            style: GoogleFonts.cinzel(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightGold,
                            ),
                          ),
                          Text(
                            room.name,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isGifted ? AppTheme.primaryGold.withOpacity(0.2) : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isGifted ? AppTheme.primaryGold : Colors.white30,
                      ),
                    ),
                    child: Text(
                      isGifted ? 'FOUNDATION GIFTED' : 'AVAILABLE TO CLAIM',
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isGifted ? AppTheme.primaryGold : Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (isGifted && contrib != null) ...[
                LuxuryCard(
                  backgroundColor: AppTheme.surfaceCard,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified, color: AppTheme.primaryGold, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Gifted with Love by',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        contrib.donorName,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        contrib.relationship,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppTheme.lightGold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.format_quote, color: AppTheme.primaryGold, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '"${contrib.blessingMessage}"',
                                style: GoogleFonts.outfit(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deed Token: ${contrib.deedToken}',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            Formatters.formatDateShort(contrib.timestamp),
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ] else ...[
                LuxuryCard(
                  backgroundColor: AppTheme.surfaceCard,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This square foot is currently waiting for your blessing!',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Lay your brick into Aarav & Meera\'s future home. Your name and blessing will be permanently minted on this tile.',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: AppTheme.textMuted,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cost for 1 sq.ft:',
                            style: GoogleFonts.outfit(fontSize: 14, color: AppTheme.textLight),
                          ),
                          Text(
                            Formatters.formatCurrency(registry.pricePerSqFt, inINR: registry.useINR),
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightGold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onGiftTileTapped(room, 1);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGold,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                    ),
                    child: Text(
                      'Gift This Square Foot (${Formatters.formatCurrency(registry.pricePerSqFt, inINR: registry.useINR)})',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(flatRegistryProvider);
    final rooms = registry.rooms;

    // Total tiles displayed: 1200 sq.ft.
    const totalTiles = 1200;

    return LuxuryCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LIVE 1,200 SQ.FT. BLUEPRINT MATRIX',
                    style: GoogleFonts.cinzel(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tap any tile to inspect blessings or gift that spot',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.goldBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.touch_app, color: AppTheme.primaryGold, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Interactive',
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: AppTheme.lightGold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Legend
          Wrap(
            spacing: 10,
            runSpacing: 6,
            children: [
              _buildLegendItem('Gifted Sq.Ft.', AppTheme.primaryGold, true),
              _buildLegendItem('Living (350)', const Color(0xFFD4AF37), false),
              _buildLegendItem('Master (300)', const Color(0xFFE2847A), false),
              _buildLegendItem('Kitchen (200)', const Color(0xFF10B981), false),
              _buildLegendItem('Study (150)', const Color(0xFF6366F1), false),
              _buildLegendItem('Guest (200)', const Color(0xFFF59E0B), false),
              _buildLegendItem('Available', const Color(0xFF28354A), false),
            ],
          ),
          const SizedBox(height: 16),

          // The Matrix Grid View (Fixed height with scroll or neat wrap)
          Container(
            height: 260,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0C111C),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.goldBorder.withOpacity(0.5)),
            ),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 30, // 30 columns x 40 rows = 1200 tiles
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: totalTiles,
              itemBuilder: (context, index) {
                final room = _getRoomForTile(index, rooms) ?? rooms.first;
                final isGifted = _isTileGifted(index, room);
                final tileColor = isGifted ? Color(room.colorValue) : const Color(0xFF1E2838);

                return InkWell(
                  onTap: () {
                    final contrib = _getContributionForTile(index, room, registry.contributions);
                    _showTileDetailsModal(context, index, room, isGifted, contrib, registry);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: tileColor,
                      borderRadius: BorderRadius.circular(1.5),
                      boxShadow: isGifted
                          ? [
                              BoxShadow(
                                color: tileColor.withOpacity(0.4),
                                blurRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: 1,200 sq.ft. (1 tile = 1 sq.ft.)',
                style: GoogleFonts.outfit(fontSize: 11, color: AppTheme.textMuted),
              ),
              Text(
                '${registry.remainingSqFt} sq.ft. remaining',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, bool isGoldDot) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 11,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }
}
