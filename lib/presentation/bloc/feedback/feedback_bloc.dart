import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/feedback_repository.dart';

import '../../../di/service_locator.dart';

import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc
    extends Bloc<FeedbackEvent, FeedbackState> {

  final FeedbackRepository repository =
      sl<FeedbackRepository>();

  FeedbackBloc()
      : super(FeedbackInitial()) {

    on<SubmitFeedbackEvent>(
      _submitFeedback,
    );

    on<LoadFeedbacksEvent>(
      _loadFeedbacks,
    );

    on<DeleteFeedbackEvent>(
      _deleteFeedback,
    );
  }

  Future<void> _submitFeedback(
    SubmitFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    try {
      emit(FeedbackLoading());

      await repository.insertFeedback(
        event.feedback,
      );

      emit(FeedbackSuccess());
    } catch (e) {
      emit(
        FeedbackError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _loadFeedbacks(
    LoadFeedbacksEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    try {
      emit(FeedbackLoading());

      final feedbacks =
          await repository.getAllFeedbacks();

      emit(
        FeedbackLoaded(feedbacks),
      );
    } catch (e) {
      emit(
        FeedbackError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _deleteFeedback(
    DeleteFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    try {
      await repository.deleteFeedback(
        event.id,
      );

      add(
        LoadFeedbacksEvent(),
      );
    } catch (e) {
      emit(
        FeedbackError(
          e.toString(),
        ),
      );
    }
  }
}