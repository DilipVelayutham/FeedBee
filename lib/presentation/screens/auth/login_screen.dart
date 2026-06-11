import 'package:flutter/material.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/feedback_draft.dart';

import '../user_details/user_details_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bug_report_rounded,
                  size: 55,
                  color: AppColors.primaryDark,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'FeedBee',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Collect meaningful feedback\nwith ease',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      final authService = AuthService();

                      final result =
                          await authService.signInWithGoogle();

                      if (!context.mounted) return;

                      if (result != null) {
                        final user = result.user;

                        FeedbackDraft.clear();

                        FeedbackDraft.loginType = 'google';

                        FeedbackDraft.name =
                            user?.displayName ?? '';

                        FeedbackDraft.email =
                            user?.email ?? '';

                        FeedbackDraft.mobile = '';

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const UserDetailsScreen(),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Google Login currently unavailable',
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.login),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor:
                        AppColors.textPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color:
                            AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton.icon(
                  onPressed: () {
                    FeedbackDraft.clear();

                    FeedbackDraft.loginType = 'guest';

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const UserDetailsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.person_outline,
                  ),
                  label: const Text(
                    'Continue as Guest',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        AppColors.textPrimary,
                    side: const BorderSide(
                      color: Color(0xFFE0E0E0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              const Text(
                'Secure • Fast • Offline Friendly',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}