class FeedbackModel {
  final int? id;

  final String loginType;

  final String name;
  final String email;
  final String mobile;

  final String issueTitle;
  final String issueDescription;

  final String? imagePath;
  final String? videoPath;

  final DateTime createdAt;

  FeedbackModel({
    this.id,
    required this.loginType,
    required this.name,
    required this.email,
    required this.mobile,
    required this.issueTitle,
    required this.issueDescription,
    this.imagePath,
    this.videoPath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'loginType': loginType,
      'name': name,
      'email': email,
      'mobile': mobile,
      'issueTitle': issueTitle,
      'issueDescription': issueDescription,
      'imagePath': imagePath,
      'videoPath': videoPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FeedbackModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return FeedbackModel(
      id: map['id'],
      loginType: map['loginType'] ?? 'guest',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      issueTitle: map['issueTitle'] ?? '',
      issueDescription:
          map['issueDescription'] ?? '',
      imagePath: map['imagePath'],
      videoPath: map['videoPath'],
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
    );
  }

  FeedbackModel copyWith({
    int? id,
    String? loginType,
    String? name,
    String? email,
    String? mobile,
    String? issueTitle,
    String? issueDescription,
    String? imagePath,
    String? videoPath,
    DateTime? createdAt,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      loginType:
          loginType ?? this.loginType,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      issueTitle:
          issueTitle ?? this.issueTitle,
      issueDescription:
          issueDescription ??
              this.issueDescription,
      imagePath:
          imagePath ?? this.imagePath,
      videoPath:
          videoPath ?? this.videoPath,
      createdAt:
          createdAt ?? this.createdAt,
    );
  }
}