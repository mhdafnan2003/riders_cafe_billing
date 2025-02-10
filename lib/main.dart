import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:riders_cafe/myapp.dart';
import 'package:riders_cafe/service/authservice.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => AuthService().init());
  runApp(const MyApp());
}