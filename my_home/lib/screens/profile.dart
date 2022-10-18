import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/device.dart';
import 'package:my_home/API/room.dart';
import 'package:my_home/screens/devices.dart';
import 'package:my_home/screens/edit_user.dart';
import 'package:my_home/screens/home.dart';
import 'package:my_home/screens/intro.dart';
import 'package:my_home/screens/rooms.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';

import '../API/user.dart';
import '../styles/styles.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 10, bottom: 20),
              height: MediaQuery.of(context).size.height / 5,
              color: Colors.grey.shade800,
              child: ListTile(
                title: Text(User.name, style: AppStyles().headline1_dark),
                subtitle: Text(User.mail, style: AppStyles().paragraph_dark),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 40,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  hoverColor: Colors.black,
                  onTap: () {
                    Nav.pop(context);
                    Nav.pop(context);
                  },
                  child: Row(children: [
                    SizedBox(width: 10),
                    Icon(Icons.home, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Home',
                      style: AppStyles().headline2_regular_dark,
                    ),
                  ]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 40,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  hoverColor: Colors.black,
                  onTap: () => Nav.pop(context),
                  child: Row(children: [
                    SizedBox(width: 10),
                    Icon(Icons.account_circle_outlined),
                    SizedBox(width: 10),
                    Text(
                      'Profile',
                      style: AppStyles().headline2_regular,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 180,
                ),
                Container(width: 1, height: 140, color: Colors.black),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(Room.countRoom.toString() + ' Rooms', style: AppStyles().paragraph_thin),
                    Text(Device.countDevice.toString() + ' Devices', style: AppStyles().paragraph_bold),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(User.name, style: AppStyles().headline1),
                  Text(User.mail, style: AppStyles().subtitle1),
                  SizedBox(height: 30),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.black12),
                    child: InkWell(
                      onTap: () => Nav.push(context, Rooms()),
                      borderRadius: BorderRadius.circular(35),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Rooms', style: AppStyles().headline2_regular),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.black12),
                    child: InkWell(
                      onTap: () => Nav.push(context, Devices()),
                      borderRadius: BorderRadius.circular(35),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Devices', style: AppStyles().headline2_regular),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.black12),
                    child: InkWell(
                      onTap: () => Nav.push(context, EditProfil()),
                      borderRadius: BorderRadius.circular(35),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Edit Profile', style: AppStyles().headline2_regular),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.red.withOpacity(0.3)),
                    child: InkWell(
                      onTap: () {
                        Dialogg.call(context,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Logout?', style: AppStyles().headline2),
                                LottieBuilder.asset('assets/lottie/warning.json', height: 150),
                                Button(
                                    color: Colors.red,
                                    onTap: () {
                                      User.logout().then((value) {
                                        print(value);
                                        Navigator.popUntil(context, (route) => route.isFirst);
                                        Nav.pushReplacement(context, Intro());
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        'Logout',
                                        style: AppStyles().paragraph_dark,
                                      ),
                                    ))
                              ],
                            ));
                      },
                      borderRadius: BorderRadius.circular(35),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Logout', style: AppStyles().headline2_regular),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_outlined),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
