import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab2_201087/screens/login.dart';

class AuthService{

  Future<String?> register(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
);
    
    return "Success!";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
    return e.message;
  } catch (e) {
    return e.toString();
  }
}

  Future<String?> login(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, "/home");
    }

    return "Success!";
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found" || e.code == "wrong-password") {
      return 'Invalid login credentials.';
    } else {
      return e.message;
    }
  } catch (e) {
    return e.toString();
  }
}

  Future<String?> getEmail() async {
    String? email = FirebaseAuth.instance.currentUser?.email ?? "Email not found.";
    print(email);
    return email;
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      });
    });
  }
}
