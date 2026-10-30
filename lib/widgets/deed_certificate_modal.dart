import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../models/gift_contribution.dart';
import '../screens/tax_receipt_screen.dart';

class DeedCertificateModal extends StatefulWidget {
  final GiftContribution contribution;

  const DeedCertificateModal({
    super.key,
    required this.contribution,
  });

  @override
  State<DeedCertificateModal> createState() => _DeedCertificateModalState();
}

class _DeedCertificateModalState extends State<DeedCertificateModal> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 4));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.contribution;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0F1728),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppTheme.primaryGold, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGold.withOpacity(0.25),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),

                  // Inner Golden Border Box (Royal Certificate)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B101D),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.lightGold.withOpacity(0.4), width: 1.5),
                    ),
                    child: Column(
                      children: [
                        // Seal / Emblem
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.primaryGold, width: 2),
                            gradient: RadialGradient(
                              colors: [
                                AppTheme.primaryGold.withOpacity(0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.home_work_outlined,
                            color: AppTheme.lightGold,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Title
                        Text(
                          'CERTIFICATE OF BLESSING',
                          style: GoogleFonts.cinzel(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.lightGold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'FOUNDATION DEED FOR LIFE',
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            letterSpacing: 2.0,
                            color: AppTheme.textMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Divider flourish
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 40, height: 1, color: AppTheme.primaryGold.withOpacity(0.5)),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.favorite, color: AppTheme.primaryGold, size: 12),
                            ),
                            Container(width: 40, height: 1, color: AppTheme.primaryGold.withOpacity(0.5)),
                          ],
                        ),
                        const SizedBox(height: 18),

                        Text(
                          'This is to honor and certify that',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.textMuted,
                          ),
                        ),
                        const SizedBox(height: 6),

                        Text(
                          c.donorName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '(${c.relationship})',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: AppTheme.lightGold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          'has generously laid the foundation for the future home of\n${AppConstants.groomName} & ${AppConstants.brideName}\nby gifting and dedicating:',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.8),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Highlighted SqFt
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGold.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.primaryGold.withOpacity(0.4)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${c.sqFt} SQUARE FEET',
                                style: GoogleFonts.cinzel(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.lightGold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                'allocated in ${c.roomName}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: AppTheme.lightGold.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Heartfelt Blessing Quote
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Text(
                            '"${c.blessingMessage}"',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Seal and Token Info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'REGISTRY DEED ID',
                                  style: GoogleFonts.outfit(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textMuted,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  c.deedToken,
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.lightGold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'RECORDED DATE',
                                  style: GoogleFonts.outfit(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textMuted,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  Formatters.formatDateShort(c.timestamp),
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Deed link copied to clipboard! Share it with the couple.',
                                  style: GoogleFonts.outfit(),
                                ),
                                backgroundColor: AppTheme.surfaceCardElevated,
                              ),
                            );
                          },
                          icon: const Icon(Icons.share_outlined, size: 16, color: AppTheme.lightGold),
                          label: Text(
                            'Share Deed',
                            style: GoogleFonts.outfit(color: AppTheme.lightGold, fontSize: 13),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppTheme.goldBorder),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Commemorative certificate saved to your device!',
                                  style: GoogleFonts.outfit(),
                                ),
                                backgroundColor: AppTheme.primaryGold,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.download, size: 16, color: Colors.black),
                          label: Text(
                            'Save Deed',
                            style: GoogleFonts.outfit(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.royalGold,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TaxReceiptScreen(contribution: c),
                          ),
                        );
                      },
                      icon: const Icon(Icons.receipt_long, color: AppTheme.lightGold, size: 16),
                      label: Text(
                        'View Official Tax Receipt (Sec 56(2)(x))',
                        style: GoogleFonts.outfit(
                          color: AppTheme.lightGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Celebratory Confetti
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          colors: const [
            AppTheme.primaryGold,
            AppTheme.lightGold,
            AppTheme.accentRose,
            AppTheme.accentEmerald,
            Colors.white,
          ],
          numberOfParticles: 35,
          gravity: 0.25,
        ),
      ],
    );
  }
}
