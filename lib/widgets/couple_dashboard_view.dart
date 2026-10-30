import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../state/flat_registry_provider.dart';
import '../state/rsvp_provider.dart';
import 'luxury_card.dart';

class CoupleDashboardView extends ConsumerWidget {
  const CoupleDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(flatRegistryProvider);
    final rsvp = ref.watch(rsvpProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Couple Header
          LuxuryCard(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E2638), Color(0xFF131926)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderColor: AppTheme.primaryGold,
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryGold, width: 2),
                    image: const DecorationImage(
                      image: AssetImage(AppConstants.coupleImagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aarav & Meera\'s Sanctuary',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Couple\'s Foundation & RSVP Dashboard',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryGold),
                  ),
                  child: Text(
                    'COUPLE VIEW',
                    style: GoogleFonts.outfit(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Key Metrics Grid
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'SQ.FT. FUNDED',
                  value: '${registry.totalGiftedSqFt}',
                  subtitle: 'out of 1,200 sq.ft.',
                  progress: registry.overallProgress,
                  icon: Icons.square_foot,
                  color: AppTheme.primaryGold,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'TOTAL RAISED',
                  value: Formatters.formatCurrency(registry.totalRaisedAmount, inINR: registry.useINR),
                  subtitle: 'Goal: ${Formatters.formatCurrency(registry.totalTargetAmount, inINR: registry.useINR)}',
                  progress: registry.overallProgress,
                  icon: Icons.account_balance_wallet_outlined,
                  color: AppTheme.accentEmerald,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  title: 'CONTRIBUTORS',
                  value: '${registry.totalContributors}',
                  subtitle: 'Loving family & friends',
                  progress: 0.8,
                  icon: Icons.people_alt_outlined,
                  color: AppTheme.accentRose,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard(
                  title: 'RSVP GUESTS',
                  value: '${rsvp.totalAttendingGuests}',
                  subtitle: '${rsvp.rsvps.length} confirmations',
                  progress: 0.9,
                  icon: Icons.mail_outline,
                  color: const Color(0xFF6366F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Room Breakdown Progress
          Text(
            'ROOM-BY-ROOM FUNDING BREAKDOWN',
            style: GoogleFonts.cinzel(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          LuxuryCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: registry.rooms.map((room) {
                final color = Color(room.colorValue);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            room.name,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${room.giftedSqFt}/${room.totalSqFt} sq.ft. (${Formatters.formatPercentage(room.progressPercentage)})',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: room.progressPercentage,
                          minHeight: 7,
                          backgroundColor: const Color(0xFF222B3D),
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),

          // RSVP Overview Card
          Text(
            'GUEST ATTENDANCE & DIETARY SUMMARY',
            style: GoogleFonts.cinzel(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          LuxuryCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRSVPStat('${rsvp.totalAttendingGuests}', 'Attending', AppTheme.accentEmerald),
                    _buildRSVPStat('${rsvp.rsvps.length}', 'Responses', AppTheme.primaryGold),
                    _buildRSVPStat('3', 'Ceremonies', Colors.white70),
                  ],
                ),
                const Divider(color: Color(0xFF253047), height: 24),
                Text(
                  'Recent RSVPs:',
                  style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.lightGold),
                ),
                const SizedBox(height: 8),
                ...rsvp.rsvps.map((r) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${r.guestName} (${r.partySize} guests)',
                            style: GoogleFonts.outfit(fontSize: 13, color: Colors.white),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.accentEmerald.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              r.dietaryPreference,
                              style: GoogleFonts.outfit(fontSize: 10, color: AppTheme.accentEmerald),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Thank you cards queued for ${registry.totalContributors} foundation donors!',
                          style: GoogleFonts.outfit(),
                        ),
                        backgroundColor: AppTheme.primaryGold,
                      ),
                    );
                  },
                  icon: const Icon(Icons.mark_email_read_outlined, size: 16, color: Colors.black),
                  label: Text(
                    'Send Thank You Notes',
                    style: GoogleFonts.outfit(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Deed ledger & guest list exported to CSV!',
                          style: GoogleFonts.outfit(),
                        ),
                        backgroundColor: AppTheme.surfaceCardElevated,
                      ),
                    );
                  },
                  icon: const Icon(Icons.file_download_outlined, size: 16, color: AppTheme.lightGold),
                  label: Text(
                    'Export Registry',
                    style: GoogleFonts.outfit(color: AppTheme.lightGold, fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.goldBorder),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required double progress,
    required IconData icon,
    required Color color,
  }) {
    return LuxuryCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMuted,
                  letterSpacing: 1.0,
                ),
              ),
              Icon(icon, color: color, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.cinzel(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRSVPStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.cinzel(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 11, color: AppTheme.textMuted),
        ),
      ],
    );
  }
}
