import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lms_flutter/api_call.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
}

class Main extends StatefulWidget {
  final String userData;
  Main(this.userData);

  _MainState createState() => new _MainState();
}

class _MainState extends State<Main> {
  var member_name = "";
  var member_id = "";
  var member_coin = 0;
  var member_level = 0;
  var level_start = "2018/01/01";
  var level_end = "2018/01/01";
  bool attendance = false;
  var attendance_today_check = false;
  var mainContext = null;
  var tabclick = false;
  List<User> users;
  List<DetailUser> detailUser;
  List<String> level_list = new List();
  bool users_check = false;
  bool drawer_check = false;
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();



  @override
  void initState() {
    toDataSet();
  }

  toDataSet() {
    level_list.add("Phonics 1");
    level_list.add("Phonics 2");
    level_list.add("Phonics 3");
    level_list.add("Bronze 1");
    level_list.add("Bronze 2");
    level_list.add("Bronze 3");
    level_list.add("Silver 1");
    level_list.add("Silver 2");
    level_list.add("Silver 3");
    level_list.add("Gold 1");
    level_list.add("Gold 2");
    level_list.add("Gold 3");
    level_list.add("Diamond 1");
    level_list.add("Diamond 2");
    level_list.add("Diamond 3");

    users = json.decode(widget.userData)['data'].map<User>((json) => User.fromJson(json)).toList();

    if (users.length == 1) {
      users_check = false;
    } else if (users.length == 2) {
      users_check = true;
    }

    member_id = users[0].user_id;
    member_name = users[0].child_name;
    print(widget.userData);
//    var result = await Api_Call().fetchDetailUser(http.Client(), json.decode(widget.userData)['data'][0]['child_key']);
//    print(result);
//    detailUser = json.decode(result).map<DetailUser>((json) => DetailUser.fromJson(json)).toList();

    Api_Call().fetchDetailUser(http.Client(), json.decode(widget.userData)['data'][0]['child_key']).then((result){
      setState(() {
        member_coin = json.decode(result)['data']['coin'];
        print(level_list[json.decode(result)['data']['level']]);
        member_level = json.decode(result)['data']['level'] - 1;
      });
    });


//      member_level = level_list[json.decode(result)['data']['level']];
    print(member_level);
  }



//  getData(String wantData) {
//    if (wantData == "id") {
//      return json.decode(widget.userData)['data'][0]['user_id'];
//    } else if (wantData == "email") {
//      return json.decode(widget.userData)['data'][0]['child_name'];
//    }
//  }


