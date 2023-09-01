import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());
  final state = Get
      .find<LoginLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: logic.email,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Email",
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide.none),
                          suffixIcon: Icon(
                            Icons.send_outlined,
                            color: Colors.green,
                          )),
                    ),
                  )
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: logic.password,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: "Password",
                          fillColor: Colors.black12,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide.none),
                          suffixIcon: Icon(
                            Icons.send_outlined,
                            color: Colors.green,
                          )),
                    ),
                  )
                ]),
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text("Login"),
                      onPressed: () {},
                    ),
                    Obx(() {
                      return ElevatedButton(
                        child: logic.createUserState.value == SetState.LOADING
                            ? SizedBox(height: 40, width: 40,
                          child: CupertinoActivityIndicator(
                            color: Colors.purple,
                          ),
                        )
                            : Text("Creat User"),
                        onPressed: () {
                          logic.createUser();
                        },
                      );
                    }),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}