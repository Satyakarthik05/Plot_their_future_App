import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../models/wedding_event.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/luxury_card.dart';
import '../widgets/rsvp_dialog.dart';

class InvitationScreen extends ConsumerWidget {
  final VoidCallback onExploreRegistryTapped;

  const InvitationScreen({
    super.key,
    required this.onExploreRegistryTapped,
  });

  static const List<WeddingEvent> events = [
    WeddingEvent(
      id: 'sangeet',
      title: 'Mehendi & Sangeet Soiree',
      subtitle: 'An evening of rhythm, henna, cocktails & folk dances',
      date: 'Thursday, December 10, 2026',
      time: '6:30 PM onwards',
      venue: 'The Royal Lotus Pavilion',
      address: '88 Orchard Grand Road, Silicon Valley',
      dressCode: 'Indo-Western Glitz & Vibrant Jewel Tones',
      icon: Icons.nightlife,
    ),
    WeddingEvent(
      id: 'ceremony',
      title: 'Sacred Muhurtham & Vows',
      subtitle: 'The Vedic auspicious wedding ceremony & garland exchange',
      date: 'Friday, December 11, 2026',
      time: '9:30 AM - 12:30 PM',
      venue: 'The Grand Temple Heritage Sanctuary',
      address: '104 Heritage Way, Golden Gate Enclave',
      dressCode: 'Traditional Indian Elegance (Pastels & Gold)',
      icon: Icons.favorite,
    ),
    WeddingEvent(
      id: 'reception',
      title: 'Grand Reception & Gala Dinner',
      subtitle: 'Celebration of love, toasts, cake cutting & royal feast',
      date: 'Friday, December 11, 2026',
      time: '7:00 PM onwards',
      venue: 'The Crystal Grand Ballroom',
      address: 'Skyline Palms Resort, Silicon Valley',
      dressCode: 'Formal Black Tie & Regal Evening Gowns',
      icon: Icons.dinner_dining,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // HERO BANNER WITH COUPLE IMAGE & ORNATE INVITATION
          Stack(
            children: [
              // Romantic Couple Portrait
              Container(
                height: 480,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConstants.coupleImagePath),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              // Luxurious Dark Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.5),
                        AppTheme.darkBackground,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
              // Invitation Header Content
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppTheme.primaryGold.withOpacity(0.6)),
                      ),
                      child: Text(
                        'THE WEDDING CELEBRATION',
                        style: GoogleFonts.cinzel(
                          color: AppTheme.lightGold,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${AppConstants.groomName}\n&\n${AppConstants.brideName}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.weddingTagline,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.lightGold,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const CountdownTimerWidget(),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Royal Invitation Calligraphy Card
                LuxuryCard(
                  child: Column(
                    children: [
                      const Icon(Icons.favorite, color: AppTheme.primaryGold, size: 28),
                      const SizedBox(height: 12),
                      Text(
                        'YOU ARE CORDIALLY INVITED',
                        style: GoogleFonts.cinzel(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Together with their loving families, Aarav & Meera request the honor of your presence and blessings as they embark on their sacred journey of marriage and eternal partnership.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 17,
                          height: 1.5,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => const RSVPDialog(),
                              );
                            },
                            icon: const Icon(Icons.mark_email_read, size: 16, color: Colors.black),
                            label: Text(
                              'RSVP Online',
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGold,
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed: onExploreRegistryTapped,
                            icon: const Icon(Icons.home_work_outlined, size: 16, color: AppTheme.lightGold),
                            label: Text(
                              'Gift A Sq.Ft.',
                              style: GoogleFonts.outfit(
                                color: AppTheme.lightGold,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppTheme.goldBorder),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // SIGNATURE INNOVATION HIGHLIGHT: "PLOT THEIR FUTURE"
                LuxuryCard(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF202C44), Color(0xFF131A29)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderColor: AppTheme.primaryGold,
                  glow: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGold.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.foundation, color: AppTheme.primaryGold, size: 24),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PLOT THEIR FUTURE REGISTRY',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.lightGold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  'A timeless alternative to traditional wedding gifts',
                                  style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textMuted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Instead of conventional home appliances or gift envelopes, you can gift square footage towards Aarav & Meera\'s dream penthouse apartment! Your blessing will be permanently minted on their home\'s architectural deed.',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.85),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: onExploreRegistryTapped,
                          icon: const Icon(Icons.grid_view, color: Colors.black, size: 18),
                          label: Text(
                            'Explore 3-BHK Flat & Gift Sq.Ft. Now',
                            style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGold,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // WEDDING ITINERARY & CEREMONIES
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'WEDDING ITINERARY & CEREMONIES',
                    style: GoogleFonts.cinzel(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                ...events.map((event) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: LuxuryCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryGold.withOpacity(0.15),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppTheme.primaryGold.withOpacity(0.3)),
                                  ),
                                  child: Icon(event.icon, color: AppTheme.primaryGold, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event.title,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        event.date,
                                        style: GoogleFonts.outfit(
                                          fontSize: 12,
                                          color: AppTheme.lightGold,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              event.subtitle,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                color: AppTheme.textMuted,
                              ),
                            ),
                            const Divider(color: Color(0xFF222D42), height: 20),
                            Row(
                              children: [
                                const Icon(Icons.schedule, size: 14, color: AppTheme.primaryGold),
                                const SizedBox(width: 6),
                                Text(
                                  event.time,
                                  style: GoogleFonts.outfit(fontSize: 12, color: Colors.white70),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.checkroom, size: 14, color: AppTheme.accentRose),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    event.dressCode,
                                    style: GoogleFonts.outfit(fontSize: 12, color: Colors.white70),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.place_outlined, size: 14, color: AppTheme.accentEmerald),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '${event.venue} • ${event.address}',
                                    style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textMuted),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 20),

                // OUR LOVE & HOME STORY
                LuxuryCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'OUR STORY & VISION',
                        style: GoogleFonts.cinzel(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          AppConstants.flatImagePath,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        '"We met under the autumn trees six years ago and realized we shared the exact same dream: building a loving, welcoming home filled with warmth, warm meals, deep books, and open doors for our dearest friends and family."',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '— Aarav & Meera',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
