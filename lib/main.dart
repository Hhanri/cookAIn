import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/auth/presentation/pages/sign_in_page.dart';
import 'package:cookain/core/config/theme.dart';
import 'package:cookain/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cookain/core/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  setupSL();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthCubit>(
          create: (context) => sl.get<AuthCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: MyTheme.data,
        home: const SignInPage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
    );
  }
}
