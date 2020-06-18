import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yssqc/common/apis/SignSalary.dart';
import 'package:yssqc/common/router/router.gr.dart';
import 'package:yssqc/common/util/screen.dart';
import 'package:yssqc/common/widgets/toast.dart';
import 'package:yssqc/model/SignSalaryRequestModel.dart';
import 'package:path_provider/path_provider.dart';

class PointerList {
  static List<Offset> _points = <Offset>[];
}

class SignPage extends StatefulWidget {
  final SignSalaryRequestModel salaryRequestModel;

  SignPage(this.salaryRequestModel);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  GlobalKey repaintWidgetKey = GlobalKey(); // 绘图key值

  Uint8List images;

//  Future<String> _getBase64() async {
//    RenderRepaintBoundary boundary =
//        repaintWidgetKey.currentContext.findRenderObject();
//    print(boundary.debugNeedsPaint);
//    final image =
//        await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
//    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//    Uint8List pngBytes = byteData.buffer.asUint8List();
//    String bs64 = base64Encode(pngBytes);
//    String bs64Image = "data:image/png;base64," + bs64;
//    // print(bs64Image);
//    return bs64Image;
//  }

//  _getBase64Png() async {
//    RenderRepaintBoundary boundary =
//        repaintWidgetKey.currentContext.findRenderObject();
//    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//    Uint8List pngBytes = byteData.buffer.asUint8List();
//    String bs64 = base64Encode(pngBytes);
//    print(pngBytes);
//    print(bs64);
//  }

  Future<ByteData> _capturePngToByteData() async {
    try {
      RenderRepaintBoundary boundary =
          repaintWidgetKey.currentContext.findRenderObject();
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      ByteData _byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = _byteData.buffer.asUint8List();
      setState(() {
        images = pngBytes;
      });
      return _byteData;
    } catch (e) {
      print(e);
    }
    return null;
  }
  _gotoCofim(){
    _capturePngToByteData().then((data){
        if(PointerList._points.length == 0 || images == null || PointerList._points.length < 3){
          toastInfo(msg: "请先签名");
        }else{
          ExtendedNavigator.rootNavigator.pushSignViewPageRoute(imageData: images,salaryRequestModel:widget.salaryRequestModel);
        }
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
//          margin: EdgeInsets.only(top: sySetHeight(40)),
        child: Stack(
//            alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: RepaintBoundary(
                key: repaintWidgetKey,
                child: Container(
                  child: Signature(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: sySetWidth(70),
                height: sySetWidth(70),
                margin:
                    EdgeInsets.fromLTRB(sySetWidth(30), 0, 0, sySetWidth(30)),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    'images/back.png',
                    fit: BoxFit.fill,
                    width: sySetWidth(70),
                    height: sySetWidth(70),
                  ),
                  onPressed: () {
                    setState(() {
                      ExtendedNavigator.rootNavigator.pop();
                    });
                    ;
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                child: Container(
                  width: sySetWidth(70),
                  height: sySetWidth(70),
                  margin: EdgeInsets.fromLTRB(
                    sySetWidth(30),
                    0,
                    0,
                    sySetWidth(240),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Image.asset(
                      'images/clean.png',
                      fit: BoxFit.fill,
                      width: sySetWidth(70),
                      height: sySetWidth(70),
                    ),
                    onPressed: () {
                      setState(() {
                        //ExtendedNavigator.rootNavigator.pushSignPageRoute(salaryRequestModel: this.widget.salaryRequestModel  );
                        PointerList._points = <Offset>[];
                        images = null;
                      });
                      ;
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: sySetWidth(76),
                height: sySetWidth(180),
                margin: EdgeInsets.fromLTRB(
                  sySetWidth(30),
                  0,
                  0,
                  sySetWidth(30),
                ),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Image.asset(
                    'images/confim.png',
                    fit: BoxFit.fill,
                    width: sySetWidth(76),
                    height: sySetWidth(180),
                  ),
                  onPressed: () {
                    setState(
                      () {
                        //_shareUiImage();
                        _gotoCofim();
                        // _getBase64();
                       // _getBase64Png();
                      },
                    );
                    ;
                  },
                ),
              ),
            ),
            Align(
              child: Container(
                alignment: Alignment.center,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(1.57), // 旋转的角度
                  origin: Offset(0, 0), // 旋转的中心点
                  child: Text(
                    '签名（必填）',
                    style: TextStyle(
                        fontSize: sySetFontSize(38),
                        color: Color.fromRGBO(153, 153, 153, 1)),
                  ),
                ),
              ),
            ),
//            Container(
//              width: 200,
//              height: 200,
//              child: ListView.builder(
//                itemBuilder: (context, index) {
//                  return Image.memory(
//                    images[index],
//                    fit: BoxFit.cover,
//                  );
//                },
//                itemCount: images.length,
//                scrollDirection: Axis.horizontal,
//              ),
//            )
          ],
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  // bool shouldRepaint(SignaturePainter other) => other.points != points;
  bool shouldRepaint(SignaturePainter other) {
    return other.points != points;
  }
}

class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}

class SignatureState extends State<Signature> {
  Widget build(BuildContext context) {
    return new Stack(
      children: [
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);

            setState(() {
              PointerList._points = new List.from(PointerList._points)
                ..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => PointerList._points.add(null),
        ),
        CustomPaint(painter: new SignaturePainter(PointerList._points))
      ],
    );
  }
}
