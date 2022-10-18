import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/room.dart';
import 'package:my_home/screens/edit_room.dart';
import 'package:my_home/styles/styles.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';

class Rooms extends StatelessWidget {
  const Rooms({super.key});

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
            future: Room.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data;
                if (data[0] == null) {
                  return Center(child: LottieBuilder.asset('assets/lottie/empty.json'));
                }
                List<Widget> room = [];
                room.add(SizedBox(height: 100));
                for (var i = 0; i < data.length; i++) {
                  room.add(cardRoom(context, data[i]));
                }
                return ListView(children: room);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text('My Rooms', style: AppStyles().headline1),
          ),
        ],
      ),
    );
  }

  cardRoom(BuildContext context, var room) {
    List icon = [
      Icons.living_outlined,
      Icons.family_restroom_outlined,
      Icons.bed_outlined,
      Icons.workspace_premium_outlined,
      Icons.kitchen_outlined,
      Icons.bathroom_outlined,
      Icons.park_outlined,
      Icons.garage_outlined
    ];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(35), color: Colors.black12),
      child: InkWell(
        onTap: () => Nav.push(context, EditRoom(data: room)),
        borderRadius: BorderRadius.circular(35),
        child: Row(
          children: [
            //       SizedBox(width: 20),
            Expanded(
              child: ListTile(
                minLeadingWidth: 0,
                leading: Icon(icon[room['tipe']], size: 40, color: Colors.black),
                title: Text(room['name'], style: AppStyles().paragraph),
                subtitle: Text(room['desc'], style: AppStyles().subtitle2),
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
                              Room.delete(room['id']).then((value) {
                                Nav.pop(context);
                                Nav.materialPushReplacement(context, Rooms());
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
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
