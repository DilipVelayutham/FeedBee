import '../../../data/models/feedback_model.dart';

abstract class FeedbackState {}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoaded extends FeedbackState {
  final List<FeedbackModel> feedbacks;

  FeedbackLoaded(this.feedbacks);
}

class FeedbackSuccess extends FeedbackState {}

class FeedbackError extends FeedbackState {
  final String message;

  FeedbackError(this.message);
}