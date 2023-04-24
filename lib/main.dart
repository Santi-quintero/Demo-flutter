import 'package:auth_firebase/provider/providers.dart';
import 'package:auth_firebase/screens/screens.dart';
import 'package:auth_firebase/theme/app_theme.dart';
import 'package:auth_firebase/widgets/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAvRJPbGhfA6K9Ze_qxUEYsceCzYXE0eSs",
          authDomain: "saludonline-dev.firebaseapp.com",
          databaseURL: "https://saludonline-dev-default-rtdb.firebaseio.com",
          projectId: "saludonline-dev",
          storageBucket: "saludonline-dev.appspot.com",
          messagingSenderId: "46308265011",
          appId: "1:46308265011:web:409192f74b035dbdfde746",
          measurementId: "G-RJDVY2PN9M"));

  return runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterFormProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Firebase',
      theme: AppTheme.lightTheme,
      // home: const LoginScreen(),
    routes: AppRouter.getAppRoutes(),

    // routes: {
    //   '/login': (_) => const LoginScreen(),
    //   '/home': (_) => const HomeScreen(),
    //   '/about': (_) => const AboutScreen(),
    //   '/contact': (_) => const ContactScreen(),
    //   '/signature': (_) => const ContactScreen(),
    // },
     home: const Wrapper(),
      
    );
  }
}
