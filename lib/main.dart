import 'package:dss_project/core/helper_functions/on_generate_routes.dart';
import 'package:dss_project/core/services/custom_bloc_observer.dart';
import 'package:dss_project/core/services/get_it_service.dart';
import 'package:dss_project/core/services/shared_preferences_singleton.dart';
import 'package:dss_project/features/splash/presentation/views/splash_view.dart';
import 'package:dss_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Judson'),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoutes,
      initialRoute: SplashView.routeName,
    );
  }
}
