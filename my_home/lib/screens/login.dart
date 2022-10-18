import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/user.dart';
import 'package:my_home/screens/home.dart';
import 'package:my_home/screens/register.dart';
import 'package:my_home/styles/styles.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = false;
  bool checkbox = false;
  String message = 'null';

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  _LoginPageState() {
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
                height: size.height / 1.8,
                width: size.width / 1.1,
                decoration: BoxDecoration(color: AppColor.bg(), borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login', style: AppStyles().headline1),
                    Text('Make your life easy, forgot unnecessary task', style: AppStyles().subtitle1),
                    SizedBox(height: 10),
                    message == 'Unauthorised'
                        ? Container(
                            height: 40,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red),
                            child:
                                Center(child: Text("Email or password wrong!", style: AppStyles().miniparagraph_dark)),
                          )
                        : SizedBox(),
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
                          icon: Icon(Icons.email),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: checkbox,
                              shape: CircleBorder(),
                              onChanged: (value) {
                                setState(() {
                                  checkbox = value!;
                                });
                              },
                            ),
                            Text('Remember me', style: AppStyles().miniparagraph),
                          ],
                        ),
                        TextButton(onPressed: () {}, child: Text('Forgot Password?', style: AppStyles().miniparagraph))
                      ],
                    ),
                    SizedBox(height: 5),
                    Button(
                        color: Colors.black,
                        width: 300,
                        onTap: () {
                          User.login(email.text, password.text).then((value) {
                            print(value);
                            message = value['message'];
                            setState(() {});

                            if (message == 'success') {
                              Nav.push(context, HomePage());
                            } else if (message == 'no internet') {
                              Dialogg.call(context, child: LottieBuilder.asset('assets/lottie/no-internet.json'));
                            }
                          });
                        },
                        child: Center(child: Text('Login', style: AppStyles().textButton))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('DON\'T HAVE AN ACCOUNT?'),
                        TextButton(
                            onPressed: () => Nav.materialPushReplacement(context, Register()), child: Text('REGISTER'))
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
