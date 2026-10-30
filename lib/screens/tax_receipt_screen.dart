import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import '../models/gift_contribution.dart';

class TaxReceiptScreen extends StatelessWidget {
  final GiftContribution? contribution;

  const TaxReceiptScreen({super.key, this.contribution});

  @override
  Widget build(BuildContext context) {
    final sqFt = contribution?.sqFt ?? 5;
    final roomName = contribution?.roomName ?? 'Living Room';
    final receiptNo = contribution?.deedToken ?? 'PTF-ESC-89210';
    final amount = contribution?.amount != null ? '₹${contribution!.amount.toInt()}' : '₹22,500';

    return Scaffold(
      backgroundColor: AppTheme.ivoryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.ivoryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.crimsonMaroon, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Tax-Exempt Receipt',
          style: GoogleFonts.cinzel(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.crimsonMaroon),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            // Top Marigold Toran Garland
            _buildMarigoldToran(),
            const SizedBox(height: 14),

            // Green Check Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.greenVerified,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  'Thank You for Your Blessing!',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E232A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // CERTIFICATE CARD (With hanging diyas & gold filigree from Mock Screen 06)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
              decoration: BoxDecoration(
                color: const Color(0xFFFCF8EE),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD4B35D), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Diya Left
                  Positioned(
                    top: 10,
                    left: 6,
                    child: Column(
                      children: [
                        Container(width: 1, height: 20, color: AppTheme.royalGold.withOpacity(0.5)),
                        const Text('🪔', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  // Diya Right
                  Positioned(
                    top: 10,
                    right: 6,
                    child: Column(
                      children: [
                        Container(width: 1, height: 20, color: AppTheme.royalGold.withOpacity(0.5)),
                        const Text('🪔', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Text(
                        'You have gifted',
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$sqFt Sq.Ft.',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.crimsonMaroon,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'in the $roomName\nto the Newlyweds',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E232A),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // OFFICIAL DIGITAL TAX RECEIPT CARD (Exact from Mock Screen 06)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD4B35D), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Official Digital Tax Receipt',
                      style: GoogleFonts.cinzel(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E232A),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Divider(height: 24, color: Color(0xFFE2D6C0)),

                  _buildReceiptField('Receipt No:', receiptNo),
                  const SizedBox(height: 12),
                  _buildReceiptField('Amount:', amount, isBold: true),
                  const SizedBox(height: 12),
                  _buildReceiptField(
                    'Tax Exemption:',
                    'Indian Income Tax Act\nSec 56(2)(x) Wedding\nGift Exemption',
                    isHighlight: true,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment Mode:',
                        style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF475569)),
                      ),
                      Text(
                        'UPI Confirmed',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.greenVerified,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: Color(0xFFE2D6C0)),

                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.shield, color: AppTheme.royalGold, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            'RBI Regulated Tripartite Escrow',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons (Exact from Mock Screen 06)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tax exemption receipt PDF downloaded successfully!', style: GoogleFonts.outfit()),
                      backgroundColor: AppTheme.crimsonMaroon,
                    ),
                  );
                },
                icon: const Icon(Icons.download, color: Colors.white, size: 18),
                label: Text(
                  'Download PDF Tax Receipt',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.crimsonMaroon,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Receipt and deed shared to WhatsApp!', style: GoogleFonts.outfit()),
                      backgroundColor: const Color(0xFF25D366),
                    ),
                  );
                },
                icon: const Icon(Icons.chat, color: AppTheme.crimsonMaroon, size: 18),
                label: Text(
                  'Share via WhatsApp',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.crimsonMaroon,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.crimsonMaroon, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static Widget _buildReceiptField(String label, String value, {bool isBold = false, bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF475569)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isHighlight ? AppTheme.crimsonMaroon : AppTheme.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMarigoldToran() {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          10,
          (index) => Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppTheme.marigoldOrange,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
