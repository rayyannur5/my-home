import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/user.dart';
import 'package:my_home/screens/home.dart';
import 'package:my_home/styles/styles.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';

class EditProfil extends StatelessWidget {
  EditProfil({super.key});
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () => Nav.pop(context)),
        title: Text('Edit Profile', style: AppStyles().headline2_dark),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ListView(
          children: [
            Text('Fill in the fields according to what you want to change', style: AppStyles().subtitle1),
            SizedBox(height: 20),
            Text('Name', style: AppStyles().headline2_regular),
            TextField(controller: name),
            SizedBox(height: 20),
            Text('Email', style: AppStyles().headline2_regular),
            TextField(controller: email),
            SizedBox(height: 20),
            Text('Password', style: AppStyles().headline2_regular),
            TextField(controller: password, obscureText: true),
            SizedBox(height: 40),
            Button(
                onTap: () => checkPasswordDialog(context, name.text, email.text, password.text),
                height: 50,
                borderRadius: 25,
                child: Center(child: Text('Save', style: AppStyles().headline2_dark))),
          ],
        ),
      ),
    );
  }

  checkPasswordDialog(BuildContext context, var name, var email, var password) {
    TextEditingController passwordCheck = TextEditingController();
    return Dialogg.call(context,
        child: Column(
          children: [
            Text('Current Password', style: AppStyles().headline2_regular),
            TextField(controller: passwordCheck, obscureText: true),
            Spacer(),
            Button(
                onTap: () {
                  Dialogg.call(context,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                  User.checkPassword(passwordCheck.text).then((value) {
                    print(value);
                    if (value) {
                      User.update(name, password, email).then((value) {
                        Nav.pop(context);
                        Nav.pop(context);
                        Nav.pop(context);
                        Nav.pop(context);
                        Nav.materialPushReplacement(context, HomePage());
                      });
                    } else {
                      Dialogg.call(context,
                          child: Column(
                            children: [
                              Text('Wrong Password', style: AppStyles().headline2),
                              LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                              Button(
                                  onTap: () {
                                    Nav.pop(context);
                                    Nav.pop(context);
                                  },
                                  child: Center(child: Text('Oke', style: AppStyles().paragraph_dark))),
                            ],
                          ));
                    }
                  });
                },
                child: Center(child: Text('Save', style: AppStyles().paragraph_dark))),
            SizedBox(height: 20)
          ],
        ));
  }
}
