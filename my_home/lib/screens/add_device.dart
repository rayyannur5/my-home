import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/device.dart';
import 'package:my_home/screens/home.dart';

import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';
import '../styles/styles.dart';

class AddDevice extends StatefulWidget {
  int room_id;
  AddDevice({super.key, required this.room_id});

  @override
  State<AddDevice> createState() => _AddDeviceState(room_id);
}

class _AddDeviceState extends State<AddDevice> {
  int room_id;
  _AddDeviceState(this.room_id);
  int tipeActive = 0;
  TextEditingController name = TextEditingController();

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
        title: Text("Add Device", style: AppStyles().headline2),
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
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Button(
                  color: Colors.black,
                  onTap: () {
                    if (name.text == '') {
                      return Dialogg.call(context,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Name is required', style: AppStyles().headline2),
                              LottieBuilder.asset('assets/lottie/warning.json', height: 140),
                              Button(
                                  onTap: () => Nav.pop(context),
                                  child: Center(child: Text('Oke', style: AppStyles().paragraph_bold_dark)))
                            ],
                          ));
                    } else {
                      Dialogg.call(context,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                      Device.create(room_id, name.text, tipeActive).then((value) {
                        Nav.pop(context);
                        Dialogg.call(context,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Device Has Been Saved', style: AppStyles().headline2),
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
    List data = ['AC', 'Fan', 'Garden Lamp', 'Water'];
    List icon = [
      Icons.ac_unit_outlined,
      Icons.wind_power_outlined,
      Icons.light,
      Icons.water_drop_outlined,
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
    List data = ['Lamp', 'Other Device'];
    List icon = [Icons.lightbulb_outline_rounded, Icons.devices_other_outlined];
    for (int i = 4; i < 6; i++) {
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
