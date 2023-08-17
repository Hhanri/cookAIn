import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2,),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: Image.asset(
                'assets/livre-de-recettes.png'
              ),
            ),
            const Spacer(flex: 2,),
            Text(
              "Welcome to CookAIn",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Spacer(),
            Text(
              "Keep track of your food supply and your cookbook !",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(flex: 2,),
            FilledButton.tonalIcon(
              onPressed: context.read<AuthCubit>().signInWithGoogle,
              icon: const Text("Sign in with Google"),
              label: const Icon(Icons.arrow_forward),
            ),
            const Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
