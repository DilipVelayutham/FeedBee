import '../database/database_helper.dart';
import '../models/feedback_model.dart';

class FeedbackRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<int> insertFeedback(
    FeedbackModel feedback,
  ) async {
    final db = await _databaseHelper.database;

    return await db.insert(
      'feedbacks',
      feedback.toMap(),
    );
  }

  Future<List<FeedbackModel>> getAllFeedbacks()
  async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'feedbacks',
      orderBy: 'id DESC',
    );

    return result
        .map(
          (e) => FeedbackModel.fromMap(e),
        )
        .toList();
  }

  Future<int> deleteFeedback(
    int id,
  ) async {
    final db = await _databaseHelper.database;

    return await db.delete(
      'feedbacks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearFeedbacks() async {
    final db = await _databaseHelper.database;

    await db.delete('feedbacks');
  }
}