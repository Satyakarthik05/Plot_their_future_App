import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../state/flat_registry_provider.dart';

class CampaignHubScreen extends ConsumerWidget {
  final VoidCallback onGiftSqFtTapped;
  final VoidCallback onViewFloorPlanTapped;
  final VoidCallback onViewGuestbookTapped;
  final VoidCallback onViewWhyGiftTapped;

  const CampaignHubScreen({
    super.key,
    required this.onGiftSqFtTapped,
    required this.onViewFloorPlanTapped,
    required this.onViewGuestbookTapped,
    required this.onViewWhyGiftTapped,
  });

  void _showVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.goldBorder, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  AppConstants.coupleImagePath,
                  height: 280,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Sanvi & Santosh Wedding Invite',
                      style: GoogleFonts.playfairDisplay(
                        color: AppTheme.lightGold,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Streaming in 4K HDR • Playing Wedding Shahanai & Vows',
                      style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.black, size: 16),
                      label: Text('Close Video', style: GoogleFonts.outfit(color: Colors.black, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.royalGold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showItineraryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.ivoryBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'WEDDING ITINERARY & VENUES',
              style: GoogleFonts.cinzel(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.crimsonMaroon),
            ),
            const SizedBox(height: 4),
            Text('Sanvi Rao & Santosh Kumar • Bengaluru', style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textMuted)),
            const Divider(height: 24),
            _buildItineraryRow('Pellikuthuru & Haldi', 'Nov 14 • 9:00 AM', 'Rao Residence • Traditional Yellow'),
            _buildItineraryRow('Mehendi & Sangeet Soiree', 'Nov 14 • 6:30 PM', 'Grand Lotus Pavilion • DJ & Cocktails'),
            _buildItineraryRow('Sacred Wedding Muhurtham', 'Nov 15 • 5:45 AM', 'Main Mandapam, Grand Palace'),
            _buildItineraryRow('Grand Reception Gala', 'Nov 15 • 7:00 PM', 'Crystal Grand Ballroom • Royal Feast'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.crimsonMaroon,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Close Itinerary', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildItineraryRow(String title, String time, String venue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppTheme.royalGold.withOpacity(0.15), shape: BoxShape.circle),
            child: const Icon(Icons.event, color: AppTheme.royalGold, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.textDark)),
                Text(time, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 12, color: AppTheme.crimsonMaroon)),
                Text(venue, style: GoogleFonts.outfit(fontSize: 11, color: AppTheme.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(flatRegistryProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Monogram & Title
          Center(
            child: Column(
              children: [
                Text(
                  'Plot Their Future',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 26,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.royalGold,
                  ),
                ),
                Text(
                  'Wedding Gift Registry',
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E2640),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // SECTION 1: INVITATION CARD & VIDEO (Exact from Mock)
          Text(
            'Invitation Card & Video',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E232A),
            ),
          ),
          const SizedBox(height: 10),

          Container(
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
              children: [
                // Video thumbnail with play button
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        AppConstants.coupleImagePath,
                        height: 190,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Wedding Invitation • ${AppConstants.brideName.split(" ").first} & ${AppConstants.groomName.split(" ").first}',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _showVideoDialog(context),
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: AppTheme.crimsonMaroon,
                          size: 32,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      child: Text(
                        'Play Wedding Video Invite 🎥',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            const Shadow(color: Colors.black, blurRadius: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Timings & Itinerary Link
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    children: [
                      Text(
                        'Muhurtham: Nov 15 • 5:45 AM',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E232A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Grand Reception: Nov 15 • 7:00 PM',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E232A),
                        ),
                      ),
                      const Divider(height: 20, color: Color(0xFFF1E6D0)),
                      InkWell(
                        onTap: () => _showItineraryModal(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'View Full Itinerary & Venues',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.crimsonMaroon,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text('📍'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // SECTION 2: GIFT A SQUARE FOOT (2 BHK Flat Campaign)
          Text(
            'GIFT A SQUARE FOOT (2 BHK Flat Campaign)',
            style: GoogleFonts.cinzel(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 10),

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Gift Square Feet in Their 2 BHK\nDream Home! 🏡',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E232A),
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: registry.overallProgress,
                    minHeight: 9,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.royalGold),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${registry.totalGiftedSqFt} / ${registry.totalSqFt} SFT Funded (${(registry.overallProgress * 100).toStringAsFixed(0)}%)',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.crimsonMaroon,
                  ),
                ),
                const SizedBox(height: 14),

                // Isometric 2 BHK Blueprint Image Box
                InkWell(
                  onTap: onViewFloorPlanTapped,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF6EE),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.goldBorder.withOpacity(0.4)),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            AppConstants.apartmentPosterPath,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.grid_on, color: AppTheme.royalGold, size: 14),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                '2 BHK Flat Blueprint & Grid Map',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Quick Chips & CTA
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Text(
                        '1 • 5 • 10 SFT',
                        style: GoogleFonts.outfit(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onGiftSqFtTapped,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.crimsonMaroon,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          elevation: 3,
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'GIFT SQUARE FEET NOW →',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // SECTION 3: Guest Features / Fun Stuff
          Text(
            'Guest Features / Fun Stuff',
            style: GoogleFonts.playfairDisplay(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E232A),
            ),
          ),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEBDAB0)),
            ),
            child: Column(
              children: [
                _buildGuestFeatureTile(
                  icon: Icons.edit_note,
                  title: 'Leave a Blessing / Digital Guestbook',
                  onTap: onViewGuestbookTapped,
                ),
                const Divider(height: 1, color: Color(0xFFF1E6D0)),
                _buildGuestFeatureTile(
                  icon: Icons.photo_camera_outlined,
                  title: 'Upload Photos to the Wedding Wall',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Photo uploaded to wedding reception live screen!', style: GoogleFonts.outfit()),
                        backgroundColor: AppTheme.crimsonMaroon,
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: Color(0xFFF1E6D0)),
                _buildGuestFeatureTile(
                  icon: Icons.help_outline,
                  title: 'Why Gift a Square Foot? (Calculator & FAQ)',
                  onTap: onViewWhyGiftTapped,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildGuestFeatureTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.crimsonMaroon, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: AppTheme.textMuted),
          ],
        ),
      ),
    );
  }
}
