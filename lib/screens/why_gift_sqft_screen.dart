import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

class WhyGiftSqFtScreen extends StatelessWidget {
  const WhyGiftSqFtScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Header
            Text(
              'Why Gift a Square Foot?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'The Smarter Choice for Modern Weddings',
              style: GoogleFonts.outfit(
                fontSize: 13,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 18),

            // COMPARISON CARD (Mixer Grinders vs Home Equity)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEBDAB0)),
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
                  Text(
                    'THE VALUE COMPARISON',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: AppTheme.crimsonMaroon,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      // Boxed Gifts Column
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF1F2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFFECDD3)),
                          ),
                          child: Column(
                            children: [
                              const Text('🎁', style: TextStyle(fontSize: 28)),
                              const SizedBox(height: 6),
                              Text(
                                'Traditional Boxed Gifts',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: const Color(0xFF9F1239),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildComparisonBullet('❌ 3-4 Duplicate mixer grinders', isNegative: true),
                              _buildComparisonBullet('❌ Unused crockery & irons', isNegative: true),
                              _buildComparisonBullet('❌ Depreciates to ₹0 over time', isNegative: true),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Square Footage Column
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFBBF7D0)),
                          ),
                          child: Column(
                            children: [
                              const Text('🏡', style: TextStyle(fontSize: 28)),
                              const SizedBox(height: 6),
                              Text(
                                '1 Sq.Ft. Home Equity',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: const Color(0xFF166534),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildComparisonBullet('✅ Real property equity', isNegative: false),
                              _buildComparisonBullet('✅ Appreciates year after year', isNegative: false),
                              _buildComparisonBullet('✅ Lowers couple\'s home loan', isNegative: false),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4-STEP HOW IT WORKS (Section 5.0 of PDF)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEBDAB0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HOW IT WORKS (4 STEPS)',
                    style: GoogleFonts.cinzel(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: AppTheme.crimsonMaroon,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildStepRow(
                    step: '1',
                    icon: Icons.architecture,
                    title: 'Explore Floor Plan',
                    desc: 'Review the 1,200 SFT 2 BHK architectural grid with Living, Master, and Balcony zones.',
                  ),
                  _buildStepRow(
                    step: '2',
                    icon: Icons.touch_app,
                    title: 'Pick Square Footage',
                    desc: 'Select 1 SFT (₹4.5k), 5 SFT (₹22.5k), 10 SFT (₹45k) or input custom footage.',
                  ),
                  _buildStepRow(
                    step: '3',
                    icon: Icons.account_balance,
                    title: 'RBI Tripartite Escrow Pay',
                    desc: 'Complete instant UPI payment directly ring-fenced for builder settlement.',
                  ),
                  _buildStepRow(
                    step: '4',
                    icon: Icons.tv,
                    title: 'Live Stage Projection',
                    desc: 'Your blessing and tile are beamed onto the banquet hall LED screens in real-time!',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // OFFICIAL REGISTRY NOTICE & VOLUNTARY GIFTING DISCLAIMER (Exact from Spec PDF & WhatsApp Mock)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFD6C28F), width: 1.5),
              ),
              child: Column(
                children: [
                  const Text('🪔', style: TextStyle(fontSize: 32)),
                  const SizedBox(height: 6),
                  Text(
                    'A Message from PlotTheirFuture',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF701322),
                    ),
                  ),
                  Text(
                    'Official Registry Notice & Voluntary Gifting Disclaimer',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFB8860B),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'PlotTheirFuture is pleased to host this celebration registry on behalf of Sanvi & Santosh and their families. We believe that an invited guest\'s presence, warmth, and blessings are always the greatest and most meaningful gifts. Gifting on this platform is completely voluntary, and invitees are under no obligation whatsoever.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: const Color(0xFF334155),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 3 Pillars
                  Row(
                    children: [
                      _buildDisclaimerPillar('🌸', '1. BLESSINGS FIRST', 'Your presence is cherished above all material tokens.'),
                      const SizedBox(width: 8),
                      _buildDisclaimerPillar('🕊️', '2. ZERO OBLIGATION', 'Purely optional; every guest is welcomed with open arms.'),
                      const SizedBox(width: 8),
                      _buildDisclaimerPillar('🏡', '3. MINDFUL GIFTING', 'Sponsor a square foot of home rather than boxed items.'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Platform Policy
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF5E9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE8D6B0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PLATFORM POLICY & GIFTING DISCLOSURE',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: const Color(0xFF701322),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '• Listed by PlotTheirFuture: Created to prevent redundant electronics and misplaced cash envelopes, turning goodwill into lasting home equity.\n• Absolute Free Will: 100% tax-exempt under Section 56(2)(x) with direct escrow settlement to RERA developer account.',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            color: const Color(0xFF475569),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    '"Empowering loved ones to lay the foundation for a lifetime of memories."',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Issued by PlotTheirFuture.in on behalf of the Celebrating Families',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF701322),
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

  static Widget _buildComparisonBullet(String text, {required bool isNegative}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 11,
          color: isNegative ? const Color(0xFF881337) : const Color(0xFF14532D),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static Widget _buildStepRow({
    required String step,
    required IconData icon,
    required String title,
    required String desc,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: AppTheme.crimsonMaroon,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 16, color: AppTheme.royalGold),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textDark),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: GoogleFonts.outfit(fontSize: 11, color: AppTheme.textMuted, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDisclaimerPillar(String emoji, String title, String desc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2D6C0)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF701322),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(fontSize: 9, color: const Color(0xFF475569), height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
