import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/device.dart';
import 'package:my_home/API/room.dart';
import 'package:my_home/screens/edit_room.dart';
import 'package:my_home/styles/styles.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';

class Devices extends StatelessWidget {
  var dataRoom;

  Devices() {
    Room.get().then((value) {
      try {
        dataRoom = value as List;
        print(dataRoom);
      } catch (e) {}
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(onPressed: () => Nav.pop(context), icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Stack(
        children: [
          FutureBuilder<dynamic>(
            future: Device.getAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;

                if (data[0] == null) {
                  return Center(child: LottieBuilder.asset('assets/lottie/empty.json'));
                }
                List<Widget> device = [];
                device.add(SizedBox(height: 100));
                for (var i = 0; i < data.length; i++) {
                  device.add(cardDevice(context, data[i]));
                }
                return ListView(children: device);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('My Devices', style: AppStyles().headline1),
          ),
        ],
      ),
    );
  }

  cardDevice(BuildContext context, var device) {
    TextEditingController deviceName = TextEditingController();
    List icon = [
      Icons.ac_unit_outlined,
      Icons.wind_power_outlined,
      Icons.light,
      Icons.water_drop_outlined,
      Icons.lightbulb_outline_rounded,
      Icons.devices_other_outlined
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.black12),
      child: InkWell(
        onTap: () {
          Dialogg.call(
            context,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextField(
                controller: deviceName,
                decoration: InputDecoration(
                  label: Text(
                    device['name'],
                    style: AppStyles().headline2,
                  ),
                  helperText: 'Edit name',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                      color: Colors.black,
                      onTap: () {
                        Device.updateName(deviceName.text, device['id']).then((value) {
                          deviceName.clear();
                          Nav.pop(context);
                          Nav.materialPushReplacement(context, Devices());
                        });
                      },
                      child: Center(
                        child: Text(
                          'Save',
                          style: AppStyles().miniparagraph_dark,
                        ),
                      )),
                  SizedBox(width: 10),
                  Button(
                      color: Colors.red,
                      onTap: () {
                        Device.delete(device['id']).then((value) {
                          Nav.pop(context);
                        });
                      },
                      child: Center(
                        child: Text(
                          'Delete',
                          style: AppStyles().miniparagraph_dark,
                        ),
                      )),
                ],
              )
            ]),
          );
        },
        borderRadius: BorderRadius.circular(35),
        child: Row(
          children: [
            //       SizedBox(width: 20),
            Expanded(
              child: ListTile(
                minLeadingWidth: 0,
                leading: Icon(icon[device['tipe'] ~/ 2.0], size: 40, color: Colors.black),
                title: Text(device['name'], style: AppStyles().paragraph),
                subtitle: Text(getNameRoom(device['room_id']), style: AppStyles().subtitle2),
              ),
            ),
            //       Spacer(),
            IconButton(
              onPressed: () {
                Dialogg.call(context,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delete?', style: AppStyles().headline2),
                        LottieBuilder.asset('assets/lottie/warning.json', height: 150),
                        Button(
                            color: Colors.red,
                            onTap: () {
                              Device.delete(device['id']).then((value) {
                                Nav.pop(context);
                                Nav.materialPushReplacement(context, Devices());
                              });
                            },
                            child: Center(
                              child: Text(
                                'Delete',
                                style: AppStyles().paragraph_dark,
                              ),
                            ))
                      ],
                    ));
              },
              icon: Icon(Icons.delete_outline_outlined),
            ),
          ],
        ),
      ),
    );
  }

  String getNameRoom(var room_id) {
    for (int i = 0; i < dataRoom.length; i++) {
      if (dataRoom[i]['id'] == room_id) {
        return dataRoom[i]['name'];
      }
    }
    return 'Not Found';
  }
}
