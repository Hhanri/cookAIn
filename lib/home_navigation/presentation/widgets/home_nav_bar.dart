import 'package:cookain/home_navigation/domain/entities/home_nav_bar_item_entity.dart';
import 'package:cookain/home_navigation/presentation/cubits/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: context.select<HomeNavigationCubit, int>((value) => value.state.index),
      onDestinationSelected: (index) {
        context.read<HomeNavigationCubit>().changeView(HomeNavBarItemEntity.values[index].state);
      },
      destinations: HomeNavBarItemEntity
        .values
        .map((e) => NavigationDestination(icon: Icon(e.icon), label: e.label,))
        .toList()
    );
  }
}

