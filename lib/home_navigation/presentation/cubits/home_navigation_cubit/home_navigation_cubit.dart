import 'package:cookain/home_navigation/domain/entities/home_nav_bar_item_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavigationCubit extends Cubit<HomeNavigationState> {

  final PageController controller = PageController();

  HomeNavigationCubit() : super(HomeNavigationState.ingredients);

  void changeView(HomeNavigationState state) {
    emit(state);
    controller.jumpToPage(state.index);
  }

  @override
  Future<void> close() async {
    controller.dispose();
    return super.close();
  }
}