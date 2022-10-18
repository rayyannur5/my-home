import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/room.dart';
import 'package:my_home/screens/home.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';
import '../styles/styles.dart';

class EditRoom extends StatefulWidget {
  var data;

  EditRoom({super.key, required this.data});

  @override
  State<EditRoom> createState() => _EditRoomState(data: data);
}

class _EditRoomState extends State<EditRoom> {
  var data;
  int tipeActive = 0;
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  _EditRoomState({required this.data}) {
    tipeActive = data['tipe'];
  }

  static const opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg(),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Nav.pop(context),
        ),
        title: Text("Edit Room " + data['name'], style: AppStyles().headline2),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: ListView(
          children: [
            Text('Type', style: AppStyles().headline2_regular),
            SizedBox(height: 10),
            Container(
              height: 100,
              child: Row(
                children: tipe1(),
              ),
            ),
            Container(
              height: 100,
              child: Row(
                children: tipe2(),
              ),
            ),
            SizedBox(height: 20),
            Text('Name', style: AppStyles().headline2_regular),
            TextField(controller: name),
            SizedBox(height: 20),
            Text('Description', style: AppStyles().headline2_regular),
            TextField(controller: desc),
            SizedBox(height: 40),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Button(
                  color: Colors.black,
                  onTap: () {
                    if (name.text == '' || desc.text == '') {
                      return Dialogg.call(context,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Name or Description is required', style: AppStyles().headline2),
                              LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                              Button(
                                  onTap: () => Nav.pop(context),
                                  child: Center(child: Text('Oke', style: AppStyles().paragraph_bold_dark)))
                            ],
                          ));
                    } else {
                      Room.update(name.text, desc.text, tipeActive, data['id']).then((value) {
                        Dialogg.call(context,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Room Updated', style: AppStyles().headline2),
                                LottieBuilder.asset('assets/lottie/success.json', height: 140),
                                Button(
                                    onTap: () {
                                      Nav.pop(context);
                                      Nav.materialPushReplacement(context, HomePage());
                                    },
                                    child: Center(child: Text('Oke', style: AppStyles().paragraph_bold_dark)))
                              ],
                            ));
                      });
                    }
                  },
                  child: Center(child: Text('Save', style: AppStyles().headline2_dark))),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> tipe1() {
    List<Widget> tipe = [];
    List data = ['Living Room', 'Family Room', 'Bed Room', 'Work Space'];
    List icon = [
      Icons.living_outlined,
      Icons.family_restroom_outlined,
      Icons.bed_outlined,
      Icons.workspace_premium_outlined,
    ];
    for (int i = 0; i < 4; i++) {
      tipe.add(Column(children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: tipeActive == i ? Colors.black : AppColor.bg(),
              borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () {
              tipeActive = i;
              setState(() {});
            },
            child: Icon(icon[i], color: tipeActive == i ? AppColor.bg() : Colors.black),
          ),
        ),
        SizedBox(height: 4),
        Text(data[i], style: AppStyles().miniparagraph)
      ]));
    }
    return tipe;
  }

  List<Widget> tipe2() {
    List<Widget> tipe = [];
    List data = ['Kitchen', 'Bath Room', 'Garden', 'Garage'];
    List icon = [Icons.kitchen_outlined, Icons.bathroom_outlined, Icons.park_outlined, Icons.garage_outlined];
    for (int i = 4; i < 8; i++) {
      tipe.add(Column(children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: tipeActive == i ? Colors.black : AppColor.bg(),
              borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () {
              tipeActive = i;
              setState(() {});
            },
            child: Icon(icon[i - 4], color: tipeActive == i ? AppColor.bg() : Colors.black),
          ),
        ),
        SizedBox(height: 4),
        Text(data[i - 4], style: AppStyles().miniparagraph)
      ]));
    }
    return tipe;
  }
}
