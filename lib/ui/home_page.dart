import 'dart:math';

import 'package:cooking_ui_challenge/model/food.dart';
import 'package:cooking_ui_challenge/ui/clipper/custom_shape_fab.dart';
import 'package:cooking_ui_challenge/ui/detail_page.dart';
import 'package:cooking_ui_challenge/ui/food_attributes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  AnimationController _controller;
  Animation<double> _clockWisePlateRotationAnimation;
  Animation<double> _antiClockWisePlateRotationAnimation;
  AnimationController _textController;
  Animation<double> _textOpacityAnimation;

  AnimationController _textBackgroundController;
  bool isBgBlack = false;
  Animation<Color> textColorAnimation;
  bool isClockWise = false;
  int currentIndex = 0;
  double myHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _clockWisePlateRotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi)
        .animate(
            CurvedAnimation(parent: _controller, curve: ElasticOutCurve(1.0)));
    _antiClockWisePlateRotationAnimation =
        Tween<double>(begin: 0.0, end: -2 * pi).animate(
            CurvedAnimation(parent: _controller, curve: ElasticOutCurve(1.0)));

    _textController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _textOpacityAnimation = Tween(begin: 1.0, end: 0.0).animate(_textController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _changeFood();
          _textController.reverse();
        }
      });

    _textBackgroundController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    textColorAnimation = ColorTween(begin: Colors.black87, end: Colors.white)
        .animate(_textBackgroundController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    _textBackgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildBlackBackground(),
              _buildWhiteBackground(),
              _buildPlate(),
              _buildText(),
            ],
          );
        },
      ),
      floatingActionButton: _buildFab(),
    );
  }

  void _onVerticalDragStart(DragStartDetails details) {}

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      // clockwise
      isClockWise = true;
    } else {
      //anti clockwise
      isClockWise = false;
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (!_controller.isAnimating) _controller.forward(from: 0.0);
    if (!_textController.isAnimating) _textController.forward(from: 0.0);
    _changeBackground();
  }

  _changeFood() {
    if (!isClockWise) {
      setState(() {
        currentIndex =
            currentIndex < foodList.length - 1 ? currentIndex + 1 : 0;
      });
    } else {
      setState(() {
        currentIndex =
            currentIndex > 0 ? currentIndex - 1 : foodList.length - 1;
      });
    }
  }

  Widget _buildPlate() {
    return Center(
      child: Transform.translate(
        offset: Offset(80.0, 0.0),
        child: Align(
          alignment: Alignment(1.0,-0.2),
          child: Container(
            child: GestureDetector(
              onVerticalDragStart: _onVerticalDragStart,
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              child: Transform.rotate(
                angle: isClockWise
                    ? _clockWisePlateRotationAnimation.value
                    : _antiClockWisePlateRotationAnimation.value,
                child: Hero(
                  tag: 'food',
                  flightShuttleBuilder: _heroBuilder,
                  child: Material(
                    color: Colors.transparent,
                    child: Image.asset(
                      foodList[currentIndex].foodAssetsPath,
                      width: 180.0,
                      height: 250.0,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstFood() {
    return Image.asset(
      foodList[0].foodAssetsPath,
      width: 180.0,
      height: 250.0,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _secondFood() {
    return Image.asset(
      foodList[1].foodAssetsPath,
      width: 180.0,
      height: 250.0,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _buildText() {
    return Positioned(
      top: 80.0,
      left: 30.0,
      right: 110.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'DAILY COOKING QUEST',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: Colors.grey),
            ),
            Hero(
              tag: 'title',
              child: Container(
                margin: EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      foodList[currentIndex].foodName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                        color: textColorAnimation.value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FoodAttributes(
                    text: foodList[currentIndex].cookingDifficulty,
                    icon: Icons.hot_tub,
                    color: textColorAnimation.value,
                    opacity: _textOpacityAnimation,
                  ),
                  Hero(
                    tag: "cooking_time",
                    child: Material(
                      color: Colors.transparent,
                      child: FoodAttributes(
                        text: foodList[currentIndex].cookingTime,
                        icon: Icons.timer,
                        color: textColorAnimation.value,
                        opacity: _textOpacityAnimation,
                      ),
                    ),
                  ),
                  FoodAttributes(
                    text: foodList[currentIndex].foodEffect,
                    icon: Icons.ac_unit,
                    color: textColorAnimation.value,
                    opacity: _textOpacityAnimation,
                  ),
                  Hero(
                    tag: "food_type",
                    child: Material(
                      color: Colors.transparent,
                      child: FoodAttributes(
                        text: foodList[currentIndex].foodType,
                        icon: Icons.high_quality,
                        color: textColorAnimation.value,
                        opacity: _textOpacityAnimation,
                      ),
                    ),
                  )
                ],
              ),
            ),
            FadeTransition(
              opacity: _textOpacityAnimation,
              child: Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Text(
                  foodList[currentIndex].foodDescription,
                  style: TextStyle(
                      color: textColorAnimation.value,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBlackBackground() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        color: Color(0xFFF1F1F3),
      ),
    );
  }

  _buildWhiteBackground() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        color: Color(0xFF384450),
        width: MediaQuery.of(context).size.width,
        height: myHeight,
      ),
    );
  }

  void _changeBackground() {
    isBgBlack = !isBgBlack;

    myHeight = isBgBlack ? MediaQuery.of(context).size.height : 0.0;
    isBgBlack
        ? _textBackgroundController.forward(from: 0.0)
        : _textBackgroundController.reverse();
    setState(() {});
  }

  Widget _buildFab() {
    return Container(
      margin: EdgeInsets.only(bottom: 80.0),
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        heroTag: "fab",
        shape: CustomShapeFab(),
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
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
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
