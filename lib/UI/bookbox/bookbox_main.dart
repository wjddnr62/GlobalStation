import 'package:flutter/material.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:lms_flutter/theme.dart';

class BookBox extends StatefulWidget {
  _BookBoxState createState() => new _BookBoxState();
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Container(
          decoration: decoration,
        )),
        tabBar,
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => tabBar.preferredSize;
}

class _BookBoxState extends State<BookBox> {
  final UserInfo userInfo = new UserInfo();

  var user_id;
  var user_name;
  var user_level;
  List<String> level_list = new List();
  AppBar appBar_height;
  TabBar tabBar_height;

  @override
  void initState() {
    user_id = userInfo.user_id;
    user_name = userInfo.child_name;
    user_level = userInfo.member_level;
    level_list = userInfo.levelList;
    print("check_user : " +
        userInfo.user_id +
        ", " +
        userInfo.child_user_id +
        ", " +
        userInfo.child_name +
        ", " +
        userInfo.member_level.toString());
    print(userInfo.levelList);
  }

  Widget header() {
    return Container(
      width: double.infinity,
      height: (MediaQuery.of(context).size.height / 4.5) -
          appBar_height.preferredSize.height,
      color: bookboxmainColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 15.0),
            child: Text(
              level_list[user_level],
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 5.0),
                child: ClipOval(
                  child: Container(
                    color: greenColor,
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Text(
                        "30일",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("수강가능일자", style: TextStyle(color: Colors.white),),
                    Text("2019/01/01 - 2019/01/01", style: TextStyle(color: Colors.white),),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget tabBar() {
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: DecoratedTabBar(
                      tabBar: tabBar_height = TabBar(
                        indicatorColor: bookboxmainColor,
                        tabs: [
                          Tab(
                            child: Text(
                              "전체 교재 (0)",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "수강중인 교재 (0)",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "수강완료 교재 (0)",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: lineColor))),
                ),
              ],
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      (((MediaQuery.of(context).size.height / 4.5) -
                              appBar_height.preferredSize.height) +
                          appBar_height.preferredSize.height +
                          tabBar_height.preferredSize.height)) -
                  MediaQuery.of(context).padding.top,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Text("test"),
                        Text("test"),
                        Text("test"),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget tabBarview() {
    return TabBarView(children: [
      Container(
        child: Text("test"),
      )
    ]);
  }

  Widget appBar() {
    return appBar_height = AppBar(
      backgroundColor: bookboxmainColor,
      iconTheme: IconThemeData(color: Colors.white),
      title: Row(
        children: <Widget>[
          Text(
            "Book Box",
            style:
                TextStyle(fontSize: defaultFontSize + 4, color: Colors.white),
          )
        ],
      ),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Container(
                width: 80.0,
                height: 30.0,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    "레벨선택",
                    style: TextStyle(
                        fontSize: defaultFontSize, color: Colors.white),
                  ),
                )),
          ),
        )
      ],
    );
  }

  Widget mainBody() {
    return Container(
      child: Scaffold(
        backgroundColor: backgroudDefaultColor,
        appBar: appBar(),
        drawer: SizedBox(
          width: double.infinity,
//          child: drawer(),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              header(),
              tabBar(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return mainBody();
  }
}
