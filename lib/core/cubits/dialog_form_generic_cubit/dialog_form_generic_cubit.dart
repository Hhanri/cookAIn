import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DialogFormGenericCubit<T, S> extends Cubit<S> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DialogFormGenericCubit(super.initialState);

  void init();

  void upload(BuildContext context);

  bool get canEditName;
}
