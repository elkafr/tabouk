import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
class PhonePasswordRecoveryScreen extends StatefulWidget {
  @override
  _PhonePasswordRecoveryScreenState createState() => _PhonePasswordRecoveryScreenState();
}

class _PhonePasswordRecoveryScreenState extends 
State<PhonePasswordRecoveryScreen>  with ValidationMixin{
 double _height = 0 , _width = 0;
 ApiProvider _apiProvider = ApiProvider();
 AuthProvider _authProvider;
 bool _isLoading = false;
 String _userPhone ='';
 final _formKey = GlobalKey<FormState>();

Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      
          SizedBox(
            height: 80,
          ),


           Container(
             alignment: Alignment.center,
             margin: EdgeInsets.only(top: _height *0.05),
             child:  Image.asset('assets/images/fullcall.png',height:_height *0.2 ,),
           ),


          SizedBox(
            height: 160,
          ),

          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.02),
            child:   Text(AppLocalizations.of(context).translate('password_recovery'),style: TextStyle(color: Colors.white),),
          ),

          CustomTextFormField(
                suffixIconIsImage: true,
                suffixIconImagePath: 'assets/images/email.png',
                hintTxt: AppLocalizations.of(context).translate('email'),
                onChangedFunc: (text){
                  _userPhone = text;
                },

              ),
          
           SizedBox(
             height: _height *0.02,
           ),
          _buildRetrievalCodeBtn()
          
          
         
        
       
        ],
      ),
    ),
  );
}


 Widget _buildRetrievalCodeBtn() {
    return _isLoading
        ? Center(
            child:SpinKitFadingCircle(color: mainAppColor),
          )
        :  CustomButton(
           btnLbl: AppLocalizations.of(context).translate('send_recovery_code'),
           onPressedFunction: () async {
              
             if(_formKey.currentState.validate()){
                 setState(() {
                    _isLoading = true;
                  });
                 final results = await _apiProvider
                      .post(Urls.PASSSWORD_RECOVERY_URL +"?api_lang=${_authProvider.currentLang}", body: {
                    "user_email":  _userPhone,
               
                   
                  });
               
            setState(() => _isLoading = false);
                  if (results['response'] == "1") {
_authProvider.setUserPhone(_userPhone);
                      Navigator.pushNamed(context,   '/login_screen');
                      
                  } else {
                    Commons.showError(context, results["message"]);
                
                  }
         
             } 
           },
         );
         }
  @override
  Widget build(BuildContext context) {
         _height =  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    return PageContainer(
      child: Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.fill,
            height: _height,
            width: _width,
          ),
          _buildBodyItem(),
           Container(
          
          height: 60,

          child: Row(
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
    IconButton(
                    icon: Consumer<AuthProvider>(
                      builder: (context,authProvider,child){
                        return authProvider.currentLang == 'ar' ? Image.asset(
                      'assets/images/left.png',
                      color: Colors.white,
                    ): Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child:  Image.asset(
                      'assets/images/left.png',
                      color: Colors.white,
                    ));
                      },
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),



            ],
          )),
        ],
      )
      ),
    );
  }
}