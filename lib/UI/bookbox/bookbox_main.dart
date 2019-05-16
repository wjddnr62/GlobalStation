import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/book_bloc.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:lms_flutter/model/book.dart';
import 'package:lms_flutter/model/unitData.dart';
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
  final unitData unitdata = new unitData();

  var user_id;
  var user_name;
  var user_level;
  List<String> level_list = new List();
  AppBar appBar_height;
  TabBar tabBar_height;
  List<Book> sb_book = new List();
  List<Book> wb_book = new List();

  bool setBook = false;
  bool getBook = false;

  List<String> levelIcons = [
    'assets/level/phonics_1.png',
    'assets/level/phonics_2.png',
    'assets/level/phonics_3.png',
    'assets/level/bronze_1.png',
    'assets/level/bronze_2.png',
    'assets/level/bronze_3.png',
    'assets/level/silver_1.png',
    'assets/level/silver_2.png',
    'assets/level/silver_3.png',
    'assets/level/gold_1.png',
    'assets/level/gold_2.png',
    'assets/level/gold_3.png',
    'assets/level/diamond_1.png',
    'assets/level/diamond_2.png',
    'assets/level/diamond_3.png',
  ];

  var levelIcon;

  @override
  void initState() {
    super.initState();
    user_id = userInfo.user_id;
    user_name = userInfo.child_name;
    user_level = userInfo.member_level;
    level_list = userInfo.levelList;

    levelIcon = levelIcons[user_level];
    (() async {
      bloc.changeclass_str(level_list[user_level].toLowerCase());
      bloc.getBookList().then((value) {
        List<dynamic> bookList = json.decode(value)['data'];
        print("getBookList : " + bookList.toString());
        setState(() {
          for (int i = 0; i < bookList.length; i++) {
            if (json
                .decode(value)['data'][i]['book_key']
                .toString()
                .contains("SB")) {
              sb_book.add(Book(
                  json.decode(value)['data'][i]['book_key'],
                  json.decode(value)['data'][i]['class_str'],
                  json.decode(value)['data'][i]['unit_name'],
                  json.decode(value)['data'][i]['sub_name'],
                  json.decode(value)['data'][i]['unit_order'],
                  json.decode(value)['data'][i]['amount']));
            } else if (json
                .decode(value)['data'][i]['book_key']
                .toString()
                .contains("WB")) {
              wb_book.add(Book(
                  json.decode(value)['data'][i]['book_key'],
                  json.decode(value)['data'][i]['class_str'],
                  json.decode(value)['data'][i]['unit_name'],
                  json.decode(value)['data'][i]['sub_name'],
                  json.decode(value)['data'][i]['unit_order'],
                  json.decode(value)['data'][i]['amount']));
            }
          }
          sb_book.sort((a, b) {
            return a.unit_order.compareTo(b.unit_order);
          });

          wb_book.sort((a, b) {
            return a.unit_order.compareTo(b.unit_order);
          });
        });
      });
      setState(() {
        getBook = true;
      });

    })();
  }

  void setData(int position) {
    if (setBook) {
      unitdata.unit_level = wb_book[position].unit_order;
      unitdata.unit_name = wb_book[position].unit_name;
      unitdata.unit_sub_name = wb_book[position].sub_name;
      unitdata.book_key = wb_book[position].book_key;
      unitdata.amount = wb_book[position].amount;
    } else {
      unitdata.unit_level = sb_book[position].unit_order;
      unitdata.unit_name = sb_book[position].unit_name;
      unitdata.unit_sub_name = sb_book[position].sub_name;
      unitdata.book_key = sb_book[position].book_key;
      unitdata.amount = sb_book[position].amount;
    }

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
                    Text(
                      "수강가능일자",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "2019/01/01 - 2019/01/01",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (setBook == true) {
                            setBook = false;
                          }
                        });
                      },
                      child: setBook
                          ? Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                  child: Text(
                                "SB",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )),
                            )
                          : Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: greenColor)),
                              child: Center(
                                  child: Text(
                                "SB",
                                style:
                                    TextStyle(color: greenColor, fontSize: 12),
                              )),
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (setBook == false) {
                              setBook = true;
                            }
                          });
                        },
                        child: setBook
                            ? Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(color: greenColor)),
                                child: Center(
                                    child: Text(
                                  "WB",
                                  style: TextStyle(
                                      color: greenColor, fontSize: 12),
                                )),
                              )
                            : Container(
                                width: 50,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                    child: Text(
                                  "WB",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )),
                              ),
                      ),
                    )
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
                              "전체 교재 (8)",
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
                        ListView.builder(
                            itemCount: sb_book.length,
                            itemBuilder: (context, position) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      setData(position);
                                      setBook ? Navigator.of(context).pushNamed("/" + wb_book[position].book_key) : Navigator.of(context).pushNamed("/" + sb_book[position].book_key);
//                                      setBook ? Navigator.of(context).pushReplacementNamed("/" + wb_book[position].book_key) : Navigator.of(context).pushReplacementNamed("/" + sb_book[position].book_key);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            levelIcon,
                                            width: 140,
                                            height: 140,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Container(
                                          width: 1.0,
                                          height: 150.0,
                                          color: lineColor,
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 15.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 50,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          color: yellowColor),
                                                      child: Center(
                                                          child: getBook
                                                              ? Text(
                                                                  sb_book[position]
                                                                          .unit_order
                                                                          .substring(
                                                                              0,
                                                                              1)
                                                                          .toUpperCase() +
                                                                      sb_book[position]
                                                                          .unit_order
                                                                          .substring(
                                                                              1),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : Text("")),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5.0),
                                                      child: Text(
                                                        sb_book[position]
                                                            .unit_name,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        overflow:
                                                            TextOverflow.clip,
                                                      ),
                                                    ),
                                                    setBook ?
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10.0),
                                                      child: Text(
                                                        "진행률 0%",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Color(
                                                                0xFF8A8A8A)),
                                                      ),
                                                    ) : Padding(padding: EdgeInsets.only(top: 10.0),),
                                                    setBook ?
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5.0,
                                                          right: 15.0),
                                                      child:
                                                          LinearProgressIndicator(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          Colors.amber,
                                                        ),
                                                        value: 0.0,
                                                      ),
                                                    ) : Padding(padding: EdgeInsets.only(top: 5.0),),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5.0,
                                                          right: 15.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 20,
                                                        color: yellowColor,
                                                        child: Center(
                                                          child: Text(
                                                            "START",
                                                            style: TextStyle(
                                                                color:
                                                                    WhiteColor,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
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
      elevation: 0.0,
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
//        drawer: SizedBox(
//          width: double.infinity,
//          child: drawer(),
//        ),
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
