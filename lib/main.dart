import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:cookain/core/config/router.dart';
import 'package:cookain/core/config/theme.dart';
import 'package:cookain/firebase_options.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => sl.get<AuthCubit>(),
        ),
        BlocProvider<HomeNavigationCubit>(
          create: (context) => sl.get<HomeNavigationCubit>()
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: MyTheme.data,
        routerConfig: sl.get<MyGoRouter>().router,
      ),
    );
  }
}
