import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  VoidCallback  onPressed;
  bool bottomIcons;
  String text;
  IconData icons;

  BottomBar(
      {super.key,
      required this.onPressed,
      required this.bottomIcons,
      required this.icons,
      required this.text});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
        // onTap: widget.onPressed(),
        child: widget.bottomIcons == true
            ? Container(
                decoration: BoxDecoration(
                  color: const Color(0xff38ef7d).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      widget.icons,
                      color: Color(0xff11998e),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.text,
                      style: const TextStyle(
                          color: Color(0xff11998e),
                          fontFamily: 'Montserrat',
                          fontSize: 15),
                    ),
                  ],
                ),
              )
            : Icon(widget.icons));
  }
}
