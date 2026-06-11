import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/feedback_draft.dart';

import '../bug_description/bug_description_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() =>
      _UserDetailsScreenState();
}

class _UserDetailsScreenState
    extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _mobileController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController.text =
        FeedbackDraft.name;

    _emailController.text =
        FeedbackDraft.email;

    _mobileController.text =
        FeedbackDraft.mobile;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();

    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FeedbackDraft.name =
        _nameController.text.trim();

    FeedbackDraft.email =
        _emailController.text.trim();

    FeedbackDraft.mobile =
        _mobileController.text.trim();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const BugDescriptionScreen(),
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
          "User Details",
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
                  "Step 1 of 4",
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
                    value: 0.25,
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
                  "Tell us about yourself",
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
                  "We need some details before collecting feedback.",
                  style: TextStyle(
                    color:
                        AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 30),

                _buildTextField(
                  controller:
                      _nameController,
                  label:
                      "Full Name",
                  icon: Icons
                      .person_outline,
                ),

                const SizedBox(height: 18),

                _buildTextField(
                  controller:
                      _emailController,
                  label:
                      "Email Address",
                  icon: Icons
                      .email_outlined,
                  keyboardType:
                      TextInputType
                          .emailAddress,
                ),

                const SizedBox(height: 18),

                _buildTextField(
                  controller:
                      _mobileController,
                  label:
                      "Mobile Number",
                  icon:
                      Icons.phone_outlined,
                  keyboardType:
                      TextInputType.phone,
                ),

                const Spacer(),

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
                        fontWeight:
                            FontWeight
                                .w600,
                        fontSize: 16,
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

  Widget _buildTextField({
    required TextEditingController
        controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType =
        TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType:
          keyboardType,
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty) {
          return 'Required field';
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor:
            AppColors.surface,
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            16,
          ),
          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}