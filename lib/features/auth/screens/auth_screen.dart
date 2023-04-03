import 'package:flutter/material.dart';
import 'package:shopcart/common/custom_buttom.dart';
import 'package:shopcart/common/custom_textfiel.dart';
import 'package:shopcart/constants/global_variables.dart';
import '.././services/authservices.dart';

enum Auth {
  signin,
  signup,
}

class Authscreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  Auth _auth = Auth.signup;

  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      email: emailcontroller.text,
      context: context,
      password: passwordcontroller.text,
      name: namecontroller.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      email: emailcontroller.text,
      context: context,
      password: passwordcontroller.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  ListTile(
                    tileColor: _auth == Auth.signup
                        ? GlobalVariables.backgroundColor
                        : GlobalVariables.greyBackgroundCOlor,
                    title: const Text(
                      'Create Account',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signup)
                    Container(
                      decoration: const BoxDecoration(
                          color: GlobalVariables.backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      padding: const EdgeInsets.all(8),
                      child: Form(
                        key: signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextfield(
                              controller: namecontroller,
                              hint: "Name",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextfield(
                              controller: emailcontroller,
                              hint: "Email",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextfield(
                              controller: passwordcontroller,
                              hint: "Password",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButton(
                              text: 'Sign Up',
                              onTap: () {
                                if (signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),

                  /* Sign Up */
                  ListTile(
                    tileColor: _auth == Auth.signup
                        ? GlobalVariables.backgroundColor
                        : GlobalVariables.greyBackgroundCOlor,
                    title: const Text(
                      'Sign in',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signin)
                    Container(
                      decoration: const BoxDecoration(
                          color: GlobalVariables.backgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      padding: const EdgeInsets.all(8),
                      child: Form(
                          key: signInFormKey,
                          child: Column(
                            children: [
                              CustomTextfield(
                                controller: emailcontroller,
                                hint: "Email",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfield(
                                controller: passwordcontroller,
                                hint: "Password",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                  text: 'Sign In',
                                  onTap: () {
                                    if (signInFormKey.currentState!
                                        .validate()) {
                                      signInUser();
                                    }
                                  })
                            ],
                          )),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
