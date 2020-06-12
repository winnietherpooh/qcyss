import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yss/common/router/router.gr.dart';
import 'package:yss/common/util/screen.dart';
import 'package:yss/model/SignSalaryRequestModel.dart';

class SignPage extends StatefulWidget {
  final SignSalaryRequestModel salaryRequestModel;

  SignPage(this.salaryRequestModel);

  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
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
            child: Signature(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: sySetWidth(70),
              height: sySetWidth(70),
              margin: EdgeInsets.fromLTRB(sySetWidth(30), 0, 0, sySetWidth(30)),
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
                      Signature();
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
                      Signature();
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
          )),

//            Container(
//              child: Image.asset('images/center.png'),
//            )
        ],
      )),
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

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}

class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return new Stack(
      children: [
        GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);

            setState(() {
              _points = new List.from(_points)..add(localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
        CustomPaint(painter: new SignaturePainter(_points))
      ],
    );
  }
}
