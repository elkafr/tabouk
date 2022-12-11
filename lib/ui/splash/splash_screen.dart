import 'package:flutter/cupertino.dart';
import 'package:tabouk/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/ui/auth/login_screen.dart';
import 'package:tabouk/ui/home/home_screen.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:location/location.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  double _height = 0, _width = 0;
  AuthProvider _authProvider;
  HomeProvider _homeProvider;
  LocationData _locData;


  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  String xxx;

  
    Future initData() async {
    await Future.delayed(Duration(seconds: 2));
  }


   Future<void> _getLanguage() async {
    String currentLang = await SharedPreferencesHelper.getUserLang();
    _authProvider.setCurrentLanguage(currentLang);

  }


  Future<void> _getCurrentUserLocation() async {
    _locData = await Location().getLocation();
    if(_locData != null){
      print('lat' + _locData.latitude.toString());
      print('longitude' + _locData.longitude.toString());

      setState(() {


      });
    }
  }



  Future<Null> _checkIsLoginUser() async {
    var userData = await SharedPreferencesHelper.read("user");
    if (userData != null) {
      xxx="true";
    }else{
      xxx="false";
    }


  }

  @override
  void initState() {
    super.initState();
      _getLanguage();
    _checkIsLoginUser();
    print(xxx);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.fromDirection(0.2, 0.1),
      end: Offset(-1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    initData().then((value) {
print(_homeProvider.checkedValue);




initData().then((value) {
  Navigator.pushReplacementNamed(context,  '/navigation');
});


    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: Stack(
          children: [
            Image.asset(
              'assets/images/splash.png',
              fit: BoxFit.fill,
              height: _height,
              width: _width,
            ),




            Positioned(
              top: _height * 0.3,

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: _width,
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                    /*
                    SizedBox(height: _width*.06,),
                    Container(
                        width: _width,

                        alignment: Alignment.center,
                        child: Center(
                          child: Image.asset(
                            'assets/images/ghorfa.png',cacheWidth: 400,height: _width*.2,
                          ),
                        )),

                    SizedBox(height: _width*.06,),

                    Container(

                        width: _width,

                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: Image.asset(
                            'assets/images/dalil.png',cacheWidth: 500,height: _width*.4,
                          ),
                        )),

                    SizedBox(height: _width*.04,),

                    */



                  ],
                ))
          ] ),
    );
  }
}
