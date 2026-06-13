import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../../../data/models/feedback_model.dart';
import '../../../data/repositories/feedback_repository.dart';

import '../../../core/services/csv_export_service.dart';
import '../../../core/services/biometric_service.dart';

import '../../../di/service_locator.dart';

import '../auth/login_screen.dart';

class FeedbackHistoryScreen extends StatefulWidget {
  const FeedbackHistoryScreen({super.key});

  @override
  State<FeedbackHistoryScreen> createState() =>
      _FeedbackHistoryScreenState();
}

class _FeedbackHistoryScreenState
    extends State<FeedbackHistoryScreen> {
  final FeedbackRepository repository =
      sl<FeedbackRepository>();

  List<FeedbackModel> feedbacks = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFeedbacks();
  }

  Future<void> loadFeedbacks() async {
    try {
      final data =
          await repository.getAllFeedbacks();

      setState(() {
        feedbacks = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshData() async {
    await loadFeedbacks();
  }

  Future<void> _exportCsv() async {
    try {
      final feedbacks =
          await repository.getAllFeedbacks();

      final file =
          await CsvExportService()
              .exportFeedbacks(
        feedbacks,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'CSV exported: ${file.path}',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Export failed: $e',
          ),
        ),
      );
    }
  }

  Future<void> _authenticateAndExport() async {
    final authenticated =
        await BiometricService()
            .authenticate();

    if (!mounted) return;

    if (authenticated) {
      _exportCsv();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Biometric authentication failed',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'FeedBee History',
          style: TextStyle(
            color:
                AppColors.textPrimary,
            fontWeight:
                FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Export CSV',
            icon: const Icon(
              Icons.download,
            ),
            onPressed:
                _authenticateAndExport,
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : feedbacks.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh:
                      refreshData,
                  child: ListView(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(
                          20,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              AppColors.surface,
                          borderRadius:
                              BorderRadius
                                  .circular(
                            24,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withValues(
                                alpha: 0.04,
                              ),
                              blurRadius:
                                  12,
                              offset:
                                  const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  AppColors
                                      .primary
                                      .withValues(
                                alpha: 0.15,
                              ),
                              child:
                                  const Icon(
                                Icons
                                    .analytics_outlined,
                                color: AppColors
                                    .primaryDark,
                                size: 30,
                              ),
                            ),

                            const SizedBox(
                                height: 12),

                            Text(
                              '${feedbacks.length}',
                              style:
                                  const TextStyle(
                                fontSize: 32,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),

                            const Text(
                              'Total Feedback Reports',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 18),

                      ...feedbacks.map(
                        (item) =>
                            _buildFeedbackCard(
                          item,
                        ),
                      ),
                    ],
                  ),
                ),

      bottomNavigationBar:
          Padding(
        padding:
            const EdgeInsets.all(16),
        child: SizedBox(
          height: 58,
          child:
              ElevatedButton.icon(
            icon: const Icon(
              Icons.home_outlined,
            ),
            label: const Text(
              'Back to Home',
            ),
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.primary,
              foregroundColor:
                  AppColors
                      .textPrimary,
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
                      const LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(
    FeedbackModel item,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),
      padding:
          const EdgeInsets.all(
        18,
      ),
      decoration:
          BoxDecoration(
        color:
            AppColors.surface,
        borderRadius:
            BorderRadius.circular(
          20,
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 10,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            item.issueTitle,
            style:
                const TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
              height: 10),

          Text(
            item.issueDescription,
          ),

          const SizedBox(
              height: 16),

          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 18,
              ),
              const SizedBox(
                  width: 6),
              Expanded(
                child:
                    Text(item.name),
              ),
            ],
          ),

          const SizedBox(
              height: 8),

          Row(
            children: [
              const Icon(
                Icons.email_outlined,
                size: 18,
              ),
              const SizedBox(
                  width: 6),
              Expanded(
                child:
                    Text(item.email),
              ),
            ],
          ),

          const SizedBox(
              height: 8),

          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 18,
              ),
              const SizedBox(
                  width: 6),
              Expanded(
                child:
                    Text(item.mobile),
              ),
            ],
          ),

          const SizedBox(
              height: 14),

          Container(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration:
                BoxDecoration(
              color:
                  AppColors.primary
                      .withValues(
                alpha: 0.15,
              ),
              borderRadius:
                  BorderRadius
                      .circular(
                20,
              ),
            ),
            child: Text(
              item.loginType
                          .toLowerCase() ==
                      'google'
                  ? 'Google User'
                  : 'Email User',
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/feedbee_logo1.png',
              height: 90,
            ),

            const SizedBox(
                height: 20),

            const Text(
              'No Feedback Found',
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 8),

            const Text(
              'Submit feedback and it will appear here.',
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}