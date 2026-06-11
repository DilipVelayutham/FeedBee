class FeedbackDraft {
  static String loginType = 'guest';

  static String name = '';
  static String email = '';
  static String mobile = '';

  static String issueTitle = '';
  static String issueDescription = '';

  static String? imagePath;
  static String? videoPath;

  static void clear() {
    loginType = 'guest';

    name = '';
    email = '';
    mobile = '';

    issueTitle = '';
    issueDescription = '';

    imagePath = null;
    videoPath = null;
  }
}