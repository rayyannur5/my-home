import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/user.dart';
import 'package:my_home/screens/home.dart';
import 'package:my_home/screens/login.dart';
import 'package:my_home/screens/register.dart';
import 'package:my_home/styles/styles.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _visible = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  _RegisterState() {
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        _visible = true;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Hero(
            tag: 'gotologin',
            child: Container(
              padding: EdgeInsets.all(50),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(200)),
              height: size.height,
              width: size.width,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 35, 0, 0),
            child: Button(
                color: Colors.transparent,
                width: 40,
                onTap: () {
                  _visible = false;
                  setState(() {});
                  Future.delayed(Duration(milliseconds: 500), () {});
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new, color: Colors.white)),
          ),
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(30),
                height: size.height / 1.6,
                width: size.width / 1.1,
                decoration: BoxDecoration(color: AppColor.bg(), borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Register', style: AppStyles().headline1),
                    Text('Make your life easy, forgot unnecessary task', style: AppStyles().subtitle1),
                    SizedBox(height: 20),
                    TextField(
                        controller: name,
                        decoration: InputDecoration(
                          label: Text('Username', style: AppStyles().paragraph),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(20)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.black12,
                          icon: Icon(Icons.account_circle),
                          filled: true,
                        )),
                    SizedBox(height: 10),
                    TextField(
                        controller: email,
                        decoration: InputDecoration(
                          label: Text('Email', style: AppStyles().paragraph),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(20)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.black12,
                          icon: Icon(Icons.email_outlined),
                          filled: true,
                        )),
                    SizedBox(height: 10),
                    TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Password', style: AppStyles().paragraph),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none), borderRadius: BorderRadius.circular(20)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.black12,
                          icon: Icon(Icons.lock_rounded),
                          filled: true,
                        )),
                    SizedBox(height: 30),
                    Button(
                        color: Colors.black,
                        width: 300,
                        onTap: () {
                          if (name.text == '' || password.text == '' || email.text == '') {
                            Dialogg.call(context,
                                child: Column(
                                  children: [
                                    Text('Username, Email, and Password required',
                                        textAlign: TextAlign.center, style: AppStyles().headline2),
                                    LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                                    Button(
                                        onTap: () => Nav.pop(context),
                                        child: Center(child: Text('Oke', style: AppStyles().paragraph_dark)))
                                  ],
                                ));
                          } else if (name.text.length < 4) {
                            Dialogg.call(context,
                                child: Column(
                                  children: [
                                    Text('Minimum name character is 4',
                                        textAlign: TextAlign.center, style: AppStyles().headline2),
                                    LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                                    Button(
                                        onTap: () => Nav.pop(context),
                                        child: Center(child: Text('Oke', style: AppStyles().paragraph_dark)))
                                  ],
                                ));
                          } else if (!(email.text.contains('@') && email.text.contains('.com'))) {
                            Dialogg.call(context,
                                child: Column(
                                  children: [
                                    Text('Enter the correct email',
                                        textAlign: TextAlign.center, style: AppStyles().headline2),
                                    LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                                    Button(
                                        onTap: () => Nav.pop(context),
                                        child: Center(child: Text('Oke', style: AppStyles().paragraph_dark)))
                                  ],
                                ));
                          } else if (password.text.length < 8) {
                            Dialogg.call(context,
                                child: Column(
                                  children: [
                                    Text('Minimum character password is 8',
                                        textAlign: TextAlign.center, style: AppStyles().headline2),
                                    LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                                    Button(
                                        onTap: () => Nav.pop(context),
                                        child: Center(child: Text('Oke', style: AppStyles().paragraph_dark)))
                                  ],
                                ));
                          } else {
                            Dialogg.call(context,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ));
                            User.register(name.text, email.text, password.text).then((value) {
                              Nav.pop(context);
                              Dialogg.call(context,
                                  child: Column(
                                    children: [
                                      Text('Account has been Created',
                                          textAlign: TextAlign.center, style: AppStyles().headline2),
                                      LottieBuilder.asset('assets/lottie/success.json', height: 140),
                                      Button(
                                          onTap: () {
                                            Nav.pop(context);
                                            Nav.pop(context);
                                            Nav.materialPushReplacement(context, HomePage());
                                          },
                                          child: Center(child: Text('Oke', style: AppStyles().paragraph_dark)))
                                    ],
                                  ));
                            });
                          }
                        },
                        child: Center(child: Text('Register', style: AppStyles().textButton))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('HAVE AN ACCOUNT?'),
                        TextButton(
                            onPressed: () => Nav.materialPushReplacement(context, LoginPage()), child: Text('LOGIN'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
