import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'Screens/Signup/signup_screen_2.dart';
import 'constants.dart';
import 'main.dart';

class PrivateInfoSettingPage extends StatefulWidget {
  static const String routeName = '/privateInfoSetting';

  @override
  _PrivateInfoSettingPageState createState() => _PrivateInfoSettingPageState();
}

class _PrivateInfoSettingPageState extends State<PrivateInfoSettingPage> {
  var _userInfo;
  String _token;

  bool isChanged;

  String _nickname;
  String _password1, _password2, _password3;

  List<Gender> genders = new List<Gender>();

  bool _isFemale;

  int _selectedYear;

  List<int> userYears = <int>[
    1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969,
    1970, 1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979,
    1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989,
    1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
    2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isChanged = false;

    _getUserInfo();

    genders.add(new Gender("Male", MdiIcons.genderMale, false));
    genders.add(new Gender("Female", MdiIcons.genderFemale, false));
    genders.add(new Gender("Others", MdiIcons.genderTransgender, false));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('내 정보 수정'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_outlined),
          onTap: () {
            if(isChanged) {
              showAlertDialog(context, 'exit');
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: Icon(Icons.save, color: Color(isDisabled()),),
              onTap: isChanged && _nickname.length > 0 ? () {
                showAlertDialog(context, 'save');
                Fluttertoast.showToast(
                    msg: '저장되었습니다.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                isChanged = false;
                Navigator.pop(context);
              } : null,
            ),
          )
        ],
      ),
      body: _userInfo == null ? Container() : _buildBody(),
    );
  }

  int isDisabled() => isChanged && _nickname.length > 0 ? 0xffffffff : 0x77ffffff;

  void showAlertDialog(BuildContext context, String s) async {
    String _title = '내 정보 수정';
    String _content = s == 'exit' ? '저장하지 않고 나가시겠습니까?' : '저장하시겠습니까?';

    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_content),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                if(s == 'save') {
                  print('저장');
                }
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        child: ClipOval(child: Image.asset('images/girl.jpg', height: 150, width: 150, fit: BoxFit.cover,),),
                      ),
                      Positioned(bottom: 1, right: 1 ,child: Container(
                        height: 40, width: 40,
                        child: Icon(Icons.add_a_photo, color: Colors.white,),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(_nickname, style: TextStyle(fontSize: 20),),
                  SizedBox(height: 5,),
                  Text(_userInfo['email'], style: TextStyle(fontSize: 15),),
                  Container(
                    child: Text('기본정보 변경'),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    initialValue: _nickname,
                    onChanged: (value) {
                      _nickname = value;
                      isChanged = true;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: '닉네임',
                    ),
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),
                  SizedBox(height: 15,),
                  Container(
                      height: 100,
                      width: 600,
                      alignment: Alignment.center,
                      child:
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: genders.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor: kPrimaryColor,
                              onTap: () {
                                setState(() {
                                  if(index == 2) {
                                    Fluttertoast.showToast(
                                        msg: '당신은 사람이 아닙니까?',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  } else {
                                    genders.forEach((gender) => gender.isSelected = false);
                                    genders[index].isSelected = true;
                                    if(index == 0) _isFemale = false;      // 남자면 false
                                    else if(index == 1) _isFemale = true;  // 여자면 true
                                  }
                                });
                              },
                              child: CustomRadio(genders[index]),
                            );
                          }
                      )
                  ),  // gender selector
                  Container(
                      height: 100,
                      width: 600,
                      alignment: Alignment.center,
                      child:
                      DropdownButton<int>(
                        hint:  Text("출생년도를 골라주세요."),
                        value: _selectedYear,
                        onChanged: (int Value) {
                          setState(() {
                            _selectedYear = Value;
                          });
                        },
                        items: userYears.map((int year) {
                          return  DropdownMenuItem<int>(
                            value: year,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  year.toString(),
                                  style:  TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )), // year choice
                  SizedBox(height: 15,),
                  Container(
                    child: Text('비밀번호 변경'),
                    alignment: Alignment.centerLeft,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: '현재 비밀번호',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: '새로운 비밀번호',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: '새로운 비밀번호 체크',
                    ),
                    onSaved: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (String value) {
                      return value.contains('@') ? 'Do not use the @ char.' : null;
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getUserInfo() async {
    _token = _token == null ? await FlutterSecureStorage().read(key: 'token') : _token;
    final response = await http.get('${MyApp.commonUrl}/token/user',
        headers: {
          'Authorization': 'Bearer $_token'
        }
    );

    setState(() {
      _userInfo = json.decode(response.body)['data'];
      print('userInfo : $_userInfo');
      _nickname = _userInfo['nickname'];
      genders[_userInfo['gender'] ? 1 : 0].isSelected = true;
      _selectedYear = _userInfo['age'];
    });
  }
}
