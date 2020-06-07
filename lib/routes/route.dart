import 'package:yss/tabs//Taps.dart';
import 'package:yss/pages/login.dart';
///////////////////////////////////////
import 'package:yss/test/test.dart';
import 'package:yss/test/test2.dart';
///////////////////////////////////////
import 'package:yss/pages/SetList.dart';
final route = {
  '/': (context) => Taps(),
  '/login': (context) => LoginPage(),
  '/setlist': (context) => SetList(),
  '/test': (context) => TestPage(),
  '/test2': (context) => Test2Page(),
};
