import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../state/flat_registry_provider.dart';

class LiveStageScreen extends ConsumerStatefulWidget {
  const LiveStageScreen({super.key});

  @override
  ConsumerState<LiveStageScreen> createState() => _LiveStageScreenState();
}

class _LiveStageScreenState extends ConsumerState<LiveStageScreen> {
  int _activeTickerIndex = 0;
  Timer? _tickerTimer;

  @override
  void initState() {
    super.initState();
    _tickerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _activeTickerIndex++;
        });
      }
    });
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(flatRegistryProvider);
    final contribs = registry.contributions;
    final currentContrib = contribs.isNotEmpty ? contribs[_activeTickerIndex % contribs.length] : null;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0F1D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0F1D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.lightGold, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('LIVE STAGE LED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Banquet Projection Terminal',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cinzel(fontSize: 13, color: AppTheme.lightGold, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Stage Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF141D30),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.royalGold.withOpacity(0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(color: AppTheme.royalGold.withOpacity(0.15), blurRadius: 20),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '${AppConstants.brideName} & ${AppConstants.groomName}',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGold,
                    ),
                  ),
                  Text(
                    'Forever Home Registry • The 2 BHK Sanctuary',
                    style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 14),

                  // Big Progress Meter
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: registry.overallProgress,
                      minHeight: 16,
                      backgroundColor: const Color(0xFF222E48),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.royalGold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${registry.totalGiftedSqFt} SFT FUNDED',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cinzel(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.lightGold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'TARGET: ${registry.totalSqFt} SFT (${(registry.overallProgress * 100).toStringAsFixed(0)}%)',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cinzel(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Live Rotating Ticker Box
            if (currentContrib != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D1620), Color(0xFF181B2B)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.crimsonMaroon, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.flash_on, color: AppTheme.royalGold, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              'JUST GIFTED & BLESSED ON STAGE',
                              style: GoogleFonts.cinzel(color: AppTheme.lightGold, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.royalGold.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${currentContrib.sqFt} SFT IN ${currentContrib.roomName.toUpperCase()}',
                            style: GoogleFonts.outfit(color: AppTheme.lightGold, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentContrib.donorName,
                      style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentContrib.relationship,
                      style: GoogleFonts.outfit(color: AppTheme.lightGold, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '"${currentContrib.blessingMessage}"',
                      style: GoogleFonts.cormorantGaramond(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // 2 BHK Isometric Visual
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                AppConstants.apartmentPosterPath,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // On-Ground Instructions
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF131A2A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.qr_code_scanner, color: AppTheme.lightGold, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scan Banquet Table QR to Gift & Appear on Stage',
                          style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Instant WebSocket push updates this screen in < 500ms',
                          style: GoogleFonts.outfit(color: Colors.white60, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
