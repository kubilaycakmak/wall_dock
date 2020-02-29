import 'dart:ui';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wall_dock/style/color.dart';
import 'package:wall_dock/style/text.dart';
import 'home.dart';
import 'package:provider/provider.dart';
import 'package:wall_dock/bloc.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorTransparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  runApp(WallDock());
}

class WallDock extends StatelessWidget {
  const WallDock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PhotoBloc>(
      create: (context) => PhotoBloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ResolutionScreen(),
      ),
    );
  }
}

class ResolutionScreen extends StatefulWidget {
  ResolutionScreen({Key key}) : super(key: key);

  @override
  _ResolutionScreenState createState() => _ResolutionScreenState();
}

class _ResolutionScreenState extends State<ResolutionScreen> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo;

  // fetchDeviceInfo() async {
  //   androidInfo = await deviceInfo.androidInfo;
  // }

  @override
  void initState() {
    super.initState();
    // fetchDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    int height = window.physicalSize.height.toInt();
    int width = window.physicalSize.width.toInt();
    return SplashScreen(
      loaderColor: colorDark,
      backgroundColor: colorGrayTransparent,
      seconds: 4,
      title: Text(
        'Screen Resolution is\n' + '$height' + ' x ' + '$width',
        style: splashScreenStyle,
        textAlign: TextAlign.center,
      ),
      styleTextUnderTheLoader: paragStyle,
      navigateAfterSeconds: Home(),
    );
  }
}
