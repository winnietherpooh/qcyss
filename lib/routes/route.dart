import 'package:yss/tabs//Taps.dart';
import 'package:yss/pages/login.dart';
///////////////////////////////////////
import 'package:yss/test/test.dart';
import 'package:yss/test/test2.dart';
///////////////////////////////////////
final route = {
  '/': (context) => Taps(),
  '/login': (context) => LoginPage(),
  '/test': (context) => TestPage(),
  '/test2': (context) => Test2Page(),
};
