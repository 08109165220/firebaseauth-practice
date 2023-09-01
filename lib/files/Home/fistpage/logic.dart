
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/message.dart';
import '../../constants/sharedpreference.dart';
import 'state.dart';

enum SetState { LOADING, LOADED, ERROR }

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var loginState = SetState.LOADED.obs;
  var createUserState = SetState.LOADED.obs;
  late final SharedPreferences prefs;

  @override
  Future<void> onReady() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();
    // TODO: implement onReady
    super.onReady();
  }
  Future createUser() async {
    if (email.text.isEmpty) {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //     SnackBar(content: Text("hello"),));

      Message.showMessage(message: "Empty Email", isError: true);
    } else if (!email.text.isEmail) {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //     SnackBar(content: Text("hello"),));

      Message.showMessage(message: "Wrong Email address", isError: true);
    } else if (password.text.isEmpty) {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //     SnackBar(content: Text("hello"),));

      Message.showMessage(message: "Empty Password", isError: true);
    } else if (password.text.length < 8) {
      // ScaffoldMessenger.of(Get.context!).showSnackBar(
      //     SnackBar(content: Text("hello"),));

      Message.showMessage(message: "Password is less than 8", isError: true);
    } else {
      createUserState.value = SetState.LOADING;
      try {
        UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        Message.showMessage(
            message: "'Successfully created an account", isError: false);

        createUserState.value = SetState.LOADED;
        print("email ${credential.user!.email}");
        print("displayName ${credential.user!.displayName}");
        print("emailVerified ${credential.user!.emailVerified}");
        print("uid ${credential.user!.uid}");
        print("phoneNumber ${credential.user!.phoneNumber}");
        print("photoURL ${credential.user!.photoURL}");
        prefs.setString(SharedPreferenceKeys.uID, credential.user!.uid).then((value) {
          String ?uid=prefs.getString(SharedPreferenceKeys.uID);
          print(' my pref uid =$uid');
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          Message.showMessage(
              message: "'The password provided is too weak.", isError: true);
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          Message.showMessage(
              message: 'The account already exists for that email.',
              isError: true);
        }
        createUserState.value = SetState.ERROR;
      } catch (e) {
        createUserState.value = SetState.ERROR;
        Message.showMessage(message: "An error just occured", isError: true);

        print(e);
    }
    }
    }
}