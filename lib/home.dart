import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/addpage.dart';
import 'package:flutter_application_2/listpage.dart';
import 'package:flutter_application_2/login.dart';

class home extends StatefulWidget {
  const home({Key key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final auth = FirebaseAuth.instance;
  PageController pageController = PageController();
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 112, 192),
        title: Text(auth.currentUser.email),
        actions: [
          ElevatedButton(
            onPressed: () {
              auth.signOut().then((value) {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => login(),
                );
                Navigator.pushAndRemoveUntil(context, route, (route) => false);
              });
            },
            child: Container(child: Text("Logout")),
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          listpage(),
          addpage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: 'รายการ'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_outlined), label: 'บันทึก'),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
        backgroundColor: Colors.black,
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
    pageController.jumpToPage(index);
  }
}
