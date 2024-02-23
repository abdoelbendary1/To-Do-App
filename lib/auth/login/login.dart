import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app1/auth/FirebaseAuthServices.dart';
import 'package:todo_app1/auth/SignUp/SignUp.dart';
import 'package:todo_app1/auth/login/customTextField.dart';
import 'package:todo_app1/screens/homeScreen.dart';
import 'package:todo_app1/theme/AppTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static final String routeName = "/LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var user = FirebaseAuthServices();

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
                    Text(
                      AppLocalizations.of(context)!.hello,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppTheme.blackColor, fontSize: 40),
                    ),
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppTheme.blackColor, fontSize: 40),
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
                              return null;
                            },
                            hintText:
                                AppLocalizations.of(context)!.hintpassword,
                            controller: passwordController,
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
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        foregroundColor: AppTheme.whiteColor,
                        backgroundColor: AppTheme.blackColor,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
                          Navigator.pushNamed(context, SignUpScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.createAcc,
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

  void login() {
    if (formKey.currentState?.validate() == true) {
      user.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }
  }
}
