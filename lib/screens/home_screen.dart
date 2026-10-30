import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../widgets/gift_sqft_sheet.dart';
import '../widgets/rsvp_dialog.dart';
import 'campaign_hub_screen.dart';
import 'floor_plan_screen.dart';
import 'host_dispatch_screen.dart';
import 'live_stage_screen.dart';
import 'login_screen.dart';
import 'security_faq_screen.dart';
import 'tax_receipt_screen.dart';
import 'why_gift_sqft_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  void _openGiftModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GiftSqFtSheet(),
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  void _showScreenSwitcherModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
            const SizedBox(height: 14),
            Text(
              'EXPLORE ALL MOCK SCREENS',
              style: GoogleFonts.cinzel(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.crimsonMaroon),
            ),
            Text(
              'Direct access to all 8 screens from specification manual',
              style: GoogleFonts.outfit(fontSize: 11, color: AppTheme.textMuted),
            ),
            const Divider(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildScreenNavItem(
                    number: '01',
                    title: 'Multi-Tenant Login Gateway',
                    subtitle: 'Screen 01 • WhatsApp/OTP auth & couple illustration',
                    icon: Icons.login,
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToScreen(LoginScreen(onLoginSuccess: () => Navigator.pop(context)));
                    },
                  ),
                  _buildScreenNavItem(
                    number: '02',
                    title: 'Invitation & Campaign Hub',
                    subtitle: 'Screen 02 • Video invite, 2 BHK progress bar & guest shortcuts',
                    icon: Icons.video_collection_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 0);
                    },
                  ),
                  _buildScreenNavItem(
                    number: '03',
                    title: 'Interactive 2 BHK Floor Plan',
                    subtitle: 'Screen 03 • 1,200 SFT blueprint, funded gold cells & preset chips',
                    icon: Icons.architecture,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 1);
                    },
                  ),
                  _buildScreenNavItem(
                    number: '04',
                    title: 'Host Ceremony Selection & Dispatch',
                    subtitle: 'Screen 04 • Haldi/Sangeet/Muhurtham toggles & WhatsApp broadcast',
                    icon: Icons.send_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 3);
                    },
                  ),
                  _buildScreenNavItem(
                    number: '05',
                    title: 'Why Gift a Sq.Ft. & Disclaimer',
                    subtitle: 'Screen 05 • Value comparison & official voluntary gifting disclaimer',
                    icon: Icons.balance,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 2);
                    },
                  ),
                  _buildScreenNavItem(
                    number: '06',
                    title: 'Thank You Note & Digital Tax Receipt',
                    subtitle: 'Screen 06 • Sec 56(2)(x) official receipt with PDF download',
                    icon: Icons.receipt_long,
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToScreen(const TaxReceiptScreen());
                    },
                  ),
                  _buildScreenNavItem(
                    number: '07',
                    title: 'Security & Compliance FAQ Center',
                    subtitle: 'Screen 07 • 4 trust badges, 3-step fund journey & full FAQ',
                    icon: Icons.security,
                    onTap: () {
                      Navigator.pop(context);
                      setState(() => _currentIndex = 4);
                    },
                  ),
                  _buildScreenNavItem(
                    number: '08',
                    title: 'Live Stage LED Banquet Display',
                    subtitle: 'Module 5 • Real-time WebSocket donor ticker & 420 SFT meter',
                    icon: Icons.tv,
                    onTap: () {
                      Navigator.pop(context);
                      _navigateToScreen(const LiveStageScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenNavItem({
    required String number,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppTheme.crimsonMaroon.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            number,
            style: GoogleFonts.cinzel(fontWeight: FontWeight.bold, color: AppTheme.crimsonMaroon),
          ),
        ),
      ),
      title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textDark)),
      subtitle: Text(subtitle, style: GoogleFonts.outfit(fontSize: 11, color: AppTheme.textMuted)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 12, color: AppTheme.textMuted),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      CampaignHubScreen(
        onGiftSqFtTapped: _openGiftModal,
        onViewFloorPlanTapped: () => setState(() => _currentIndex = 1),
        onViewWhyGiftTapped: () => setState(() => _currentIndex = 2),
        onViewGuestbookTapped: () => _navigateToScreen(const LiveStageScreen()),
      ),
      const FloorPlanScreen(),
      const WhyGiftSqFtScreen(),
      const HostDispatchScreen(),
      const SecurityFaqScreen(),
    ];

    return Scaffold(
      backgroundColor: AppTheme.ivoryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.ivoryBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 8,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5AB),
                border: Border.all(color: AppTheme.royalGold, width: 1.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                AppConstants.coupleInitials,
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.crimsonMaroon,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Plot Their Future',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppTheme.royalGold,
                    ),
                  ),
                  Text(
                    '${AppConstants.brideName.split(" ").first} & ${AppConstants.groomName.split(" ").first} • 2 BHK Registry',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Screens Switcher Menu Button
          IconButton(
            tooltip: 'All Mock Screens',
            icon: const Icon(Icons.apps, color: AppTheme.crimsonMaroon, size: 20),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
            onPressed: _showScreenSwitcherModal,
          ),
          const SizedBox(width: 4),

          // RSVP Quick Action Button
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 12, bottom: 12),
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const RSVPDialog(),
                );
              },
              icon: const Icon(Icons.mark_email_read, size: 12, color: Colors.white),
              label: Text(
                'RSVP',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppTheme.crimsonMaroon,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openGiftModal,
        backgroundColor: AppTheme.crimsonMaroon,
        elevation: 6,
        icon: const Icon(Icons.card_giftcard, color: Colors.white, size: 18),
        label: Text(
          'Gift a Sq.Ft.',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // Bottom Navigation Bar with 5 Primary Screens
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: const Color(0xFFE2D6C0).withOpacity(0.8))),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppTheme.crimsonMaroon,
          unselectedItemColor: AppTheme.textMuted,
          selectedLabelStyle: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.outfit(fontSize: 10),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined),
              activeIcon: Icon(Icons.video_collection),
              label: 'Hub',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.architecture_outlined),
              activeIcon: Icon(Icons.architecture),
              label: 'Floor Plan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.balance_outlined),
              activeIcon: Icon(Icons.balance),
              label: 'Why Gift',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.send_outlined),
              activeIcon: Icon(Icons.send),
              label: 'Invites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security_outlined),
              activeIcon: Icon(Icons.security),
              label: 'Security/FAQ',
            ),
          ],
        ),
      ),
    );
  }
}
