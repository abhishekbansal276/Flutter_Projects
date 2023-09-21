import 'package:dynamic_future_tech/screens/ChatScreen.dart';
import 'package:dynamic_future_tech/screens/CoursesScreen.dart';
import 'package:dynamic_future_tech/screens/HomePage.dart';
import 'package:dynamic_future_tech/screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  var currentIndex = 0;

  final List<Widget>  screens = [
    HomePage(),
    CoursesScreen(),
    ChatScreen(),
    ProfileScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var index = 0; index < 4; index++)
                InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      currentScreen = screens[index];
                    });
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    // margin: EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10), // Add padding to create background
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == currentIndex
                          ? const Color(0xff6dd5ed).withOpacity(0.2)
                          : Colors.transparent, // Set background color for selected icon
                    ),
                    child: Icon(
                      listOfIcons[index],
                      size: 30,
                      color: index == currentIndex
                          ? const Color(0xff2193b0) // Set icon color for selected icon
                          : Colors.black38,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.book_rounded,
    Icons.chat_rounded,
    Icons.person_rounded,
  ];
}
