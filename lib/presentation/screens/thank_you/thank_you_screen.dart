import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../auth/login_screen.dart';
import '../history/feedback_history_screen.dart';
import '../user_details/user_details_screen.dart';


class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 30),

              Image.asset(
                'assets/logo/feedbee_logo1.png',
                height: 90,
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withValues(
                        alpha: 0.05,
                      ),
                      blurRadius: 15,
                      offset:
                          const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration:
                          BoxDecoration(
                        color: AppColors
                            .success
                            .withValues(
                          alpha: 0.15,
                        ),
                        shape:
                            BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons
                            .check_circle_rounded,
                        color:
                            AppColors.success,
                        size: 80,
                      ),
                    ),

                    const SizedBox(
                        height: 24),

                    const Text(
                      "Feedback Submitted!",
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                        color: AppColors
                            .textPrimary,
                      ),
                    ),

                    const SizedBox(
                        height: 14),

                    const Text(
                      "Thank you for helping us improve FeedBee.\nYour feedback has been securely saved and recorded.",
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: AppColors
                            .textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 58,
                child:
                    ElevatedButton.icon(
                  icon: const Icon(
                    Icons.history,
                  ),
                  label: const Text(
                    "View Feedback History",
                  ),
                  style:
                      ElevatedButton
                          .styleFrom(
                    backgroundColor:
                        AppColors.primary,
                    foregroundColor:
                        AppColors
                            .textPrimary,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        18,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const FeedbackHistoryScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 58,
                child:
                    OutlinedButton.icon(
                  icon: const Icon(
                    Icons.refresh,
                  ),
                  label: const Text(
                    "Submit Another Feedback",
                  ),
                  style:
                      OutlinedButton
                          .styleFrom(
                    foregroundColor:
                        AppColors
                            .textPrimary,
                    side:
                        const BorderSide(
                      color:
                          AppColors
                              .primary,
                      width: 1.5,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        18,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const UserDetailsScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              TextButton.icon(
                icon: const Icon(
                  Icons.home_outlined,
                ),
                label: const Text(
                  "Back To Home",
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 24),

              const Text(
                "",
                style: TextStyle(
                  color:
                      AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}