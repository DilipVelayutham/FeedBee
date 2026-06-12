import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/feedback_draft.dart';

import '../media/media_collection_screen.dart';

class BugDescriptionScreen extends StatefulWidget {
  const BugDescriptionScreen({super.key});

  @override
  State<BugDescriptionScreen> createState() =>
      _BugDescriptionScreenState();
}

class _BugDescriptionScreenState
    extends State<BugDescriptionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController =
      TextEditingController();

  final _descriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleController.text =
        FeedbackDraft.issueTitle;

    _descriptionController.text =
        FeedbackDraft.issueDescription;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FeedbackDraft.issueTitle =
        _titleController.text.trim();

    FeedbackDraft.issueDescription =
        _descriptionController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const MediaCollectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,
        elevation: 0,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Step 2 of 4",
                  style: TextStyle(
                    color:
                        AppColors.primaryDark,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    _stepCircle(true),
                    _stepLine(true),
                    _stepCircle(true),
                    _stepLine(false),
                    _stepCircle(false),
                    _stepLine(false),
                    _stepCircle(false),
                  ],
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(
                    24,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        AppColors.surface,
                    borderRadius:
                        BorderRadius
                            .circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(
                          alpha: 0.05,
                        ),
                        blurRadius: 15,
                        offset:
                            const Offset(
                          0,
                          6,
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 38,
                        backgroundColor:
                            AppColors.primary
                                .withValues(
                          alpha: 0.2,
                        ),
                        child: const Icon(
                          Icons
                              .bug_report_outlined,
                          size: 42,
                          color: AppColors
                              .primaryDark,
                        ),
                      ),

                      const SizedBox(
                          height: 16),

                      const Text(
                        "Describe the Issue",
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight:
                              FontWeight
                                  .bold,
                          color: AppColors
                              .textPrimary,
                        ),
                      ),

                      const SizedBox(
                          height: 8),

                      const Text(
                        "Help us understand what happened and how we can improve.",
                        textAlign:
                            TextAlign.center,
                        style: TextStyle(
                          color: AppColors
                              .textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                TextFormField(
                  controller:
                      _titleController,
                  validator: (value) {
                    if (value == null ||
                        value.trim()
                            .isEmpty) {
                      return "Issue title is required";
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(
                    labelText:
                        "Issue Title",
                    prefixIcon:
                        const Icon(
                      Icons
                          .title_outlined,
                    ),
                    filled: true,
                    fillColor:
                        AppColors.surface,
                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 18,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        18,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller:
                      _descriptionController,
                  maxLines: 8,
                  validator: (value) {
                    if (value == null ||
                        value.trim()
                            .isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(
                    labelText:
                        "Describe the issue in detail",
                    alignLabelWithHint:
                        true,
                    filled: true,
                    fillColor:
                        AppColors.surface,
                    hintText:
                        "Explain what happened, what you expected, and any additional information...",
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        18,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width:
                      double.infinity,
                  height: 58,
                  child:
                      ElevatedButton(
                    onPressed:
                        _continue,
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
                          18,
                        ),
                      ),
                    ),
                    child:
                        const Text(
                      "Continue",
                      style:
                          TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepCircle(
      bool isActive) {
    return Container(
      width: 28,
      height: 28,
      decoration:
          BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.primary
            : Colors.grey.shade300,
      ),
    );
  }

  Widget _stepLine(
      bool isActive) {
    return Expanded(
      child: Container(
        height: 4,
        color: isActive
            ? AppColors.primary
            : Colors.grey.shade300,
      ),
    );
  }
}