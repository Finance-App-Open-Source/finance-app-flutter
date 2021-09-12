import 'package:finance_app/app/data/repositories/auth_repository.dart';
import 'package:finance_app/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:finance_app/app/routes/app_pages.dart';
import 'package:finance_app/app/data/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginController extends GetxController {
  final AuthRepository _repository = Get.find<AuthRepository>();
  String _email = "eve.holt@reqres.in";
  String _password = "cityslicka";
  final authController = Get.find<AuthController>();

  String get email => _email;
  String get password => _password;
  set email(value) => _email = value;
  set password(value) => _password = value;

  void login(runMutation) async {
    print("Email: $_email, Password: $_password");

    runMutation({
      "loginInput": {
        "email": _email,
        "password": _password,
      }
    });
  }

  loginOnError(OperationException error) {
    final message = error.graphqlErrors[0].message;
    return Get.snackbar(
      "Oops!",
      message,
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  loginCompleted(resultData) {
    if (resultData != null) {
      final response = resultData['login'];
      if (!response['success']) {
        return Get.snackbar(
          "Oops!",
          response['message'],
          icon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
      final user = User.fromJson(response['user']);
      authController.setAuthInfo(user, response['accessToken']);
      Get.rootDelegate.offAndToNamed(Routes.BOTTOM_TABS);
      Get.snackbar(
        "¡Bienvenido!",
        "Hola!, ${user.name} ${user.surname}",
        icon: Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
    }
  }
}
