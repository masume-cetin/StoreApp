import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/page_wrapper_widget.dart';

import '../../cubits/navigation_bar_cubit.dart';
import '../tab_screens/account_page.dart';
import '../tab_screens/cart_page.dart';
import '../tab_screens/favorites_page.dart';
import '../tab_screens/home_page.dart';
import '../tab_screens/stores_page.dart';

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
