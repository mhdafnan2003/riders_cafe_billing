import 'package:flutter/material.dart';
import 'package:riders_cafe/Screen/Panels/branch/dashboard/dashboardcontent.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:riders_cafe/Screen/Panels/branch/Billings/billing.dart';
import 'package:riders_cafe/Screen/Panels/branch/Map/mapscreen.dart';
import 'package:riders_cafe/Screen/Panels/branch/addingProducts/addingproducts.dart';


class ScreensExample extends StatelessWidget {
  const ScreensExample({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;
  

  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {

        final index = controller.selectedIndex.clamp(0, 3);

        final screens = [
          const DashboardContent(),
          const Addingproducts(),
          const Billing(),
          const Mapscreen(),
        ];

        return screens[index];
      },
    );
  }
}