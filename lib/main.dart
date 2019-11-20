import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixy_clock/ui/config.dart';
import 'package:pixy_clock/ui/pixy_bg.dart';
import 'package:pixy_clock/ui/pixy_display_helper.dart';
import 'package:pixy_clock/ui/pixy_divider.dart';
import 'package:pixy_clock/ui/pixy_number.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixy demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pixy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _backgroundController;
  AnimationController _numberController;
  AnimationController _dividerController;
  AnimationController _transitionHour1Controller;
  AnimationController _transitionHour2Controller;
  AnimationController _transitionMinute1Controller;
  AnimationController _transitionMinute2Controller;

  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
        duration: Duration(minutes: 5),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 100.0);
    _backgroundController.repeat(reverse: true);

    _numberController = AnimationController(
        duration: Duration(minutes: 3),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 100.0);
    _numberController.repeat(reverse: true);

    _dividerController = AnimationController(
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 500),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);
    _dividerController.repeat(reverse: true);

    _transitionHour1Controller = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);

    _transitionHour2Controller = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);

    _transitionMinute1Controller = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);

    _transitionMinute2Controller = AnimationController(
        duration: Duration(milliseconds: 1500),
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0);

    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _backgroundController.dispose();
    _numberController.dispose();
    _dividerController.dispose();
    _transitionHour1Controller.dispose();
    _transitionHour2Controller.dispose();
    _transitionMinute1Controller.dispose();
    _transitionMinute2Controller.dispose();

    super.dispose();
  }

  void _updateTime() {
    var prevDate = _dateTime ?? DateTime.now();
    var currentDate = DateTime.now();

    animatePixyDisplayNumbers(prevDate, currentDate);

    var duration =
        Duration(seconds: 1) - Duration(milliseconds: currentDate.millisecond);

    setState(() {
      _dateTime = currentDate;
    });

    _timer = Timer(
      duration,
      _updateTime,
    );
  }

  void animatePixyDisplayNumbers(DateTime prevDate, DateTime currentDate) {
    bool is12HourFormat = Config.USE_12_HOURS_FORMAT;

    var prevHour =
        DateFormat(is12HourFormat ? "h" : "H").format(prevDate).padLeft(2, '0');
    var prevMinute = DateFormat("m").format(prevDate).padLeft(2, '0');

    var currentHour = DateFormat(is12HourFormat ? "h" : "H")
        .format(currentDate ?? DateTime.now())
        .padLeft(2, '0');
    var currentMinute = DateFormat("m").format(currentDate).padLeft(2, '0');

    if (prevHour != currentHour) {
      if (currentHour.substring(0, 1) != prevHour.substring(0, 1)) {
        _transitionHour1Controller.forward(from: 0);
      }

      _transitionHour2Controller.forward(from: 0);
    }

    if (prevMinute != currentMinute) {
      if (currentMinute.substring(0, 1) != prevMinute.substring(0, 1)) {
        _transitionMinute1Controller.forward(from: 0);
      }

      _transitionMinute2Controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    bool isDarkMode = queryData.platformBrightness == Brightness.dark;
    Color foregroundColor = isDarkMode ? Colors.blueGrey : Colors.greenAccent;
    Color backgroundColor = isDarkMode ? Colors.greenAccent : Colors.blueGrey;
    Color displayColor = isDarkMode ? Colors.greenAccent : Colors.blueGrey;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Center(
          child: Stack(
        children: <Widget>[
          AnimatedBuilder(
              animation: _backgroundController,
              builder: (BuildContext context, Widget child) {
                return CustomPaint(
                    painter: PixyBackground(_backgroundController,
                        backgroundColor, foregroundColor),
                    child: AspectRatio(
                        aspectRatio: Config.PIXY_ASPECT_RATIO,
                        child: LayoutBuilder(builder: (context, constraints) {
                          var pixySquareWidth =
                              constraints.maxWidth / Config.PIXY_COLS;
                          var pixySquareHeight =
                              constraints.maxHeight / Config.PIXY_ROWS;
                          var displayTotalHeight = pixySquareHeight *
                              Config.PIXY_DISPLAY_CHAR_SQUARE_VERTICAL_COUNT;
                          var displayTotalWidth =
                              (Config.PIXY_DISPLAY_CHAR_SQUARE_HORIZONTAL_COUNT *
                                      5) *
                                  pixySquareWidth;

                          return Center(
                              child: SizedBox(
                                  width: displayTotalWidth +
                                      pixySquareWidth +
                                      pixySquareWidth,
                                  height: displayTotalHeight,
                                  child: Row(
                                    children: <Widget>[
                                      CustomPaint(
                                          painter: PixyNumber(
                                              PixyDisplayHelper.getHourUpdate(
                                                  _dateTime, true),
                                              1,
                                              _numberController,
                                              _transitionHour1Controller,
                                              displayColor),
                                          child: AspectRatio(
                                              aspectRatio: Config
                                                  .PIXY_DISPLAY_CHAR_RATIO,
                                              child: Container())),
                                      SizedBox(
                                        width: pixySquareWidth,
                                        height: displayTotalHeight,
                                      ),
                                      CustomPaint(
                                          painter: PixyNumber(
                                              PixyDisplayHelper.getHourUpdate(
                                                  _dateTime, false),
                                              2,
                                              _numberController,
                                              _transitionHour2Controller,
                                              displayColor),
                                          child: AspectRatio(
                                              aspectRatio: Config
                                                  .PIXY_DISPLAY_CHAR_RATIO,
                                              child: Container())),
                                      CustomPaint(
                                          painter: PixyDivider(
                                              3,
                                              _numberController,
                                              _dividerController,
                                              displayColor),
                                          child: AspectRatio(
                                              aspectRatio: Config
                                                  .PIXY_DISPLAY_CHAR_RATIO,
                                              child: Container())),
                                      CustomPaint(
                                          painter: PixyNumber(
                                              PixyDisplayHelper.getMinuteUpdate(
                                                  _dateTime, true),
                                              4,
                                              _numberController,
                                              _transitionMinute1Controller,
                                              displayColor),
                                          child: AspectRatio(
                                              aspectRatio: Config
                                                  .PIXY_DISPLAY_CHAR_RATIO,
                                              child: Container())),
                                      SizedBox(
                                        width: pixySquareWidth,
                                        height: displayTotalHeight,
                                      ),
                                      CustomPaint(
                                          painter: PixyNumber(
                                              PixyDisplayHelper.getMinuteUpdate(
                                                  _dateTime, false),
                                              5,
                                              _numberController,
                                              _transitionMinute2Controller,
                                              displayColor),
                                          child: AspectRatio(
                                              aspectRatio: Config
                                                  .PIXY_DISPLAY_CHAR_RATIO,
                                              child: Container())),
                                    ],
                                  )));
                        })));
              }),
        ],
      )),
    );
  }
}
