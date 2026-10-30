import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';

class SecurityFaqScreen extends StatefulWidget {
  const SecurityFaqScreen({super.key});

  @override
  State<SecurityFaqScreen> createState() => _SecurityFaqScreenState();
}

class _SecurityFaqScreenState extends State<SecurityFaqScreen> {
  String _searchQuery = '';

  final List<Map<String, String>> _faqs = [
    {
      'q': 'Where does my money go? Is it held in personal accounts?',
      'a': 'No funds ever enter personal accounts or startup wallets. Every rupee is routed directly into an RBI-regulated Tripartite Escrow Account maintained with a scheduled commercial bank (HDFC Bank • IFSC: HDFC00012) until formal developer settlement.',
      'category': 'Banking & Escrow',
    },
    {
      'q': 'Can I gift fractional square feet or sponsor an entire room?',
      'a': 'You can gift as little as 1 Sq.Ft. (₹4,500). Guests, corporate colleagues, and cousin circles frequently pool funds together to sponsor larger designated zones like the Balcony or Living Room.',
      'category': 'Gifting Logistics',
    },
    {
      'q': 'What happens if the 1,200 SFT apartment goal isn\'t 100% funded?',
      'a': '100% completion is not required. Whatever square footage is funded (e.g., 35% or 420 SFT) is disbursed directly to the developer as an upfront down payment or applied as principal prepayment on the couple\'s home loan.',
      'category': 'Property Settlement',
    },
    {
      'q': 'Is this gift taxable for the newlyweds or the contributing guest under Indian law?',
      'a': 'No. Under Section 56(2)(x) of the Indian Income Tax Act, genuine gifts presented on the occasion of marriage are 100% exempt from income tax without any monetary upper limit for both the recipient and donor.',
      'category': 'Taxation & Legal',
    },
    {
      'q': 'Why are other weddings on the platform locked or greyed out when I log in?',
      'a': 'PlotTheirFuture enforces row-level privacy. Your account is linked strictly to the specific wedding invitation extended to you (Sanvi & Santosh). Other weddings hosted on the system remain locked and greyed out to maintain privacy.',
      'category': 'Privacy & Security',
    },
    {
      'q': 'Where will my personal blessing and gift confirmation be displayed during the wedding?',
      'a': 'Your blessing is tagged to your funded floor-plan tile, saved in the couple\'s permanent digital guestbook, and rotated via WebSockets across the grand LED projection screen live during the wedding reception.',
      'category': 'Wedding Reception',
    },
    {
      'q': 'Can I contribute anonymously without having my name shown publicly?',
      'a': 'Yes. Toggle the "Gift Anonymously" switch during checkout. Your contribution is credited to the couple\'s escrow down-payment pool, but your name will be masked on the public floor plan and stage ticker.',
      'category': 'Privacy & Security',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = _faqs.where((faq) {
      return _searchQuery.isEmpty ||
          faq['q']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['a']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          faq['category']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
          'FAQ & Security Center',
          style: GoogleFonts.cinzel(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.crimsonMaroon),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Text(
              '100% Secure & Regulated',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'RBI Escrow Protection • RERA Builder Settlement',
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // 4 TRUST BADGES GRID (Exact from Screen 07 Mock)
            Row(
              children: [
                Expanded(
                  child: _buildTrustBadge(
                    icon: Icons.shield,
                    title: '100% RBI\nEscrow Protected',
                    subtitle: 'Funds ring-fenced',
                    color: AppTheme.greenVerified,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTrustBadge(
                    icon: Icons.domain_verification,
                    title: 'RERA Builder\nDirect Transfer',
                    subtitle: 'Reg: ${AppConstants.reraRegistrationId}',
                    color: AppTheme.royalGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTrustBadge(
                    icon: Icons.receipt_long,
                    title: 'Tax-Exempt\nMarriage Gift',
                    subtitle: 'Sec 56(2)(x) 100% exempt',
                    color: AppTheme.crimsonMaroon,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTrustBadge(
                    icon: Icons.dashboard_customize,
                    title: 'Flexible\nFractional Gifting',
                    subtitle: 'Gift 1 SFT to full rooms',
                    color: const Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 3-STEP FUND JOURNEY
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEBDAB0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WHAT HAPPENS TO YOUR MONEY?',
                    style: GoogleFonts.cinzel(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: AppTheme.crimsonMaroon,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildJourneyStep('1. Guest UPI', 'Safe, instant payment', Icons.qr_code),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Icon(Icons.arrow_forward, size: 14, color: AppTheme.textMuted),
                      ),
                      Expanded(
                        child: _buildJourneyStep('2. Bank Escrow', 'HDFC Tripartite account', Icons.account_balance),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Icon(Icons.arrow_forward, size: 14, color: AppTheme.textMuted),
                      ),
                      Expanded(
                        child: _buildJourneyStep('3. RERA Builder', 'Credited to flat', Icons.apartment),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar
            TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search safety, tax, or gifting questions...',
                prefixIcon: const Icon(Icons.search, color: AppTheme.crimsonMaroon, size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // FAQ Accordions (Sections 7.0 & 8.0 of PDF)
            ...filteredFaqs.map((faq) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Color(0xFFE2D6C0)),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      title: Text(
                        faq['q']!,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      subtitle: Text(
                        faq['category']!,
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.crimsonMaroon,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: Text(
                            faq['a']!,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFF475569),
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBadge({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2D6C0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 9, color: AppTheme.textMuted),
          ),
        ],
      ),
    );
  }

  Widget _buildJourneyStep(String title, String desc, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.royalGold.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.royalGold, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textDark),
        ),
        const SizedBox(height: 2),
        Text(
          desc,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.outfit(fontSize: 8.5, color: AppTheme.textMuted, height: 1.2),
        ),
      ],
    );
  }
}
