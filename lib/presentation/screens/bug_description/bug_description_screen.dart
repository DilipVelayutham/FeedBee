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
        centerTitle: true,
        title: const Text(
          "Issue Details",
          style: TextStyle(
            color:
                AppColors.textPrimary,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
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

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                  child:
                      const LinearProgressIndicator(
                    value: 0.50,
                    minHeight: 8,
                    backgroundColor:
                        Color(
                      0xFFEAEAEA,
                    ),
                    color:
                        AppColors.primary,
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Describe the issue",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Tell us what happened and how we can reproduce it.",
                  style: TextStyle(
                    color:
                        AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 30),

                TextFormField(
                  controller:
                      _titleController,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
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
                          .bug_report_outlined,
                    ),
                    filled: true,
                    fillColor:
                        AppColors.surface,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: TextFormField(
                    controller:
                        _descriptionController,
                    maxLines: null,
                    expands: true,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return "Description is required";
                      }

                      return null;
                    },
                    decoration:
                        InputDecoration(
                      alignLabelWithHint:
                          true,
                      labelText:
                          "Describe the issue in detail...",
                      filled: true,
                      fillColor:
                          AppColors.surface,
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          16,
                        ),
                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                          16,
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
}