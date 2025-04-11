import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final Widget? footer;
  final EdgeInsets contentPadding;
  final bool centerContent;


  const PageWrapper({
    Key? key,
    required this.child,
    this.footer,
    required this.centerContent,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isWeb = kIsWeb;
    final bool isSmallScreen = screenSize.width < 800;

    return Container(
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
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      //Todo : find a image for logins and the menu for other screens
                      /* Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:  Image.asset(
                              'assets/images/bw.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),*/
                            Center(
                              child: Text(
                              "Company\n"
                                  "Marketing\n"
                                  "Sentence",
                              style: headlineTextStyle.copyWith(
                                  color: Colors.white),
                                                        ),
                            ),
                    ],
                  ),
                ),


              Expanded(
                flex: 1,
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
    );
  }
}
