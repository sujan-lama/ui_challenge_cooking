import 'dart:math';

import 'package:cooking_ui_challenge/custom/custom_shape_fab.dart';
import 'package:cooking_ui_challenge/custom/radial_drag_gesture_detector.dart';
import 'package:cooking_ui_challenge/model/food.dart';
import 'package:cooking_ui_challenge/ui/detail_page.dart';
import 'package:cooking_ui_challenge/ui/food_attributes.dart';
import 'package:flutter/cupertino.dart';
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
  Animation<Color> _textAttributeColorAnimation;
  int currentIndex = 1;
  bool isClockwise = false;
  bool isBgBlack = false;
  double backBgHeight = 0.0;
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
    _textColorAnimation =
        ColorTween(begin: Color(0xff131c4f), end: Colors.white)
            .animate(_textColorController);
    _textAttributeColorAnimation =
        ColorTween(begin: Color(0xff878995), end: Color(0xffd4d5d7))
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
                _buildWhiteBg(),
                _buildBlackBg(),
                _buildText(),
                _buildPlate(),
                _buildGestureDetection()
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          heroTag: "fab",
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) {
                return DetailPage(
                  currentIndex: currentIndex,
                );
              },
              transitionsBuilder: (context, animation1, animation2, child) {
                return FadeTransition(
                  opacity: animation1,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 800),
            ));
          },
          shape: CustomShapeFab(),
          backgroundColor: Colors.green,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPlate() {
    return Container(
      child: Align(
        alignment: Alignment(4, 0),
        child: RadialDragGestureDetector(
          onRadialDragStart: _onRadialDragStart,
          onRadialDragUpdate: _onRadialDragUpdate,
          onRadialDragEnd: _onRadialDragEnd,
          child: Transform.rotate(
            angle: rotationValue,
            child: Hero(
              tag: 'food',
              flightShuttleBuilder: _heroBuilder,
              child: Image.asset(
                foodList[currentIndex].foodAssetsPath,
                width: 300.0,
                height: 300.0,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Positioned(
      top: 111.0,
      left: 32.0,
      right: 90.0,
      bottom: 0.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "DAILY COOKING QUEST",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 6.0,
            ),
            Opacity(
              opacity: _textOpacityAnimation.value,
              child: Hero(
                tag: 'title',
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      foodList[currentIndex].foodName,
                      style: TextStyle(
                          color: _textColorAnimation.value,
                          fontSize: 34.0,
                          fontFamily: 'QuincyCF',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            FoodAttributes(
              text: foodList[currentIndex].cookingDifficulty,
              icon: Icons.hot_tub,
              color: _textAttributeColorAnimation.value,
              opacity: _textOpacityAnimation.value,
            ),
            Hero(
              tag: 'cooking_time',
              child: Material(
                color: Colors.transparent,
                child: FoodAttributes(
                  text: foodList[currentIndex].cookingTime,
                  icon: Icons.timer,
                  color: _textAttributeColorAnimation.value,
                  opacity: _textOpacityAnimation.value,
                ),
              ),
            ),
            FoodAttributes(
              text: foodList[currentIndex].foodEffect,
              icon: Icons.spa,
              color: _textAttributeColorAnimation.value,
              opacity: _textOpacityAnimation.value,
            ),
            Hero(
              tag: 'food_type',
              child: Material(
                color: Colors.transparent,
                child: FoodAttributes(
                  text: foodList[currentIndex].foodType,
                  icon: Icons.four_k,
                  color: _textAttributeColorAnimation.value,
                  opacity: _textOpacityAnimation.value,
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Opacity(
              opacity: _textOpacityAnimation.value,
              child: Text(
                foodList[currentIndex].foodDescription,
                style: TextStyle(
                  color: _textAttributeColorAnimation.value,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        ),
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
        height: backBgHeight,
        child: Image.asset(
          'assets/Base_black.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildWhiteBg() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        child: Image.asset(
          'assets/Base.png',
          fit: BoxFit.fill,
        ),
      ),
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
        backBgHeight = isBgBlack ? MediaQuery.of(context).size.height : 0.0;
      });
    }
  }

  _onRadialDragStart(PolarCoord startCoord) {}

  _onRadialDragUpdate(PolarCoord updateCoord) {
    setState(() {
      rotationValue = updateCoord.angle;
    });
    if (updateCoord.angle > 0) {
      //anti clock wise
      isClockwise = false;
    } else {
      //clockwise
      isClockwise = true;
    }
  }

  _onRadialDragEnd() {
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
        backBgHeight = isBgBlack ? MediaQuery.of(context).size.height : 0.0;
      });
    }
  }

  Widget _buildGestureDetection() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 80.0,
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

  Widget _heroBuilder(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext) {
    final Hero toHero = toHeroContext.widget;

    return RotationTransition(
      turns: animation,
      child: toHero.child,
    );
  }
}
