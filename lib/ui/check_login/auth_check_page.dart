import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inari_log/app_router.dart';

class AuthCheckPage extends StatefulWidget {
  AuthCheckPage({Key? key, required this.authedPath, required this.unAuthPath})
      : super(key: key);

  final String authedPath;

  final String unAuthPath;

  @override
  _AuthCheckPageState createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  initState() {
    FirebaseAuth.instance.authStateChanges().first.then((currentUser) {
      final nextRoute = (currentUser != null) ? widget.authedPath : widget.unAuthPath;
      AppRouter.router.navigateTo(context, nextRoute);
    }).catchError((err) {
      AppRouter.router.navigateTo(context, "/");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}
