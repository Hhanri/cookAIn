import 'package:cookain/home_navigation/domain/entities/home_nav_bar_item_entity.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final cubit = HomeNavigationCubit();

  group('home navigation cubit test', () {

    test('initial state', () {
      expect(cubit.state, HomeNavigationState.ingredients);
    });

    test('go to recipe test', () {
      cubit.changeView(HomeNavigationState.recipes);
      expect(cubit.state, HomeNavigationState.recipes);
    });

    test('go back to ingredients test', () {
      cubit.changeView(HomeNavigationState.ingredients);
      expect(cubit.state, HomeNavigationState.ingredients);
    });

  });

}