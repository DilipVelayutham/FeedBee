import '../../../data/models/feedback_model.dart';

abstract class FeedbackEvent {}

class SubmitFeedbackEvent extends FeedbackEvent {
  final FeedbackModel feedback;

  SubmitFeedbackEvent(this.feedback);
}

class LoadFeedbacksEvent extends FeedbackEvent {}

class DeleteFeedbackEvent extends FeedbackEvent {
  final int id;

  DeleteFeedbackEvent(this.id);
}