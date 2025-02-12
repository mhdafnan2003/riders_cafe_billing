import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:riders_cafe/Screen/Authentication/Login/loginscreen.dart';
import 'package:riders_cafe/service/authservice.dart';
import 'package:sidebarx/sidebarx.dart';

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: const Color.fromARGB(255, 254, 195, 2),
        // ignore: deprecated_member_use
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          // ignore: deprecated_member_use
          border: Border.all(color: Color(0xFF5F5FA7).withOpacity(0.6)),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 196, 0),
              Color.fromARGB(255, 60, 67, 0)
            ],
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  'Assets/Images/Authentication/logo.png',
                  width: 65,
                  height: 65,
                ),
                if (extended && !isSmallScreen)
                   Text(
                   ('${Get.find<AuthService>().getUser()?['name']}'),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
        );
      },
      items:  [
        SidebarXItem(
          icon: Icons.home,
          label: 'Dashboard',
        ),
        SidebarXItem(
          icon: Icons.search,
          label: 'Adding Products',
        ),
        SidebarXItem(
          icon: Icons.people,
          label: 'Billing',
        ),
        SidebarXItem(
          icon: Icons.favorite,
          label: 'Map',
        ),
        SidebarXItem(
          icon: Icons.favorite,
          label: 'Logout',
          onTap: ()=>{
          Get.find<AuthService>().logout(),
          Get.snackbar('Success', 'Logout Successful'),
          Get.offAll(() => LoginScreen())
          }
        ),
      ],
    );
  }
}

// ignore: deprecated_member_use
final divider = Divider(color: Colors.white.withOpacity(0.3), height: 1);
