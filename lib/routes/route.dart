import 'package:yss/tabs//Taps.dart';
import 'package:yss/pages/login.dart';
///////////////////////////////////////
import 'package:yss/test/test.dart';
import 'package:yss/test/test2.dart';
///////////////////////////////////////
import 'package:yss/pages/SetList.dart';
import 'package:yss/pages/setPasswd.dart';
final route = {
  '/': (context) => Taps(),
  '/login': (context) => LoginPage(),
  '/setlist': (context) => SetList(),
  '/setpasswd': (context) => SetPassWdPage(),
  '/test': (context) => TestPage(),
  '/test2': (context) => Test2Page(),
};
