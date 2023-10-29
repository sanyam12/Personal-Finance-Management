import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:personal_finance/core/theme/app_themes.dart';
import 'package:personal_finance/features/manage_finance/presentation/bloc/login/remote/login_bloc.dart';
import 'package:personal_finance/features/manage_finance/presentation/pages/home/finance.dart';
import 'package:personal_finance/features/manage_finance/presentation/pages/login/LoginScreen.dart';
import 'features/manage_finance/presentation/pages/signup/SignUpScreen.dart';
import 'firebase_options.dart';
import 'injection_container.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: user==null?'/login':'/home',
      routes: {
        '/login':(context)=>const LoginScreen(),
        '/signup':(context)=>const SignUpScreen(),
        '/home':(context)=>const FinanceScreen(),
      },
    );
  }

}