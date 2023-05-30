import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:onlineshop_provider/services/auth_service.dart';
import 'package:onlineshop_provider/shared/toastmessage.dart';
import 'package:onlineshop_provider/ui/verificationpage.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../shared/appstyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int start = 59;
  TextEditingController phoneNumber = TextEditingController();
  OtpFieldController otpController = OtpFieldController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  bool loading = false;
  bool isWaiting = false;
  String btnName = 'Send';
  final auth = FirebaseAuth.instance;
  String verificationIdFinal = '';
  String smsCode = '';
  String? phno;

  void startTimer() {
    const onSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onSec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          isWaiting = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff8282),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("Account Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/signin-pic.svg',
              width: width * 0.8,
              height: height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: height * 0.08,
                padding: EdgeInsets.only(left: width * 0.03),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    leadingPadding: 0,
                    trailingSpace: false,
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: phoneNumber,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                  inputDecoration: InputDecoration(
                      hintText: 'Enter your phone number',
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: isWaiting
                            ? null
                            : () async {
                                phno = "+91" + phoneNumber.text.trim();
                                print("Phone num: " + phno!);
                                // setState(() {
                                //   loading = true;
                                // });
                                startTimer();
                                setState(() {
                                  start = 59;
                                  isWaiting = true;
                                  btnName = 'Resend';
                                });
                                await AuthService()
                                    .verifyPhoneNumber(context, phno!, setData);
                              },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15),
                          child: Text(
                            'Send',
                            style: appstyle(
                                15,
                                isWaiting ? Colors.grey : Color(0xFFFF8282),
                                FontWeight.bold),
                          ),
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Center(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      // width: width * 0.375,
                      color: Colors.grey,
                    ),
                  ),
                  Text('\tEnter 6 digit OTP\t'),
                  Expanded(
                    child: Container(
                      height: 1,
                      // width: width * 0.39,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            OTPTextField(
              length: 6,
              controller: otpController,
              width: width * 0.9,
              fieldWidth: width * 0.125,
              style: TextStyle(fontSize: 17),
              fieldStyle: FieldStyle.box,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              onChanged: (value) {
                print("OTP: " + value);
              },
              onCompleted: (value) {
                setState(() {
                  smsCode = value;
                });
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Resend OTP in ',
                  style: appstyle(10, Colors.black, FontWeight.w300)),
              TextSpan(
                  text: "$start ",
                  style: appstyle(10, Color(0XFFFF8282), FontWeight.w300)),
              TextSpan(
                  text: 'seconds',
                  style: appstyle(10, Colors.black, FontWeight.w300)),
            ])),
            SizedBox(height: height * 0.015),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: MaterialButton(
                onPressed: () {
                  AuthService().signInWithPhoneNumber(
                      verificationIdFinal, smsCode, context);
                },
                color: const Color(0xffff8282),
                minWidth: double.infinity,
                height: height * 0.065,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  "Sign in",
                  style: appstyle(18, Colors.white, FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
