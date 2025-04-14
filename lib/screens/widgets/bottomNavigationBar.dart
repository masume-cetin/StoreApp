import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigationBarCubit.dart';
import '../../utils/theme.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<NavigationCubit>().state;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => context.read<NavigationCubit>().selectTab(index),
      type: BottomNavigationBarType.fixed, // Ensures all items are always visible
      backgroundColor: appBarColor,
      selectedItemColor: textColorPrimary,
      unselectedItemColor: textColorSecondary,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      iconSize: 24,
      showUnselectedLabels: true,
      items: [
        _buildNavItem("assets/icons/home.png", "Home", currentIndex == 0),
        _buildNavItem("assets/icons/love.png", "Favorite", currentIndex == 1),
        _buildNavItem("assets/icons/mart.png", "Stores", currentIndex == 2),
        _buildNavItem("assets/icons/cart.png", "Cart", currentIndex == 3),
        _buildNavItem("assets/icons/user.png", "Account", currentIndex == 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(String iconPath, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        color: isSelected ? textColorPrimary : textColorSecondary,
      ),
      label: label,
    );
  }
}

