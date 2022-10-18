import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/API/device.dart';
import 'package:my_home/API/user.dart';
import 'package:my_home/screens/add_device.dart';
import 'package:my_home/screens/edit_room.dart';
import 'package:my_home/screens/profile.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/dialog.dart';
import 'package:my_home/widgets/nav.dart';
import 'package:shimmer/shimmer.dart';

import 'package:my_home/API/room.dart';
import 'package:my_home/screens/add_room.dart';
import 'package:my_home/styles/styles.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController deviceName = TextEditingController();
  int MenuActive = 0;
  int menuCount = 0;
  int deviceCount = 0;
  int room_id = 0;
  bool isRoomExist = false;

  _HomePageState() {
    User.get().then((value) {
      print(User.name);
    });
    Device.getAll().then((value) {});
    Room.get().then((value) {
      var data;

      try {
        data = value as List;
        if (data[0] != null) {
          room_id = data[MenuActive]['id'];
          isRoomExist = true;
        }
      } catch (e) {}
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg(),
      body: CustomScrollView(
        slivers: sliverMenu(),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  hoverColor: Colors.black,
                  onTap: () => Nav.pop(context),
                  child: Row(children: [
                    SizedBox(width: 10),
                    Icon(Icons.home),
                    SizedBox(width: 10),
                    Text(
                      'Home',
                      style: AppStyles().headline2_regular,
                    ),
                  ]),
                ),
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
                    Nav.push(context, Profile());
                  },
                  child: Row(children: [
                    SizedBox(width: 10),
                    Icon(Icons.account_circle_outlined, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Profile',
                      style: AppStyles().headline2_regular_dark,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 0,
          tooltip: 'Add Device',
          onPressed: () {
            if (isRoomExist) {
              Nav.push(
                  context,
                  AddDevice(
                    room_id: room_id,
                  ));
            } else {
              Dialogg.call(context,
                  child: Column(
                    children: [
                      Text(
                        'Create Room First',
                        style: AppStyles().headline2,
                      ),
                      LottieBuilder.asset('assets/lottie/warning.json', height: 150),
                      Button(
                          onTap: () => Nav.pop(context),
                          child: Center(
                            child: Text(
                              'Oke',
                              style: AppStyles().paragraph_dark,
                            ),
                          ))
                    ],
                  ));
            }
          },
          child: Icon(Icons.add)),
    );
  }

  List<Widget> sliverMenu() {
    List<Widget> menu = [];
    menu.add(SliverAppBar(
      backgroundColor: Colors.black,
      // toolbarHeight: 110,
      collapsedHeight: 100,
      // automaticallyImplyLeading: false,
      title: Text('Hi, ' + User.name, style: AppStyles().headline1_dark),
      pinned: true,
      expandedHeight: 270,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.fromLTRB(20, 100, 20, 5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://media.tenor.com/5eTljVn-0RoAAAAC/storm-bad-weather.gif'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rainy day", style: AppStyles().headline2_dark),
                      Text('Surabaya, Jawa Timur', style: AppStyles().miniparagraph_dark)
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('32°C', style: AppStyles().headline2_thin_dark),
                      Text('Humidity : 50%', style: AppStyles().miniparagraph_thin_dark),
                    ],
                  ),
                  SizedBox(width: 10),
                  Image.asset('assets/icons/weather/rainy-day.png', scale: 8)
                ],
              ),
            ],
          ),
        ),
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
            height: 100,
            color: AppColor.bg(),
            child: FutureBuilder<dynamic>(
              future: Room.get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  if (data[0] != null) {
                    room_id = data[MenuActive]['id'];
                    isRoomExist = true;
                  }
                  return ListView(scrollDirection: Axis.horizontal, children: CardMenu(data));
                } else {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.black,
                                highlightColor: Colors.white,
                                enabled: true,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(25, 10, 15, 0),
                                    height: 60,
                                    width: 60,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black12)),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.black,
                                highlightColor: Colors.white,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(25, 10, 15, 0),
                                    height: 10,
                                    width: 60,
                                    color: Colors.black12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.black,
                                highlightColor: Colors.white,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                    height: 60,
                                    width: 60,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.black12)),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.black,
                                highlightColor: Colors.white,
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                                    height: 10,
                                    width: 60,
                                    color: Colors.black12),
                              ),
                            ],
                          ),
                        ],
                      ));
                }
              },
            )),
      ),
    ));

    menu.add(SliverToBoxAdapter(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(margin: EdgeInsets.fromLTRB(20, 20, 0, 0), child: Text('Perangkat', style: AppStyles().headline1)),
        IconButton(
            onPressed: () => Nav.materialPushReplacement(context, HomePage()), icon: Icon(Icons.refresh_rounded)),
      ],
    )));

    menu.add(FutureBuilder(
      future: Device.get(room_id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var device = snapshot.data;
          return cardDevice(device);
        }
        return SliverToBoxAdapter(child: LottieBuilder.asset('assets/lottie/search.json'));
      },
    )
        // : SliverToBoxAdapter(child: LottieBuilder.asset('assets/lottie/search.json'))
        );

    return menu;
  }

  CardMenu(var data) {
    List<Widget> menu = [];
    menu.add(SizedBox(width: 10));
    menuCount = data.length;

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

    if (data[0] != null) {
      for (int i = 0; i < menuCount; i++) {
        menu.add(Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  color: MenuActive == i ? Colors.black : AppColor.bg(),
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  MenuActive = i;
                  room_id = data[i]['id'];
                  setState(() {});
                },
                onLongPress: () {
                  Dialogg.call(context, child: showRoom(data[i]));
                },
                child: Icon(icon[data[i]['tipe']], color: MenuActive == i ? AppColor.bg() : Colors.black),
              ),
            ),
            SizedBox(height: 4),
            Text(data[i]['name'], style: AppStyles().miniparagraph)
          ],
        ));
      }
    }
    menu.add(Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              color: AppColor.bg(),
              borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            onTap: () {
              Nav.push(context, AddRoom());
            },
            child: Icon(Icons.add, color: Colors.black),
          ),
        ),
        SizedBox(height: 4),
        Text('Create Room', style: AppStyles().miniparagraph)
      ],
    ));
    return menu;
  }

  showRoom(var data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Text(data['name'], style: AppStyles().headline2),
          subtitle: Text(data['desc'], style: AppStyles().paragraph),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  child: Button(
                      color: Colors.black,
                      onTap: () {
                        Nav.push(context, EditRoom(data: data));
                      },
                      child: Center(child: Text('Edit', style: AppStyles().miniparagraph_dark)))),
              SizedBox(width: 10),
              SizedBox(
                  child: Button(
                      color: Colors.red,
                      onTap: () {
                        Room.delete(data['id']).then((value) {
                          Nav.pop(context);
                          MenuActive = 0;
                          setState(() {});
                        });
                      },
                      child: Center(child: Text('Delete', style: AppStyles().miniparagraph_dark)))),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  cardDevice(var device) {
    List image = [
      Image(image: AssetImage('assets/image/ac off.png')), //0
      Image(image: AssetImage('assets/image/ac on.png')),
      Image(image: AssetImage('assets/image/fan off.png')), //2
      Image(image: AssetImage('assets/image/fan on.png')),
      Image(image: AssetImage('assets/image/garden lamp off.png')), //4
      Image(image: AssetImage('assets/image/garden lamp on.png')),
      Image(image: AssetImage('assets/image/kran off.png')), //6
      Image(image: AssetImage('assets/image/kran on.png')),
      Image(image: AssetImage('assets/image/lamp off.png')), //8
      Image(image: AssetImage('assets/image/lamp on.png')),
      Image(image: AssetImage('assets/image/other off.png')),
      Image(image: AssetImage('assets/image/other on.png')),
    ];

    deviceCount = device.length;
    if (deviceCount == 0 || device[0] == null) {
      return SliverToBoxAdapter(
        child: LottieBuilder.asset('assets/lottie/empty.json'),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
              (context, index) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: device[index]['state'] == 1 ? Colors.black : AppColor.bg(),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Device.updateState(device[index]['state'] == 0 ? 1 : 0, device[index]['id']).then((value) {
                            setState(() {});
                          });
                        },
                        onLongPress: () {
                          Dialogg.call(
                            context,
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              TextField(
                                controller: deviceName,
                                decoration: InputDecoration(
                                  label: Text(
                                    device[index]['name'],
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
                                        Device.updateName(deviceName.text, device[index]['id']).then((value) {
                                          deviceName.clear();
                                          Nav.pop(context);
                                          setState(() {});
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
                                        Device.delete(device[index]['id']).then((value) {
                                          Nav.pop(context);
                                          setState(() {});
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 140,
                              child: device[index]['state'] == 0
                                  ? image[device[index]['tipe']]
                                  : image[device[index]['tipe'] + 1],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(9, 0, 9, 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      device[index]['name'],
                                      style: device[index]['state'] == 1
                                          ? AppStyles().paragraph_bold_dark
                                          : AppStyles().paragraph_bold,
                                    ),
                                  ),
                                  FlutterSwitch(
                                    height: 30,
                                    width: 50,
                                    activeColor: Colors.white,
                                    activeToggleColor: Colors.black,
                                    value: device[index]['state'] == 1 ? true : false,
                                    onToggle: (value) {
                                      Device.updateState(value ? 1 : 0, device[index]['id']).then((value) {
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              childCount: deviceCount),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          )),
    );
  }
}
