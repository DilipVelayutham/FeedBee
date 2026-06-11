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
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Attach Media",
          style: TextStyle(
            color:
                AppColors.textPrimary,
            fontWeight:
                FontWeight.w600,
          ),
        ),
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

            const SizedBox(height: 8),

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(
                10,
              ),
              child:
                  const LinearProgressIndicator(
                value: 0.75,
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
              "Attach Screenshots",
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
              "Images help us understand the issue faster.",
              style: TextStyle(
                color:
                    AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 220,
                width: double.infinity,
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius
                          .circular(
                    20,
                  ),
                  border: Border.all(
                    color:
                        AppColors.primary,
                    width: 2,
                  ),
                ),
                child: selectedImage ==
                        null
                    ? const Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          Icon(
                            Icons
                                .cloud_upload_outlined,
                            size: 50,
                            color:
                                AppColors.primaryDark,
                          ),
                          SizedBox(
                              height: 10),
                          Text(
                            "Tap to upload image",
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "Image Selected ✓",
                          style:
                              TextStyle(
                            color:
                                AppColors.success,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width:
                  double.infinity,
              height: 58,
              child:
                  ElevatedButton(
                onPressed:
                    submitFeedback,
                style:
                    ElevatedButton
                        .styleFrom(
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
                child:
                    const Text(
                  "Submit Feedback",
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
    );
  }
}