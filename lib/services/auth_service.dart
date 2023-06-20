import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';

import '../shared/toastmessage.dart';
import '../ui/mainscreen.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      BuildContext context, String phno, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      ToastMessage.showToast(
          context, 'Number Verification completed', Color(0XFFFF8282));
    };
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      ToastMessage.showToast(context, "Wrong otp", Color(0XFFFF8282));
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) {
      ToastMessage.showToast(context, 'OTP sent', Color(0XFFFF8282));
      setData(verificationId);
    };

    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phno,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (e) {});
    } catch (e) {
      ToastMessage.showToast(context, e.toString(), Color(0XFFFF8282));
    }
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final loginStatus = Hive.box("loginstatus");
      loginStatus.put("status", true);
      Navigator.push(context,
          CupertinoPageRoute(builder: (context) => const MainScreen()));

      ToastMessage.showToast(
          context, 'Logged in successfully', Color(0XFFFF8282));
    } catch (e) {
      ToastMessage.showToast(context, "Wrong otp", Color(0XFFFF8282));
    }
  }
}
