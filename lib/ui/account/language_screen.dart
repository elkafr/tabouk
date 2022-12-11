import 'package:flutter/material.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/locale/locale_helper.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;



class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  double _height, _width;
AuthProvider _authProvider;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: _width*.2,
        ),
        Center(
            child:Image.asset("assets/images/language.png")
        ),

        SizedBox(
          height: _width*.2,
        ),
Center(
  child:Text(_authProvider.currentLang=="ar"?"اختار اللغة":"Select language",style: TextStyle(color: omarColor,fontWeight: FontWeight.bold,fontSize: 15),),
),

        SizedBox(
          height: _width*.2,
        ),
        CustomButton(
          btnColor: mainAppColor,
          btnLbl: AppLocalizations.of(context).translate('arabic'),
          onPressedFunction: (){
            if(_authProvider.currentLang != 'ar'){
              SharedPreferencesHelper.setUserLang('ar');
              helper.onLocaleChanged(new Locale('ar'));
              _authProvider.setCurrentLanguage('ar');
            }
            Navigator.pushReplacementNamed(context,  '/navigation');
          },
        ),

        CustomButton(
          btnColor: Color(0xff3CC2ED),
          btnLbl:AppLocalizations.of(context).translate('english'),
          onPressedFunction: (){
            if(_authProvider.currentLang != 'en'){
              SharedPreferencesHelper.setUserLang('en');
              helper.onLocaleChanged( Locale('en'));
              _authProvider.setCurrentLanguage('en');

            }
            Navigator.pushReplacementNamed(context,  '/navigation');
          },
        ),


      ],
    );
  }

  @override
  Widget build(BuildContext context) {
     _authProvider   = Provider.of<AuthProvider>(context);


     final appBar = AppBar(
       automaticallyImplyLeading: false,
       elevation: 0,
       backgroundColor: Color(0xffF5F6F8),
       centerTitle: true,

       title:Text( AppLocalizations.of(context).translate('language'),style: TextStyle(fontSize: 15,color: omarColor),),
       actions: <Widget>[


         IconButton(
             icon: Consumer<AuthProvider>(
               builder: (context,authProvider,child){
                 return authProvider.currentLang == 'ar' ? Image.asset(
                   'assets/images/left.png',
                   color: omarColor,
                 ): Transform.rotate(
                     angle: 180 * math.pi / 180,
                     child:  Image.asset(
                       'assets/images/left.png',
                       color: omarColor,
                     ));
               },
             ),
             onPressed: () =>
                 Navigator.pop(context)

         )



       ],
     );



     _height = MediaQuery.of(context).size.height -
      
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return PageContainer(
      child: Scaffold(
        backgroundColor: Color(0xffF5F6F8),
        appBar: appBar,


        body: _buildBodyItem(),
      ),
    );
  }
}
