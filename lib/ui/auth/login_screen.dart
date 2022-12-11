import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/user.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/ui/home/home_screen.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';

import 'dart:math' as math;
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin{
  double _height = 0 , _width = 0;
  final _formKey = GlobalKey<FormState>();
  AuthProvider _authProvider;
  HomeProvider _homeProvider;
  ApiProvider _apiProvider = ApiProvider();
  bool _isLoading = false;
  String _userPhone ='' ,_userPassword ='';
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool checkedValue=false;



  Future initData() async {
    await Future.delayed(Duration(seconds: 2));
  }


  Widget _buildBodyItem(){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: _width*.53,
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
              child:   Column(
                children: <Widget>[
                  Image.asset("assets/images/lock.png"),
                  Padding(padding: EdgeInsets.all(2)),
                  Text(AppLocalizations.of(context).translate('login'),style: TextStyle(color: omarColor),)
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(
                  vertical: _height *0.02
              ),
              child: CustomTextFormField(
                onChangedFunc: (text){
                  _userPhone = text;
                },

                suffixIconIsImage: true,
                suffixIconImagePath: 'assets/images/user.png',
                hintTxt:  AppLocalizations.of(context).translate('email'),
                validationFunc: validateUserEmail
              ),
            ),



            CustomTextFormField(
              isPassword: true,
              suffixIconIsImage: true,
              onChangedFunc: (text){
                _userPassword =text;
              },
              suffixIconImagePath: 'assets/images/key.png',
              hintTxt: AppLocalizations.of(context).translate('password'),
              validationFunc: validatePassword,
            ),

          SizedBox(height: 15,),
            Container(
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
              child: GestureDetector(
                onTap: ()=> Navigator.pushNamed(context,  '/phone_password_reccovery_screen' ),
                child: RichText(

                  text: TextSpan(
                    style: TextStyle(
                      color:mainAppColor , fontSize: 14, fontFamily: 'Cairo',),
                    children: <TextSpan>[
                      TextSpan(text:  AppLocalizations.of(context).translate('forget_password')),
                      TextSpan(
                        text:  AppLocalizations.of(context).translate('click_her'),
                        style: TextStyle(
                            color: Color(0xffA8C21C),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            fontFamily: 'Cairo'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
           /* Container(
              alignment: Alignment.centerRight,

              child: CheckboxListTile(

                checkColor: Colors.white,
                activeColor: mainAppColor,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("تذكرنى ؟",style: TextStyle(fontSize: 15),),
                value: checkedValue,
                onChanged: (newValue) {
                  SharedPreferencesHelper.save(
                      "checkUser", newValue);
                  setState(() {
                    checkedValue = newValue;
                    _homeProvider.setCheckedValue(newValue.toString());
                    print(_homeProvider.checkedValue);

                  });
                },

              ),
            ),
            SizedBox(height: 20,), */

            _buildLoginBtn(),



              Container(



                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.01),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context,  '/navigation');
                  },
                  child: Container(
                    width: _width*.30,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(15.00),
                        ),
                        border: Border.all(color: mainAppColor)),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(_homeProvider.currentLang=="ar"?"تخطي كزائر":"Skip as a visitor",style: TextStyle(color: omarColor),),
                        Padding(padding: EdgeInsets.all(9)),
                        Image.asset(
                          'assets/images/back.png',
                          color: omarColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),







       SizedBox(height: 50,),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(_homeProvider.currentLang=="ar"?"لو لم يكن لديك حساب":"If you don't have an account",style: TextStyle(color: omarColor,fontSize: 15),),
                Padding(padding: EdgeInsets.all(7)),

                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(_homeProvider.currentLang=="ar"?" يمكنك التسجيل":"You can register ",style: TextStyle(color:omarColor,fontSize: 15),),
                      Padding(padding: EdgeInsets.all(3)),
                      Text(_homeProvider.currentLang=="ar"?"من هنا":"From here ",style: TextStyle(color: mainAppColor,fontSize: 15),)
                    ],
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, '/register_screen');
                  },
                )
              ],
            )


          ],
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return _isLoading
        ? Center(
      child:SpinKitFadingCircle(color: mainAppColor),
    )
        : CustomButton(
      btnLbl:  AppLocalizations.of(context).translate('login'),
      btnColor: mainAppColor,
      onPressedFunction: () async {

        if (_formKey.currentState.validate()) {
          _firebaseMessaging.getToken().then((token) async {
            print('token: $token');

            setState(() {
              _isLoading = true;
            });
            final results = await _apiProvider
                .post(Urls.LOGIN_URL +"?api_lang=${_authProvider.currentLang}", body: {
              "user_email":  _userPhone,
              "user_pass": _userPassword,
              "token":token

            });

            setState(() => _isLoading = false);
            if (results['response'] == "1") {
              _homeProvider.setCheckedValue("true");
              _login(results);

            } else {
              Commons.showError(context, results["message"]);

            }
          });

        }
      },
    );
  }

  _login(Map<String,dynamic> results) {
    _authProvider.setCurrentUser(User.fromJson(results["user_details"]));
    SharedPreferencesHelper.save("user", _authProvider.currentUser);
    Commons.showToast( context,message:results["message"] ,color:  mainAppColor);
    initData().then((value) {
      Navigator.pushReplacementNamed(context,  '/navigation');
    });
  }


  @override
  Widget build(BuildContext context) {
    _height =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
    return PageContainer(


      child: Scaffold(

        backgroundColor: Colors.black,
          body: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/splash1.png',
                fit: BoxFit.fill,
                height: _height,
                width: _width,
              ),
              _buildBodyItem(),



            ],
          )
      ),
    );
  }
}