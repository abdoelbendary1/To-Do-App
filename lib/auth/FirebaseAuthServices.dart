// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo_app1/auth/login/login.dart';
import 'package:todo_app1/dialogUtils.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/user.dart';
import 'package:todo_app1/screens/homeScreen.dart';
import 'package:todo_app1/providers/auth_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirebaseAuthServices {
  final FirebaseAuth _db = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required BuildContext context}) async {
    try {
      DialogUtils.showLoading(
        context: context,
        message: AppLocalizations.of(context)!.message6,
      );
      final credential = await _db.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser = MyUser(
        id: credential.user?.uid ?? "",
        name: username,
        email: email,
      );
      var authProvider =
          Provider.of<AuthinticationProvider>(context, listen: false);
      authProvider.updateUser(myUser);

      await FireBaseUtils.addUserToFireStore(myUser);
      DialogUtils.hideLoading(
        context,
      );
      print("create success!");

      DialogUtils.showMessage(
          context: context,
          message: AppLocalizations.of(context)!.message2,
          posActionName: AppLocalizations.of(context)!.posActionName,
          posAction: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          });
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
        /* DialogUtils.showLoading(context: context, message: "Loading..."); */

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
        /*   DialogUtils.showLoading(context: context, message: "Loading..."); */

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
      /*  DialogUtils.showLoading(context: context, message: "Loading..."); */

      //hide Loading
      DialogUtils.hideLoading(
        context,
      );
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

      var user =
          await FireBaseUtils.readUserFromFireStore(credential.user?.uid ?? "");
      var authProvider =
          Provider.of<AuthinticationProvider>(context, listen: false);
      authProvider.updateUser(user);

      /* if (user == null) {
        return;
      } */
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
        /*  DialogUtils.showLoading(context: context, message: "loading..."); */

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
        /* DialogUtils.showLoading(context: context, message: "loading...");
 */
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
