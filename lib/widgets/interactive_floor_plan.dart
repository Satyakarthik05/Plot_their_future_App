import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../models/room_model.dart';
import '../state/flat_registry_provider.dart';
import 'luxury_card.dart';

class InteractiveFloorPlanWidget extends ConsumerWidget {
  final Function(RoomModel) onGiftRoomTapped;

  const InteractiveFloorPlanWidget({
    super.key,
    required this.onGiftRoomTapped,
  });

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'weekend_outlined':
        return Icons.weekend_outlined;
      case 'king_bed_outlined':
        return Icons.king_bed_outlined;
      case 'kitchen_outlined':
        return Icons.kitchen_outlined;
      case 'menu_book_outlined':
        return Icons.menu_book_outlined;
      case 'balcony_outlined':
        return Icons.balcony_outlined;
      default:
        return Icons.meeting_room_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(flatRegistryProvider);
    final selectedRoom = registry.getRoomById(registry.selectedRoomId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Architectural Image Container with interactive badge
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.goldBorder, width: 1.5),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Image.asset(
                  AppConstants.floorPlanImagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Top Badge
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppTheme.primaryGold.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.architecture, color: AppTheme.primaryGold, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      '3-BHK Architectural Blueprint • 1,200 sq.ft.',
                      style: GoogleFonts.outfit(
                        color: AppTheme.lightGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom stats pill
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.darkSurface.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.goldBorder),
                    ),
                    child: Text(
                      'Unit 14B • 14th Floor Skyline Views',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppTheme.goldGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${Formatters.formatPercentage(registry.overallProgress)} Gifted',
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Room Selector Horizontal Tabs
        Text(
          'EXPLORE ROOMS & SPACES',
          style: GoogleFonts.outfit(
            fontSize: 12,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: AppTheme.lightGold,
          ),
        ),
        const SizedBox(height: 10),

        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: registry.rooms.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isSelected = registry.selectedRoomId == 'all';
                return _buildFilterChip(
                  label: 'All Rooms (1,200 sqft)',
                  icon: Icons.dashboard_outlined,
                  isSelected: isSelected,
                  onTap: () => registry.selectRoom('all'),
                );
              }
              final room = registry.rooms[index - 1];
              final isSelected = registry.selectedRoomId == room.id;
              return _buildFilterChip(
                label: room.name.split('&').first.trim(),
                icon: _getIconData(room.iconName),
                isSelected: isSelected,
                onTap: () => registry.selectRoom(room.id),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // Room Detail Cards or All Rooms Cards
        if (selectedRoom != null)
          _buildSingleRoomCard(context, selectedRoom, registry)
        else
          ...registry.rooms.map((room) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildSingleRoomCard(context, room, registry),
              )),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGold : AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGold : AppTheme.goldBorder,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.black : AppTheme.lightGold,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleRoomCard(BuildContext context, RoomModel room, FlatRegistryState registry) {
    final roomColor = Color(room.colorValue);

    return LuxuryCard(
      borderColor: roomColor.withOpacity(0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: roomColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: roomColor.withOpacity(0.4)),
                ),
                child: Icon(_getIconData(room.iconName), color: roomColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      room.description,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Progress and stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${room.giftedSqFt}',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightGold,
                      ),
                    ),
                    TextSpan(
                      text: ' / ${room.totalSqFt} sq.ft. gifted',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: roomColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: roomColor.withOpacity(0.3)),
                ),
                child: Text(
                  '${room.remainingSqFt} sq.ft. left',
                  style: GoogleFonts.outfit(
                    color: roomColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: room.progressPercentage,
              minHeight: 8,
              backgroundColor: const Color(0xFF232D42),
              valueColor: AlwaysStoppedAnimation<Color>(roomColor),
            ),
          ),
          const SizedBox(height: 16),

          // Action row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${Formatters.formatCurrency(room.giftedSqFt * registry.pricePerSqFt, inINR: registry.useINR)} raised',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.lightGold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => onGiftRoomTapped(room),
                icon: const Icon(Icons.card_giftcard, size: 16, color: Colors.black),
                label: Text(
                  'Gift This Room',
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
