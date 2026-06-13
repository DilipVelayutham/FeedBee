import 'dart:io';

import 'package:csv/csv.dart';

import '../../data/models/feedback_model.dart';

class CsvExportService {
  Future<File> exportFeedbacks(
    List<FeedbackModel> feedbacks,
  ) async {
    List<List<dynamic>> rows = [];

    rows.add([
      'Device Owner',
      'User Details',
      'Bug/Issue',
      'User Device',
      'Description and Media Links',
    ]);

    for (final feedback in feedbacks) {
      rows.add([
        feedback.name,
        '${feedback.email} | ${feedback.mobile}',
        feedback.issueTitle,
        feedback.loginType,
        '${feedback.issueDescription}\n'
            'Image: ${feedback.imagePath ?? ""}\n'
            'Video: ${feedback.videoPath ?? ""}',
      ]);
    }

    String csvData =
        const ListToCsvConverter().convert(rows);

    final file = File(
      'feedback_export.csv',
    );

    await file.writeAsString(csvData);

    return file;
  }
}