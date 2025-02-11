import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final _storage = GetStorage();
  final RxBool isLoggedIn = false.obs;
  
  Future<AuthService> init() async {
    // Check if token exists in storage
    String? token = _storage.read('token');
    isLoggedIn.value = token != null;
    return this;
  }

  void login(String token, Map<String, dynamic> userData) {
    _storage.write('token', token);
    _storage.write('user', userData);
    isLoggedIn.value = true;
  }

  void logout() {
    _storage.remove('token');
    _storage.remove('user');
    isLoggedIn.value = false;
  }
                                                                        
  String? getToken() => _storage.read('token');
  Map<String, dynamic>? getUser() => _storage.read('user');
}