import 'package:cookain/core/cubits/my_bloc_state.dart';
import 'package:cookain/core/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocListener<C extends Cubit<I>, I extends MyBlocState> extends StatelessWidget {
  final Widget child;
  const MyBlocListener({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, I>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen.instance().show(context: context);
        } else {
          LoadingScreen.instance().hide();
        }
        if (state.success != null) {
          
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: child,
    );
  }
}
