import 'package:cookain/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Placeholder(),
          const Text("Welcome to CookAIn"),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSignedIn) {
                return const Text("Signed in");
              }
              if (state is AuthSignedOut) {
                return ElevatedButton(
                  onPressed: context.read<AuthCubit>().signInWithGoogle,
                  child: const Text("Sign in with Google")
                );
              }
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
