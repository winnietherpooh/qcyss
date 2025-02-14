import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yssqc/common/apis/user.dart';
import 'package:yssqc/common/router/router.gr.dart';

//import 'package:yss/common/router/router.gr.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/global.dart';
import 'package:yssqc/model/userModel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userName = new TextEditingController(text: "80212300");
  var _passWd = new TextEditingController(text: "123456");

  _loginRequest() async {
    showLoading(context,"登录中...");
    UserLoginRequestEntity params = UserLoginRequestEntity(
      userAccount: _userName.value.text,
      passWord: _passWd.value.text,
    );

    UserResponseModel userResponseModel = await UserAPI.login(
      context: context,
      params: params,
    );
    if(userResponseModel.error != 200){
      Navigator.pop(context);
      return showError(context,text: userResponseModel.message,times: 1000);
    }
    UserInfoModel userProfile = userResponseModel.data;
    Global.saveProfile(userProfile);
    ExtendedNavigator.rootNavigator.pushReplacementNamed(Routes.tabsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, sySetHeight(218), 0, 0),
              alignment: Alignment.center,
              child: Image.asset(
                'images/logo.png',
                width: sySetWidth(190),
                height: sySetHeight(190),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  sySetWidth(32), sySetHeight(200), sySetWidth(32), 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide.none,
                        bottom: BorderSide(
                            width: sySetWidth(2),
                            color: Color.fromRGBO(229, 229, 229, 1)))),
                child: TextField(
                  controller: this._userName,
                  decoration: InputDecoration(
                      icon: Image.asset(
                        'images/user.png',
                        width: sySetWidth(32),
                        height: sySetWidth(36),
                        fit: BoxFit.cover,
                      ),
                      hintText: '请输入用户名',
                      labelStyle: TextStyle(
                        fontSize: sySetFontSize(30),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(sySetWidth(32), 0, sySetWidth(32), 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, sySetHeight(50), 0, 0),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide.none,
                        right: BorderSide.none,
                        top: BorderSide.none,
                        bottom: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(229, 229, 229, 1)))),
                child: TextField(
                  controller: this._passWd,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Image.asset(
                        'images/passwd.png',
                        width: sySetWidth(32),
                        height: sySetWidth(36),
                        fit: BoxFit.cover,
                      ),
                      hintText: '请输入密码',
                      labelStyle: TextStyle(
                        fontSize: sySetFontSize(30),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: sySetHeight(100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: sySetHeight(96),
                    padding: EdgeInsets.fromLTRB(
                        sySetWidth(32), 0, sySetWidth(32), 0),
                    //因为有他,所以可以设置宽高
                    child: FlatButton(
                      child: Text(
                        '登录',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sySetFontSize(32),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      color: Color.fromRGBO(246, 159, 0, 1),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/');
                        //ExtendedNavigator.of(context).pushNamed(Routes.tabsRoute);
                        this._loginRequest();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
