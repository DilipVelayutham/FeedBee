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
                  "Step 1 of 4",
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
                    _stepLine(),
                    _stepCircle(false),
                    _stepLine(),
                    _stepCircle(false),
                    _stepLine(),
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
                          Icons.person,
                          size: 42,
                          color: AppColors
                              .primaryDark,
                        ),
                      ),

                      const SizedBox(
                          height: 16),

                      const Text(
                        "Tell us about yourself",
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
                        "We need a few details before collecting feedback.",
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

  Widget _stepLine() {
    return Expanded(
      child: Container(
        height: 4,
        color: Colors.grey.shade300,
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
        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 18,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            18,
          ),
          borderSide:
              BorderSide.none,
        ),
      ),
    );
  }
}