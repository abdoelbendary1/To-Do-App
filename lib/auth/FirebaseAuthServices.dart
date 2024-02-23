// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app1/dialogUtils.dart';
import 'package:todo_app1/screens/homeScreen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirebaseAuthServices {
  final FirebaseAuth _db = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final credential = await _db.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("create success!");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      /*  DialogUtils.showLoading(context: context, message: "Loading...");

      //hide Loading
      DialogUtils.hideLoading(
        context,
      );
      DialogUtils.showMessage(
        context: context,
        message: "${e.toString()}",
        title: "Error",
        posActionName: "try again",
      ); */
      if (e.code == 'weak-password') {
        DialogUtils.showLoading(context: context, message: "Loading...");

        //hide Loading
        DialogUtils.hideLoading(
          context,
        );
        DialogUtils.showMessage(
          context: context,
          message: "${e.toString()}",
          title: "Error",
          posActionName: "try again",
        );
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showLoading(context: context, message: "Loading...");

        //hide Loading
        DialogUtils.hideLoading(
          context,
        );
        DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.message1,
          title: AppLocalizations.of(context)!.title,
          posActionName: AppLocalizations.of(context)!.posActionName2,
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      //show loading
      DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.message6,
      );
      Future.delayed(Duration(seconds: 2));

      final credential = await _db.signInWithEmailAndPassword(
          email: email, password: password);
      print("Login success!");

      //hide Loading
      DialogUtils.hideLoading(
        context,
      );
      DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.message2,
          posActionName: AppLocalizations.of(context)!.posActionName,
          posAction: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          });

      return credential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'invalid-email') {
        DialogUtils.showLoading(context: context, message: "Loading...");

        //hide Loading
        DialogUtils.hideLoading(
          context,
        );
        DialogUtils.showMessage(
          context: context,
          message: "No user found for that email",
          title: "Error",
          posActionName: "try again",
        );
        print('No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        DialogUtils.showLoading(context: context, message: "loading...");

        //hide Loading
        DialogUtils.hideLoading(
          context,
        );
        DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.message3,
          title: AppLocalizations.of(context)!.title,
          posActionName: AppLocalizations.of(context)!.posActionName2,
        );
        print('wrong password.');
      } else if (e.code == 'too-many-requests') {
        DialogUtils.showLoading(context: context, message: "loading...");

        //hide Loading
        DialogUtils.hideLoading(
          context,
        );
        DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.message4,
          title: AppLocalizations.of(context)!.title,
          posActionName: AppLocalizations.of(context)!.posActionName2,
        );

        print("too-many-requests");
      }
    } catch (e) {
      print(" error");
    }
  }

  void signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  }
}
