import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:onlineshop_provider/shared/toastmessage.dart';
import 'package:onlineshop_provider/ui/mainscreen.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  const VerifyScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isLoading = false;
  TextEditingController otpController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.1),
        child: Column(
          children: [
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter 6 digit otp',
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otpController.text.toString());
                try {
                  auth.signInWithCredential(credential);
                  final loginStatus = Hive.box("loginstatus");
                  loginStatus.put("status", true);
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const MainScreen()));
                } catch (e) {
                  setState(() {
                    isLoading = false;
                  });
                  ToastMessage.showToast(
                      context, e.toString(), const Color(0xFFFF8282));
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
