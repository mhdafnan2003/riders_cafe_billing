import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/service/authservice.dart';
import 'package:sidebarx/sidebarx.dart';

class Customappbar extends StatelessWidget implements PreferredSizeWidget {
  const Customappbar({
    super.key,
    required this.controller,
    required this.scaffoldKey,
  });

  final SidebarXController controller;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title:  Text('${Get.find<AuthService>().getUser()?['name']}'),
      leading: IconButton(
        onPressed: () {
          if (!Platform.isAndroid && !Platform.isIOS) {
            controller.setExtended(true);
          }
          scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}