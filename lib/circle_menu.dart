import 'package:circle_menu/circle_menu_painter.dart';
import 'package:flutter/material.dart';

import 'menu_item.dart';

class CircleMenu extends StatefulWidget {
  final Function(MenuItem item, int index) onItemClicked;
  final List<IconData> icons;
  CircleMenu({@required this.icons,this.onItemClicked});
  @override
  _CoundownState createState() => _CoundownState();
}

class _CoundownState extends State<CircleMenu> {
  var _currentPoint = 0.0;
  var _dragDistance = 0.0;
  var _lastDistance = 0.0;
  var _startPoint = 0.0;
  var _menuSelectedPoint = Offset.zero;
  var _isMoving = false;


  @override
  Widget build(BuildContext context) {
    final menuItems = List.generate(widget.icons.length, (index) => MenuItem(widget.icons[index], "icon$index"));
    return GestureDetector(
        child: Container(
          child: CustomPaint(
            size: Size.infinite,
            painter: CircleMenuPainter(currentPoint: _currentPoint, shouldDraw: _isMoving, icons: menuItems, selectedMenuPoint: _menuSelectedPoint, onItemClicked: (menuItem, index) {
              if(widget.onItemClicked != null){
                widget.onItemClicked(menuItem, index);
              }
            },onDrawFinished: () {
              _menuSelectedPoint = null;
            },),
          ),
        ),
        onTapDown: (details) {
          setState(() {
            _isMoving = true;
            _menuSelectedPoint = details.localPosition;
          });
        },
        onVerticalDragStart: (details) {
           _isMoving = true;
          _startPoint = details.localPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          setState(() {
              _dragDistance = details.localPosition.dy - _startPoint;
              _currentPoint = _dragDistance + _lastDistance;
          });
         
        },
        onVerticalDragEnd: (details) {
          setState(() {
            _lastDistance += _dragDistance;
           _isMoving = false;
          });
        },
        
    );
  }
}