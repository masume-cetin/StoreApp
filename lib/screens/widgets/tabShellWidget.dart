import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/pageWrapperWidget.dart';

import '../../cubits/navigationBarCubit.dart';
import '../tab_screens/accountScreen.dart';
import '../tab_screens/cartScreen.dart';
import '../tab_screens/favoritesScreen.dart';
import '../tab_screens/mainScreen.dart';
import '../tab_screens/storesScreen.dart';

class TabShell extends StatelessWidget {
  const TabShell({super.key});

  static final List<Widget> _pages = [
    const MainScreen(),
    const FavoritesScreen(),
    const StoresScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final index = context.watch<NavigationCubit>().state;

    return PageWrapper(
      showAppBarActions: true,
      showSearchBar: true,
      showAppBarMenu: true,
      showSideImage: false,
      showBottomNavigationBar: true,
      centerContent: false,
      child: _pages[index],
    );
  }
}
