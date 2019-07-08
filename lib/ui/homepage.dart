import 'dart:math';

import 'package:cooking_ui_challenge/model/food.dart';
import 'package:cooking_ui_challenge/ui/food_attributes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _clockWiseRotationAnimation;
  Animation<double> _antiClockWiseRotationAnimation;
  Tween<double> _antiClockWiseRotationTween;
  Tween<double> _clockWiseRotationTween;

  AnimationController _textOpacityController;
  Animation<double> _textOpacityAnimation;

  AnimationController _textColorController;
  Animation<Color> _textColorAnimation;
  int currentIndex = 1;
  bool isClockwise = false;
  bool isBgBlack = false;
  double blackBgHeight = 0.0;
  double rotationValue = 0.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _clockWiseRotationTween = Tween<double>(end: 2 * pi);
    _clockWiseRotationAnimation = _clockWiseRotationTween.animate(
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(1.0)));

    _antiClockWiseRotationTween = Tween<double>(end: -2 * pi);
    _antiClockWiseRotationAnimation = _antiClockWiseRotationTween.animate(
        CurvedAnimation(parent: _controller, curve: ElasticOutCurve(1.0)))
      ..addListener(() {
        setState(() {
          rotationValue = isClockwise
              ? _clockWiseRotationAnimation.value
              : _antiClockWiseRotationAnimation.value;
        });
      });

    _textOpacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _textOpacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_textOpacityController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _changeFood();
              _textOpacityController.reverse();
            }
          });

    _textColorController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _textColorAnimation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_textColorController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textOpacityController.dispose();
    _textColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return Container(
            color: Color(0xFFF1F1F3),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _buildBlackBg(),
                _buildText(),
                _buildPlate(),
                _buildGestureDetection()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlate() {
    return Container(
      child: Transform.translate(
        offset: Offset(80.0, 0.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Transform.rotate(
            angle: rotationValue,
            child: Image.asset(
              foodList[currentIndex].foodAssetsPath,
              width: 180.0,
              height: 250.0,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Positioned(
      top: 60.0,
      left: 32.0,
      right: 80.0,
      bottom: 0.0,
      child: ListView(
        children: <Widget>[
          Text(
            "DAILY COOKING QUEST",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12.0,
          ),
          Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              foodList[currentIndex].foodName,
              style: TextStyle(
                  color: _textColorAnimation.value,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 60.0,
          ),
          FoodAttributes(
            text: foodList[currentIndex].cookingDifficulty,
            icon: Icons.hot_tub,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          FoodAttributes(
            text: foodList[currentIndex].cookingTime,
            icon: Icons.timer,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          FoodAttributes(
            text: foodList[currentIndex].foodEffect,
            icon: Icons.spa,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          FoodAttributes(
            text: foodList[currentIndex].foodType,
            icon: Icons.four_k,
            color: _textColorAnimation.value,
            opacity: _textOpacityAnimation.value,
          ),
          SizedBox(
            height: 50.0,
          ),
          Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              foodList[currentIndex].foodDescription,
              style: TextStyle(
                color: _textColorAnimation.value,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBlackBg() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          color: Color(0xFF384450),
          height: blackBgHeight),
    );
  }

  void _changeFood() {
    setState(() {
      if (!isClockwise) {
        currentIndex =
            currentIndex < foodList.length - 1 ? currentIndex + 1 : 0;
      } else {
        currentIndex =
            currentIndex > 0 ? currentIndex - 1 : foodList.length - 1;
        print(currentIndex);
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {}

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    print(details.delta.dy);
    isClockwise = details.delta.dy < 0;
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    rotationValue = 0.0;
    _antiClockWiseRotationTween.begin = rotationValue;
    _clockWiseRotationTween.begin = rotationValue;

    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
      _textOpacityController.forward(from: 0.0);
      !isBgBlack
          ? _textColorController.forward(from: 0.0)
          : _textColorController.reverse();
      isBgBlack = !isBgBlack;
      setState(() {
        blackBgHeight = isBgBlack ? MediaQuery.of(context).size.height : 0.0;
      });
    }
  }

  Widget _buildGestureDetection() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: MediaQuery.of(context).size.width / 2,
      right: 0.0,
      child: GestureDetector(
        onVerticalDragStart: _onVerticalDragStart,
        onVerticalDragEnd: _onVerticalDragEnd,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}
