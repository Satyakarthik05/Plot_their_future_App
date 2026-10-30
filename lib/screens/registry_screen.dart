import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../models/room_model.dart';
import '../state/flat_registry_provider.dart';
import '../widgets/gift_sqft_sheet.dart';
import '../widgets/interactive_floor_plan.dart';
import '../widgets/interactive_sqft_matrix.dart';
import '../widgets/luxury_card.dart';

class RegistryScreen extends ConsumerStatefulWidget {
  const RegistryScreen({super.key});

  @override
  ConsumerState<RegistryScreen> createState() => _RegistryScreenState();
}

class _RegistryScreenState extends ConsumerState<RegistryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openGiftSheet({RoomModel? room, int sqFt = 5}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GiftSqFtSheet(
        initialRoom: room,
        initialSqFt: sqFt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(flatRegistryProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PROPERTY TITLE & OVERVIEW CARD
          LuxuryCard(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        AppConstants.flatImagePath,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.primaryGold),
                        ),
                        child: InkWell(
                          onTap: () => registry.toggleCurrency(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.currency_exchange, color: AppTheme.primaryGold, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                registry.useINR ? 'Currency: INR (₹)' : 'Currency: USD (\$)',
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.lightGold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 14,
                      right: 14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.propertyName,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${AppConstants.propertyUnit} • ${AppConstants.propertyLocation}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppTheme.lightGold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Overall Progress Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OVERALL REGISTRY PROGRESS',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMuted,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${registry.totalGiftedSqFt}',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.lightGold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' / ${registry.totalSqFt} sq.ft. gifted',
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        color: AppTheme.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'TOTAL VALUATION',
                                style: GoogleFonts.outfit(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMuted,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                Formatters.formatCurrency(registry.totalRaisedAmount, inINR: registry.useINR),
                                style: GoogleFonts.cinzel(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accentEmerald,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Animated Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: registry.overallProgress,
                          minHeight: 12,
                          backgroundColor: const Color(0xFF222B3D),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Formatters.formatPercentage(registry.overallProgress)} of flat gifted',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.lightGold,
                            ),
                          ),
                          Text(
                            '${registry.remainingSqFt} sq.ft. needed to complete',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // QUICK GIFT PACKAGES ROW
          Text(
            'QUICK GIFT TIERS',
            style: GoogleFonts.cinzel(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildQuickPackageCard('1 sq.ft.', 'A Foundation Stone', 1, registry),
                _buildQuickPackageCard('5 sq.ft.', 'Cozy Room Corner', 5, registry),
                _buildQuickPackageCard('10 sq.ft.', 'Sunlit Breakfast Nook', 10, registry),
                _buildQuickPackageCard('25 sq.ft.', 'Sunset Balcony Vista', 25, registry),
                _buildQuickPackageCard('50 sq.ft.', 'Master Bedroom Suite', 50, registry),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // TOGGLE TABS: 3D FLOOR PLAN vs 1,200 MATRIX
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.goldBorder),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: AppTheme.lightGold,
              labelStyle: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.outfit(fontSize: 13),
              tabs: const [
                Tab(
                  icon: Icon(Icons.architecture, size: 18),
                  text: '3D Floor Plan',
                ),
                Tab(
                  icon: Icon(Icons.grid_on, size: 18),
                  text: '1,200 Blueprint Grid',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // TAB CONTENT
          if (_tabController.index == 0)
            InteractiveFloorPlanWidget(
              onGiftRoomTapped: (room) => _openGiftSheet(room: room, sqFt: 5),
            )
          else
            InteractiveSqFtMatrixWidget(
              onGiftTileTapped: (room, sqFt) => _openGiftSheet(room: room, sqFt: sqFt),
            ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildQuickPackageCard(String title, String subtitle, int sqFt, FlatRegistryState registry) {
    final cost = sqFt * registry.pricePerSqFt;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () => _openGiftSheet(sqFt: sqFt),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 145,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.goldBorder.withOpacity(0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cinzel(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGold,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: AppTheme.primaryGold, size: 12),
                ],
              ),
              Text(
                subtitle,
                style: GoogleFonts.outfit(fontSize: 10, color: AppTheme.textMuted),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                Formatters.formatCurrency(cost, inINR: registry.useINR),
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentEmerald,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
