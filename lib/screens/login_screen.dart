import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController(text: "+91 98480 12345");
  final _passwordController = TextEditingController(text: "••••••");
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _isLoading = false);
      widget.onLoginSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.ivoryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Marigold Toran Garland Header
              _buildMarigoldToran(),
              const SizedBox(height: 10),

              // Brand Title
              Text(
                'Plot Their Future',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.royalGold,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                'Wedding Gift Registry',
                style: GoogleFonts.cinzel(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E2640),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Couple Illustration with Keys & House (from WhatsApp mock)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.goldBorder.withOpacity(0.5)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    AppConstants.qrBannerPath,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Form Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFFEBDAB0), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome back!',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A2130),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Login to bless the couple',
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Mobile / Email input
                    TextField(
                      controller: _mobileController,
                      style: GoogleFonts.outfit(color: AppTheme.textDark),
                      decoration: InputDecoration(
                        hintText: 'Mobile Number / Email ID',
                        prefixIcon: const Icon(Icons.phone_android, color: AppTheme.crimsonMaroon, size: 20),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Password / OTP input
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: GoogleFonts.outfit(color: AppTheme.textDark),
                      decoration: InputDecoration(
                        hintText: 'Password / 6-digit OTP',
                        prefixIcon: const Icon(Icons.key, color: AppTheme.crimsonMaroon, size: 20),
                        suffixIcon: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot?',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button (Exact Deep Maroon from WhatsApp Mock)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.crimsonMaroon,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                            : Text(
                                'Login to Gift & Bless',
                                style: GoogleFonts.outfit(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Or Continue with
                    Row(
                      children: [
                        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or continue with',
                            style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textMuted),
                          ),
                        ),
                        const Expanded(child: Divider(color: Color(0xFFE2E8F0))),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Social login buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          label: 'Google',
                          color: const Color(0xFFEA4335),
                          onTap: _handleLogin,
                        ),
                        const SizedBox(width: 24),
                        _buildSocialButton(
                          icon: Icons.chat,
                          label: 'WhatsApp',
                          color: const Color(0xFF25D366),
                          onTap: _handleLogin,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Create Registry link
                    InkWell(
                      onTap: _handleLogin,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'First time here? ',
                              style: GoogleFonts.outfit(color: AppTheme.textMuted, fontSize: 13),
                            ),
                            TextSpan(
                              text: 'Create a Registry',
                              style: GoogleFonts.outfit(
                                color: AppTheme.crimsonMaroon,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarigoldToran() {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          12,
          (index) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppTheme.marigoldOrange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppTheme.marigoldYellow,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
