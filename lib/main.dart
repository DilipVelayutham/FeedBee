import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'di/service_locator.dart';

import 'presentation/bloc/feedback/feedback_bloc.dart';
import 'presentation/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initDependencies();

  runApp(
    const FeedBeeApp(),
  );
}

class FeedBeeApp extends StatelessWidget {
  const FeedBeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedbackBloc>(
          create: (_) => sl<FeedbackBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'FeedBee',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}