import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/feedback_draft.dart';

import '../../../data/models/feedback_model.dart';

import '../../bloc/feedback/feedback_bloc.dart';
import '../../bloc/feedback/feedback_event.dart';

import '../thank_you/thank_you_screen.dart';

class MediaCollectionScreen extends StatefulWidget {
  const MediaCollectionScreen({super.key});

  @override
  State<MediaCollectionScreen> createState() =>
      _MediaCollectionScreenState();
}

class _MediaCollectionScreenState
    extends State<MediaCollectionScreen> {
  final ImagePicker _picker = ImagePicker();

  XFile? selectedImage;

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = image;
      });

      FeedbackDraft.imagePath =
          image.path;
    }
  }

  void submitFeedback() {
    final feedback = FeedbackModel(
      loginType:
          FeedbackDraft.loginType,
      name: FeedbackDraft.name,
      email: FeedbackDraft.email,
      mobile: FeedbackDraft.mobile,
      issueTitle:
          FeedbackDraft.issueTitle,
      issueDescription:
          FeedbackDraft.issueDescription,
      imagePath:
          FeedbackDraft.imagePath,
      videoPath:
          FeedbackDraft.videoPath,
      createdAt: DateTime.now(),
    );

    context.read<FeedbackBloc>().add(
          SubmitFeedbackEvent(
            feedback,
          ),
        );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const ThankYouScreen(),
      ),
    );
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
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Step 3 of 4",
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
                _stepLine(true),
                _stepCircle(true),
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
                      Icons.photo_camera,
                      size: 42,
                      color: AppColors
                          .primaryDark,
                    ),
                  ),

                  const SizedBox(
                      height: 16),

                  const Text(
                    "Attach Media",
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  const Text(
                    "Screenshots help us understand issues faster and improve the experience.",
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

            Expanded(
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  width:
                      double.infinity,
                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white,
                    borderRadius:
                        BorderRadius
                            .circular(
                      24,
                    ),
                    border:
                        Border.all(
                      color:
                          AppColors
                              .primary,
                      width: 2,
                    ),
                  ),
                  child:
                      selectedImage ==
                              null
                          ? Column(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                              children: const [
                                Icon(
                                  Icons
                                      .cloud_upload_outlined,
                                  size:
                                      70,
                                  color:
                                      AppColors.primaryDark,
                                ),
                                SizedBox(
                                    height:
                                        20),
                                Text(
                                  "Tap to Upload",
                                  style:
                                      TextStyle(
                                    fontSize:
                                        20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        8),
                                Text(
                                  "PNG, JPG or JPEG",
                                  style:
                                      TextStyle(
                                    color:
                                        AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(
                                24,
                              ),
                              child:
                                  Stack(
                                fit: StackFit
                                    .expand,
                                children: [
                                  Image.file(
                                    File(
                                      selectedImage!
                                          .path,
                                    ),
                                    fit: BoxFit
                                        .cover,
                                  ),
                                  Positioned(
                                    right:
                                        12,
                                    top:
                                        12,
                                    child:
                                        Container(
                                      padding:
                                          const EdgeInsets
                                              .all(
                                        8,
                                      ),
                                      decoration:
                                          const BoxDecoration(
                                        color:
                                            AppColors.success,
                                        shape:
                                            BoxShape.circle,
                                      ),
                                      child:
                                          const Icon(
                                        Icons
                                            .check,
                                        color:
                                            Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width:
                  double.infinity,
              height: 58,
              child:
                  ElevatedButton.icon(
                onPressed:
                    submitFeedback,
                icon:
                    const Icon(
                  Icons.send,
                ),
                label:
                    const Text(
                  "Submit Feedback",
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepCircle(
      bool active) {
    return Container(
      width: 28,
      height: 28,
      decoration:
          BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? AppColors.primary
            : Colors.grey.shade300,
      ),
    );
  }

  Widget _stepLine(
      bool active) {
    return Expanded(
      child: Container(
        height: 4,
        color: active
            ? AppColors.primary
            : Colors.grey.shade300,
      ),
    );
  }
}