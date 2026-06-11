import 'package:get_it/get_it.dart';
import '../presentation/bloc/feedback/feedback_bloc.dart';
import '../data/repositories/feedback_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<
      FeedbackRepository>(
    () => FeedbackRepository(),
  );
  sl.registerFactory(
  () => FeedbackBloc(),
  );
}