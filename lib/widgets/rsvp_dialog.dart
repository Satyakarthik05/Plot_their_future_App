import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../state/rsvp_provider.dart';

class RSVPDialog extends ConsumerStatefulWidget {
  const RSVPDialog({super.key});

  @override
  ConsumerState<RSVPDialog> createState() => _RSVPDialogState();
}

class _RSVPDialogState extends ConsumerState<RSVPDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _noteController = TextEditingController();
  int _partySize = 2;
  String _attendance = 'Attending';
  String _dietary = 'Vegetarian';
  final Set<String> _selectedEvents = {'sangeet', 'ceremony', 'reception'};
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your full name.')),
      );
      return;
    }

    ref.read(rsvpProvider).submitRSVP(
      guestName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      partySize: _partySize,
      attendanceStatus: _attendance,
      attendingEventIds: _selectedEvents.toList(),
      dietaryPreference: _dietary,
      note: _noteController.text.trim(),
    );

    setState(() {
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppTheme.darkSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.primaryGold, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle_outline, color: AppTheme.primaryGold, size: 64),
              const SizedBox(height: 16),
              Text(
                'RSVP Confirmed!',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Thank you ${_nameController.text}! ${AppConstants.groomName} & ${AppConstants.brideName} are overjoyed to celebrate with you.',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: AppTheme.textMuted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGold,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Back to Invitation',
                  style: GoogleFonts.outfit(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1728),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.goldBorder, width: 1.5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WEDDING RSVP',
                        style: GoogleFonts.cinzel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.lightGold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        'Celebrate with ${AppConstants.coupleInitials}',
                        style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textMuted),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: Color(0xFF1E293B), height: 24),

              // Attendance Toggle
              Text(
                'WILL YOU BE ATTENDING?',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _attendance = 'Attending'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _attendance == 'Attending' ? AppTheme.primaryGold : AppTheme.surfaceCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _attendance == 'Attending' ? AppTheme.primaryGold : AppTheme.goldBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Joyfully Accept 🎉',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _attendance == 'Attending' ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _attendance = 'Declined'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: _attendance == 'Declined' ? Colors.white24 : AppTheme.surfaceCard,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _attendance == 'Declined' ? Colors.white70 : AppTheme.goldBorder,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Regretfully Decline',
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Guest name
              Text(
                'GUEST NAME & CONTACT',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Full Name',
                  prefixIcon: Icon(Icons.person, color: AppTheme.primaryGold, size: 20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email, color: AppTheme.primaryGold, size: 20),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: 'Phone / WhatsApp Number',
                  prefixIcon: Icon(Icons.phone, color: AppTheme.primaryGold, size: 20),
                ),
              ),
              const SizedBox(height: 16),

              // Party Size
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL GUESTS ATTENDING',
                    style: GoogleFonts.outfit(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.lightGold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Row(
                    children: [1, 2, 3, 4].map((size) {
                      final isSelected = _partySize == size;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () => setState(() => _partySize = size),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.primaryGold : AppTheme.surfaceCard,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppTheme.primaryGold : Colors.white24,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$size',
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.black : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Ceremonies Attending
              Text(
                'CEREMONIES ATTENDING',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              _buildEventCheckbox('sangeet', 'Mehendi & Sangeet Soiree (Dec 10)'),
              _buildEventCheckbox('ceremony', 'Holy Muhurtham & Vows (Dec 11)'),
              _buildEventCheckbox('reception', 'Grand Gala & Dinner (Dec 11)'),
              const SizedBox(height: 16),

              // Dietary Preference
              Text(
                'DIETARY PREFERENCE',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Vegetarian', 'Vegan', 'Jain', 'Non-Vegetarian'].map((diet) {
                  final isSelected = _dietary == diet;
                  return ChoiceChip(
                    label: Text(diet, style: GoogleFonts.outfit(fontSize: 12)),
                    selected: isSelected,
                    selectedColor: AppTheme.primaryGold,
                    backgroundColor: AppTheme.surfaceCard,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white70,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (_) => setState(() => _dietary = diet),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Personal Note
              Text(
                'A WISH FOR THE COUPLE',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Share a sweet wish with Aarav & Meera...',
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    'Confirm My RSVP',
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCheckbox(String eventId, String title) {
    final isChecked = _selectedEvents.contains(eventId);
    return InkWell(
      onTap: () {
        setState(() {
          if (isChecked) {
            _selectedEvents.remove(eventId);
          } else {
            _selectedEvents.add(eventId);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: isChecked ? AppTheme.primaryGold : Colors.white38,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.outfit(fontSize: 13, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
