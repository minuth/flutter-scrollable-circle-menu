import 'package:circle_menu/circle_menu.dart';
import 'package:flutter/material.dart';

import 'menu_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final icons = [
    Icons.ac_unit, Icons.face, Icons.dangerous, Icons.verified, Icons.radio, Icons.sanitizer, Icons.cached, Icons.g_translate,
    Icons.ac_unit, Icons.face, Icons.dangerous, Icons.verified, Icons.radio, Icons.sanitizer, Icons.cached, Icons.g_translate
  ];
  final _menuController = MenuController();
  bool _isVisible = false;
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: SafeArea(child: Container(
        child: StreamBuilder<bool>(
          initialData: false,
          stream: _menuController.stream,
          builder: (context, snapshot) {
            return Stack(
                  children: [
                    Center(
                      child: Icon(icons[selectedIndex], size: 100,),
                    ),
                    Align(
                    alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: snapshot.data?350:0,
                    child: CircleMenu(icons: icons,onItemClicked: (menuItem, index) {
                      selectedIndex = index;
                      _changeMenuState();
                    },)
                  ),
                  )],
            );
          }
        ),
      )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _changeMenuState();
      }, child: Icon(Icons.menu)),
    );
  }

  void _changeMenuState(){
    _isVisible = !_isVisible;
    _menuController.changeState(_isVisible);
  }
  @override
  void dispose() {
    _menuController.close();
    super.dispose();
  }
}