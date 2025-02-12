import 'package:flutter/material.dart';
import 'package:riders_cafe/Screen/Panels/branch/dashboard/widgets/customappbar.dart';
import 'package:riders_cafe/Screen/Panels/panelpages.dart';
import 'package:riders_cafe/controllers/sidebarcontroller.dart';
import 'package:riders_cafe/utils/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primary,
      body: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen 
                ? Customappbar(
                    controller: _controller,
                    scaffoldKey: _key,
                  ) 
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: ScreensExample(controller: _controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}