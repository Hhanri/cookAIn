import 'package:cookain/core/cubits/my_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocListener<C extends Cubit<I>, I extends MyBlocState> extends StatelessWidget {
  const MyBlocListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, I>(
      listener: (context, state) {
        if (state.isLoading) {
          
        }
        if (state.success != null) {
          
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      }
    );
  }
}
