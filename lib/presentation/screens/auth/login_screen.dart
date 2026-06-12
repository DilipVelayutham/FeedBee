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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 60,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 16,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/logo/feedbee_logo1.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'FeedBee',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      child: Text(
                        'Collect bug issues',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                              .withValues(alpha: 0.95),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -30),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Card(
                    elevation: 8,
                    shadowColor:
                        Colors.black12,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                        28,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Welcome 👋',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight:
                                  FontWeight.bold,
                              color: AppColors
                                  .textPrimary,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            'Choose how you would like to continue.',
                            textAlign:
                                TextAlign.center,
                            style: TextStyle(
                              color: AppColors
                                  .textSecondary,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(
                            height: 32,
                          ),

                          SizedBox(
                            width:
                                double.infinity,
                            height: 58,
                            child:
                                ElevatedButton.icon(
                              onPressed:
                                  () async {
                                try {
                                  final authService =
                                      AuthService();

                                  final result =
                                      await authService
                                          .signInWithGoogle();

                                  if (!context
                                      .mounted) {
                                    return;
                                  }

                                  if (result !=
                                      null) {
                                    final user =
                                        result
                                            .user;

                                    FeedbackDraft
                                        .clear();

                                    FeedbackDraft
                                            .loginType =
                                        'google';

                                    FeedbackDraft
                                            .name =
                                        user?.displayName ??
                                            '';

                                    FeedbackDraft
                                            .email =
                                        user?.email ??
                                            '';

                                    FeedbackDraft
                                            .mobile =
                                        '';

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                const UserDetailsScreen(),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  if (!context
                                      .mounted) {
                                    return;
                                  }

                                  ScaffoldMessenger
                                          .of(
                                              context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text(
                                        'Google Login currently unavailable',
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.login,
                              ),
                              label: const Text(
                                'Continue with Google',
                                style:
                                    TextStyle(
                                  fontSize:
                                      16,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                              style:
                                  ElevatedButton
                                      .styleFrom(
                                backgroundColor:
                                    AppColors
                                        .primary,
                                foregroundColor:
                                    AppColors
                                        .textPrimary,
                                elevation: 0,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 22,
                          ),

                          Row(
                            children: const [
                              Expanded(
                                child: Divider(),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets
                                        .symmetric(
                                  horizontal:
                                      12,
                                ),
                                child: Text(
                                  'OR',
                                  style:
                                      TextStyle(
                                    color:
                                        AppColors
                                            .textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 22,
                          ),

                          SizedBox(
                            width:
                                double.infinity,
                            height: 58,
                            child:
                                OutlinedButton.icon(
                              onPressed:
                                  () {
                                FeedbackDraft
                                    .clear();

                                FeedbackDraft
                                        .loginType =
                                    'email';

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            const UserDetailsScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons
                                    .email_outlined,
                              ),
                              label: const Text(
                                'Continue with Email',
                                style:
                                    TextStyle(
                                  fontSize:
                                      16,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
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
                                    16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Text(
                  '',
                  textAlign:
                      TextAlign.center,
                  style: TextStyle(
                    color:
                        AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}