import 'package:cooking_ui_challenge/custom/custom_shape_fab.dart';
import 'package:cooking_ui_challenge/model/food.dart';
import 'package:cooking_ui_challenge/ui/food_attributes.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final int currentIndex;

  DetailPage({this.currentIndex = 0});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    offset = Tween<Offset>(end: Offset.zero, begin: Offset(0.0, 1.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SFUIText'),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            color: Color(0xFFF1F1F3),
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Hero(
                    tag: 'food',
                    child: Image.asset(
                      foodList[widget.currentIndex].foodAssetsPath,
                      fit: BoxFit.scaleDown,
                      width: 300.0,
                      height: 300.0,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Hero(
                  tag: 'title',
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        foodList[widget.currentIndex].foodName,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 34.0,
                          fontFamily: 'QuincyCF',
                          color: Color(0xff131c4f),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Hero(
                        tag: "cooking_time",
                        child: Material(
                          color: Colors.transparent,
                          child: FittedBox(
                            child: FoodAttributes(
                              text: foodList[widget.currentIndex].cookingTime,
                              icon: Icons.timer,
                              color: Color(0xff878995),
                              opacity: 1.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: Hero(
                          tag: "food_type",
                          child: Material(
                            color: Colors.transparent,
                            child: FoodAttributes(
                              text: foodList[widget.currentIndex].foodType,
                              icon: Icons.four_k,
                              color: Color(0xff878995),
                              opacity: 1.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SlideTransition(
                    position: offset,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTabBar(),
                        Expanded(
                          child: _buildTabView(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 40.0),
            child: FloatingActionButton(
              heroTag: "fab",
              shape: CustomShapeFab(),
              backgroundColor: Colors.green,
              onPressed: () {
                controller.reverse();
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTabBar() {
    return TabBar(
        indicatorColor: Color(0xff17c37b),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Color(0xff656b8b),
        unselectedLabelColor: Color(0xffc0c1c7),
        isScrollable: true,
        labelStyle: TextStyle(letterSpacing: 0.5, fontWeight: FontWeight.bold),
        tabs: [
          Tab(
            text: "INGREDIENTS",
          ),
          Tab(
            text: "METHOD",
          )
        ]);
  }

  _buildTabView() {
    return TabBarView(
      children: <Widget>[_buildIngredientPage(), _buildMethodPage()],
    );
  }

  _buildIngredientPage() {
    var ingredientList = foodList[widget.currentIndex].foodIngredient;
    return ListView.builder(
        itemCount: ingredientList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "${index + 1}. ${ingredientList[index]}",
              style: TextStyle(fontSize: 14.0, color: Color(0xff656b8b)),
            ),
          );
        });
  }

  _buildMethodPage() {
    var methodList = foodList[widget.currentIndex].cookingMethod;
    return ListView.builder(
        itemCount: methodList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "${index + 1}. ${methodList[index]}",
              style: TextStyle(fontSize: 14.0, color: Color(0xff656b8b)),
            ),
          );
        });
  }
}
