import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:store_app/screens/widgets/searchBarWidget.dart';
import 'package:store_app/utils/theme.dart';
import 'bottomNavigationBar.dart';
import 'draweMenu.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final Widget? footer;
  final EdgeInsets contentPadding;
  final bool showSideImage;
  final bool showAppBarMenu;
  final bool centerContent;
  final bool showBottomNavigationBar;
  final bool showSearchBar;
  final bool showAppBarActions;


  const PageWrapper({
    super.key,
    required this.child,
    this.footer,
    required this.showAppBarMenu,
    required this.centerContent,
    required this.showSideImage,
    required this.showBottomNavigationBar,
    required this.showSearchBar,
    required this.showAppBarActions,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isWeb = kIsWeb;
    final bool isSmallScreen = screenSize.width < 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: showBottomNavigationBar ? const BottomNavigationBarWidget() : null,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: showSearchBar ? SearchBarTextField(onCameraTap: () {
          // Future action here
         // Navigator.pushNamed(context, "/image-search");
        },) : const Text(
          "Fate",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: showAppBarMenu || !showSideImage
            ? Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        )
            : null,
        actions: showAppBarActions
            ? [
          IconButton(
            tooltip: "Updates",
            icon: const Icon(Icons.notifications_none, color: textColorPrimary),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Messages",
            icon: const Icon(Icons.message_outlined, color: textColorPrimary),
            onPressed: () {},
          ),
        ]
            : null,

      ),
      drawer: const DrawerMenu(),
      body: Container(
        height: screenSize.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD9D9D9), // shiny silver
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: isSmallScreen
            // 🌐 MOBILE / SMALL SCREEN
                ? Padding(
              padding: contentPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(child: child),
                  ),
                  if (footer != null) ...[
                    const SizedBox(height: 32),
                    footer!,
                  ],
                ],
              ),
            )

            // 🖥️ WEB / LARGE SCREEN
                : Row(
              children: [
                // Left image only for larger screens
                if (isWeb)
                  if (isWeb && showSideImage)
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/clothingBrandIllustration.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                Expanded(
                  flex: 2,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: contentPadding,
                              child: Column(
                                mainAxisAlignment: centerContent ? MainAxisAlignment.center : MainAxisAlignment.start,
                                children: [
                                  child,
                                  if (footer != null) ...[
                                    const SizedBox(height: 32),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: footer!,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
