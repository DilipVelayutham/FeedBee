import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../../../data/models/feedback_model.dart';
import '../../../data/repositories/feedback_repository.dart';

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
          'Feedback History',
          style: TextStyle(
            color:
                AppColors.textPrimary,
            fontWeight:
                FontWeight.w600,
          ),
        ),
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
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(
                      16,
                    ),
                    itemCount:
                        feedbacks.length,
                    itemBuilder:
                        (context, index) {
                      final item =
                          feedbacks[index];

                      return Card(
                        elevation: 2,
                        margin:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            16,
                          ),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(
                            16,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              Text(
                                item.issueTitle,
                                style:
                                    const TextStyle(
                                  fontSize:
                                      18,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                  height:
                                      8),

                              Text(
                                item.issueDescription,
                              ),

                              const SizedBox(
                                  height:
                                      12),

                              const Divider(),

                              Text(
                                'Name: ${item.name}',
                              ),

                              Text(
                                'Email: ${item.email}',
                              ),

                              Text(
                                'Mobile: ${item.mobile}',
                              ),

                              const SizedBox(
                                  height:
                                      8),

                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal:
                                      10,
                                  vertical:
                                      5,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color:
                                      AppColors
                                          .primary
                                          .withValues(
                                    alpha:
                                        0.15,
                                  ),
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    12,
                                  ),
                                ),
                                child: Text(
                                  item.loginType
                                      .toUpperCase(),
                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

      bottomNavigationBar:
          Padding(
        padding:
            const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton.icon(
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
                  16,
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 80,
              color:
                  AppColors.textSecondary,
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
              'Submit some feedback and it will appear here.',
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}