import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';

class HostDispatchScreen extends StatefulWidget {
  const HostDispatchScreen({super.key});

  @override
  State<HostDispatchScreen> createState() => _HostDispatchScreenState();
}

class _HostDispatchScreenState extends State<HostDispatchScreen> {
  bool _haldiSelected = true;
  bool _sangeetSelected = true;
  bool _muhurthamSelected = true;
  bool _receptionSelected = true;
  String _selectedAudience = 'All Family';
  bool _includeRegistry = true;

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppTheme.crimsonMaroon),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Marigold Toran
            _buildMarigoldToran(),
            const SizedBox(height: 12),

            // Main Title
            Center(
              child: Text(
                'Send Wedding Invitations',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E232A),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Select Events
            Text(
              'Select Events',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            const SizedBox(height: 12),

            // 2x2 Event Cards Grid (Exact from Mock Screen 04)
            Row(
              children: [
                Expanded(
                  child: _buildEventCard(
                    title: 'Haldi\nCeremony',
                    icon: Icons.spa,
                    iconColor: AppTheme.marigoldOrange,
                    isSelected: _haldiSelected,
                    onToggle: () => setState(() => _haldiSelected = !_haldiSelected),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildEventCard(
                    title: 'Sangeet &\nMehendi',
                    icon: Icons.music_note,
                    iconColor: AppTheme.crimsonMaroon,
                    isSelected: _sangeetSelected,
                    onToggle: () => setState(() => _sangeetSelected = !_sangeetSelected),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildEventCard(
                    title: 'Wedding\nMuhurtham',
                    icon: Icons.wb_sunny,
                    iconColor: AppTheme.royalGold,
                    isSelected: _muhurthamSelected,
                    onToggle: () => setState(() => _muhurthamSelected = !_muhurthamSelected),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildEventCard(
                    title: 'Grand\nReception',
                    icon: Icons.celebration,
                    iconColor: AppTheme.marigoldYellow,
                    isSelected: _receptionSelected,
                    onToggle: () => setState(() => _receptionSelected = !_receptionSelected),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // Select Audience
            Text(
              'Select Audience',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            const SizedBox(height: 10),

            // Audience Chips
            Row(
              children: ['All Family', 'Friends', 'Colleagues'].map((audience) {
                final isSelected = _selectedAudience == audience;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => setState(() => _selectedAudience = audience),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.crimsonMaroon : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppTheme.crimsonMaroon : const Color(0xFFE2D6C0),
                        ),
                      ),
                      child: Text(
                        audience,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppTheme.textMuted,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),

            // Include Gift Registry Card
            Text(
              'Include Gift Registry',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E232A),
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEBDAB0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Switch(
                    value: _includeRegistry,
                    activeColor: AppTheme.greenVerified,
                    onChanged: (val) => setState(() => _includeRegistry = val),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '2 BHK Apartment Sq.Ft. Gift Link',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                        Text(
                          'Includes RERA & Tripartite Escrow pledge',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('🏢🔑', style: TextStyle(fontSize: 22)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons (Exact from Mock)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'WhatsApp Smart Broadcast sent to $_selectedAudience with tracked referral link!',
                        style: GoogleFonts.outfit(),
                      ),
                      backgroundColor: AppTheme.crimsonMaroon,
                    ),
                  );
                },
                icon: const Icon(Icons.chat, color: Colors.white, size: 20),
                label: Text(
                  'Send WhatsApp Broadcast',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
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
                      content: Text(
                        'Smart Invite URL copied: plottheirfuture.in/w/${AppConstants.campaignSlug}?ref=host',
                        style: GoogleFonts.outfit(),
                      ),
                      backgroundColor: AppTheme.royalGold,
                    ),
                  );
                },
                icon: const Icon(Icons.link, color: AppTheme.royalGold, size: 20),
                label: Text(
                  'Copy Link',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6B4800),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.goldBorder, width: 1.5),
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

  Widget _buildEventCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onToggle,
  }) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppTheme.royalGold : const Color(0xFFE2D6C0),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE8C252) : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected ? const Color(0xFFB8860B) : const Color(0xFFCBD5E1),
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 14, color: Color(0xFF4A3400))
                    : null,
              ),
            ),
          ],
        ),
      ),
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
