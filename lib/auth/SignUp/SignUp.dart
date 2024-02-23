import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app1/auth/FirebaseAuthServices.dart';
import 'package:todo_app1/auth/login/customTextField.dart';
import 'package:todo_app1/auth/login/login.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});
  static final String routeName = "/SignUpScreen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  FirebaseAuthServices user = FirebaseAuthServices();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.createAcc,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppTheme.blackColor, fontSize: 40),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .errorUsername;
                              }
                              return null;
                            },
                            hintText: AppLocalizations.of(context)!.username,
                            controller: usernameController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!.errorEmail;
                              }
                              final bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text);
                              if (emailValid == false) {
                                return AppLocalizations.of(context)!
                                    .errorEmail2;
                              }
                              return null;
                            },
                            hintText: AppLocalizations.of(context)!.hintEmail,
                            controller: emailController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .errorPassword;
                              }
                              if (text.length < 6) {
                                return AppLocalizations.of(context)!
                                    .errorPassword2;
                              }
                              return null;
                            },
                            hintText:
                                AppLocalizations.of(context)!.hintpassword,
                            controller: passwordController,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .errorConfirmPass;
                              }
                              if (text != passwordController.text) {
                                return AppLocalizations.of(context)!
                                    .errorConfirmPass2;
                              }
                              return null;
                            },
                            hintText:
                                AppLocalizations.of(context)!.confirmPassword,
                            controller: confirmPasswordController,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/google.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "assets/images/facebook.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        foregroundColor: AppTheme.whiteColor,
                        backgroundColor: AppTheme.blackColor,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppTheme.whiteColor),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.alreadyHaveAcc,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (formKey.currentState?.validate() == true) {
      user.signUpWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          context: context);
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
  }
}
