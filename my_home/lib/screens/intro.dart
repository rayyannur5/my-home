import 'package:flutter/material.dart';
import 'package:my_home/screens/login.dart';
import 'package:my_home/styles/styles.dart';
import 'package:lottie/lottie.dart';
import 'package:my_home/widgets/Button.dart';
import 'package:my_home/widgets/nav.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  static const opacityCurve = const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  int numPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bg(),
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (value) => setState(() {
                currentIndex = value;
              }),
              children: [
                pageScreen('assets/lottie/wifi-conn.json', "Connect Your Home",
                    "You can access everything around you just from smartphone"),
                pageScreen('assets/lottie/phone.json', "Everything What You Need",
                    "My Home will help you to doing unnecessary task"),
                pageScreen(
                    'assets/lottie/smarthome.json', "Don't Worry", "if you leave the home, I will protect it for you"),
              ],
            ),
            Container(
              padding: EdgeInsets.all(30),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex != numPages - 1
                      ? SizedBox(
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: TextButton(
                                onPressed: () {
                                  pageController.animateToPage(2,
                                      duration: Duration(milliseconds: 300), curve: Curves.ease);
                                },
                                child: Text('Skip', style: AppStyles().paragraph)),
                          ),
                        )
                      : Text(''),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        indicator(currentIndex == 0),
                        indicator(currentIndex == 1),
                        indicator(currentIndex == 2)
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: currentIndex != numPages - 1 ? 70 : 120,
                    // height: 50,

                    child: Hero(
                        tag: 'gotologin',
                        child: Button(
                          color: Colors.black,
                          onTap: () => currentIndex != numPages - 1
                              ? pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease)
                              : Nav.materialPush(context, LoginPage()),
                          child: currentIndex != numPages - 1
                              ? Center(child: Text('Next', style: AppStyles().textButton))
                              :
                              // child:
                              Stack(
                                  children: [
                                    Container(
                                      width: 120,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image(fit: BoxFit.cover, image: AssetImage('assets/bg/black.png')),
                                      ),
                                    ),
                                    Center(child: Text('Login', style: AppStyles().textButton))
                                  ],
                                ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  indicator(bool active) {
    return Container(
      margin: EdgeInsets.all(2),
      width: active ? 14 : 7,
      height: 7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(color: active ? Colors.black : Colors.grey),
      ),
    );
  }

  pageScreen(var lottie, var title, var subtitle) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: size.height / 3,
              width: size.width,
              child: LottieBuilder.asset(
                lottie,
                errorBuilder: (context, error, stackTrace) => Center(child: CircularProgressIndicator()),
              )),
          Text(title, textAlign: TextAlign.center, style: AppStyles().headline1),
          Text(subtitle, textAlign: TextAlign.center, style: AppStyles().paragraph)
        ],
      ),
    );
  }

  Future getLottie(var url) async {
    var data = await url;
    return data;
  }
}
