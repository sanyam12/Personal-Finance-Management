import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/entities/credentials.dart';

class LoginService {
  final auth = FirebaseAuth.instance;

  Future<String> login(CredentialsEntity credentialsEntity) async {
    try {
      if (credentialsEntity.password == null ||
          credentialsEntity.mail == null) {
        throw Exception("Mail or Password is empty");
      } else {
        await auth.signInWithEmailAndPassword(
            email: credentialsEntity.mail!,
            password: credentialsEntity.password!);
        return "";
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String> signup(CredentialsEntity credentialsEntity) async {
    try {
      if (credentialsEntity.password == null ||
          credentialsEntity.mail == null) {
        throw Exception("Mail or Password is empty");
      } else {
        await auth.createUserWithEmailAndPassword(
            email: credentialsEntity.mail!,
            password: credentialsEntity.password!);
        return "";
      }
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return e.code;
    }
  }
}