  Future<bool> _backdialog() {
    return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                    title: new Text("로그아웃 알림"),
                    content: new Text("로그아웃 하시겠습니까?"),
                    actions: <Widget>[
                      new FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route)=> false);
//
                          },
                          child: new Text("로그아웃")),
                      new FlatButton(
                          onPressed: () {
                            print(Navigator.canPop(context));
                            Navigator.of(context).pop();
                          },
                          child: new Text("취소"))
                    ])) ??
        false;
  }

  Widget drawer_mypage() {
    return GestureDetector(
      onTap: () {
        print("MyPage");
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Color(0xFFe6e6e6)),
          color: Color(0xFFf6f6f6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 5),
                    child: Text(
                      "마이 페이지",
                      style: TextStyle(
                        color: Color(0xFF8a8a8a),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.chevron_right,
                color: Color(0xFF8a8a8a),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer_coin() {
    return GestureDetector(
      onTap: () {
        print("Coin");
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Color(0xFFe6e6e6)),
          color: Color(0xFFf6f6f6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Image.asset(
                'assets/etc/icon_coin.png',
                width: 35,
                height: 35,
              ),
            ),
            Text(
              "${member_coin} Coin",
              style: TextStyle(
                color: Color(0xFF8a8a8a),
                fontSize: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.chevron_right,
                color: Color(0xFF8a8a8a),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawer_level() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.transparent),
        color: Color(0xFFfcca20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            level_list[member_level],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget drawer_attendance_check() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!attendance) {
            attendance = !attendance;
          }
        });
      },
      child: attendance
          ? Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.transparent),
                color: Color(0xFF2aa787),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "출석 체크 완료",
                    style: TextStyle(
                      color: Color(0xFFffffff),
                      fontSize: 20,
                    ),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 35.0,
                  ),
                ],
              ),
            )
          : Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Color(0xFFe6e6e6)),
                color: Color(0xFFffffff),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "출석 체크",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget attendance_check() {
    return attendance
        ? attendance_today_check
            ? Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "이미 출석 체크를 하였습니다.",
                  style: TextStyle(fontSize: 15, color: Color(0xFF000000)),
                ))
            : Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "출석 체크가 완료 되었습니다!",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF2aa787)),
                      ),
                      Text(
                        "+10 Coin",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF2aa787)),
                      )
                    ],
                  ),
                ),
              )
        : Text(
            ".",
            style: TextStyle(fontSize: 0),
          );
  }

  Widget Children_User_Change () {
    return GestureDetector(
      onTap: () {
        print("children_user_change");
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Color(0xFFe6e6e6)),
          color: Color(0xFFf6f6f6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 5),
                    child: Text(
                      "계정 선택",
                      style: TextStyle(
                        color: Color(0xFF8a8a8a),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.chevron_right,
                color: Color(0xFF8a8a8a),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //main 1 body drawer
  Widget drawer() {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: 70.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 1.5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
              ),
              Text(
                member_id,
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0),
                child: Text(
                  member_name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF969696),
                  ),
                ),
              ),
              users_check ?
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Children_User_Change(),
              )
                  : new Container(),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: drawer_mypage(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: drawer_coin(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: drawer_level(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  level_start + " - " + level_end,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: drawer_attendance_check(),
              ),
              attendance_check(),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print("Book Box");
                  },
                  child: Text(
                    "Book Box",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print("Master Box");
                  },
                  child: Text(
                    "Master Box",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print("Mystery Box");
                  },
                  child: Text(
                    "Mystery Box",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print("Game Box");
                  },
                  child: Text(
                    "Game Box",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //main 1 body appBar
  Widget appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xFFFFFFFF),
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/logo/icon_logo.png',
              width: 100, height: 40, fit: BoxFit.contain)
        ],
      ),
      actions: <Widget>[
        Center(
            child: Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: () {
              _backdialog();
            },
            child: Text(
              "로그아웃",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ))
      ],
    );
  }

  Widget book_box() {
    return GestureDetector(
      onTap: () {
        print("Book Box");
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.transparent),
            color: Color(0xFFfb6969),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Book Box",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset('assets/etc/icon_bookbox.png'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Master_Box() {
    return GestureDetector(
        onTap: () {
          print("Master Box");
        },
        child: Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2 - 15,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.transparent),
              color: Color(0xFF2aa787),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Master Box",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Image.asset('assets/etc/icon_masterbox.png'),
                )
              ],
            ),
          ),
        ));
  }

  Widget Mystery_Box() {
    return GestureDetector(
        onTap: () {
          print("Mystery Box");
        },
        child: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2 - 15,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.transparent),
              color: Color(0xFF2aa787),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Mystery Box",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Image.asset('assets/etc/icon_mysterybox.png'),
                )
              ],
            ),
          ),
        ));
  }

  Widget Game_Box() {
    return GestureDetector(
      onTap: () {
        print("Game Box");
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.transparent),
            color: Color(0xFFfcca20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                "Game Box",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset('assets/etc/icon_gamebox.png'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget body_1_child_container() {
    return Container(
        margin: new EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 10.0)),
            Container(
              child: Column(
                children: <Widget>[
                  book_box(),
                  Row(
                    children: <Widget>[
                      Master_Box(),
                      Mystery_Box(),
                    ],
                  ),
                  Game_Box(),
                ],
              ),
            ),
          ],
        ));
  }

  // main 1 body
  Widget body() {
    return WillPopScope(
      onWillPop: () {
//        if (_key.currentState.isDrawerOpen == false) {
//          drawer_check = false;
//        } else {
//          drawer_check = true;
//        }
//        print(321321);
//        print(_key.currentState.isDrawerOpen);
//        print(212121);
//        print(_key.currentState.isEndDrawerOpen);
//        print(515151);
//        print(drawer_check);
//        drawer_check ? Navigator.of(context).pop() : _backdialog();
      _backdialog();
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: appBar(),
        key: _key,
        //드로어 들어가기전 회원 정보 체크 후 생성
        drawer: SizedBox(
          width: double.infinity,
          child: drawer(),
        ),
        body: new Container(
          child: body_1_child_container(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    mainContext = context;

//    print(widget.users);
    return body();
  }
}
