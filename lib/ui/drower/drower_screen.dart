import 'package:tabouk/ui/add_ad/add_ads1_screen.dart';
import 'package:tabouk/ui/add_ad/add_ads2_screen.dart';
import 'package:tabouk/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tabouk/ui/packages/packages_screen.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen2.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/custom_widgets/dialogs/log_out_dialog.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/navigation_provider.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/ui/account/about_app_screen.dart';
import 'package:tabouk/ui/account/app_commission_screen.dart';
import 'package:tabouk/ui/account/contact_with_us_screen.dart';
import 'package:tabouk/ui/account/language_screen.dart';
import 'package:tabouk/ui/account/personal_information_screen.dart';
import 'package:tabouk/ui/account/terms_and_rules_Screen.dart';
import 'package:tabouk/ui/my_ads/my_ads_screen.dart';
import 'package:tabouk/ui/notification/notification_screen.dart';
import 'package:tabouk/ui/favourite/favourite_screen.dart';
import 'package:tabouk/ui/my_chats/my_chats_screen.dart';
import 'package:tabouk/ui/home/home_screen.dart';
import 'package:tabouk/ui/blacklist/blacklist_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/providers/terms_provider.dart';
import 'package:tabouk/utils/error.dart';

class AppDrawer extends StatelessWidget {
  double _width, _height;

  AuthProvider _authProvider ;
  HomeProvider _homeProvider ;

  Widget _buildAppDrawer(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);
    return Container(

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash2.png'),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.only(top: 70, bottom: 30, left: 10, right:10),
      width: _width,

      child:  ListView(
        padding: EdgeInsets.zero,

        children: <Widget>[




          (_authProvider.currentUser==null)?
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: hintColor.withOpacity(0.4),
                    ),
                    color: Colors.white,


                  ),
                  child: Image.asset("assets/images/logo.png",width: 50,height:50 ,),
                ),
                Padding(padding: EdgeInsets.all(7)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)),
                    Text(_homeProvider.currentLang=="ar"?"زائر":"Guest",style: TextStyle(color: Colors.white,fontSize: 18)),
                    Text(_homeProvider.currentLang=="ar"?"الحساب الشخصي":"Profile",style: TextStyle(color: Colors.white,fontSize: 16),),
                  ],
                )
              ],
            ),
          )
              :Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Consumer<AuthProvider>(
                    builder: (context,authProvider,child){
                      return CircleAvatar(
                        backgroundColor: accentColor,
                        backgroundImage: NetworkImage(authProvider.currentUser.userPhoto),
                        maxRadius: 30,
                      );
                    }
                ),
                Padding(padding: EdgeInsets.all(7)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)),
                    Text(_authProvider.currentUser.userName,style: TextStyle(color: mainAppColor,fontSize: 18)),
                    Text(_homeProvider.currentLang=="ar"?"الحساب الشخصي":"Profile",style: TextStyle(color: Colors.white,fontSize: 16),),
                  ],
                )
              ],
            ),
          ),

          ListTile(
            onTap: ()=>                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SectionAdsScreen2(catId: "0",adCatName: "خطط رحلتك",))
            )
            ,

            dense:true,

            title: Text(_authProvider.currentLang=="ar"?"خطط رحلتك":"Plan your trip",style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),

          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PersonalInformationScreen()))
            ,

            dense:true,

            title: Text(AppLocalizations.of(context).translate("personal_info"),style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),





          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PackagesScreen())),
            dense:true,

            title: Text(_homeProvider.currentLang=="ar"?"اضافة علامة تجارية":"Add a brand",style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),




          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddAd1Screen())),
            dense:true,

            title: Text(_homeProvider.currentLang=="ar"?"اضافة خبر":"add news",style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),



          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddAd2Screen())),
            dense:true,

            title: Text(_homeProvider.currentLang=="ar"?"اضافة معرض صور":"Add a photo gallery",style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),





          (_authProvider.currentUser==null)?Text("",style: TextStyle(height: 0),):ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyAdsScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("my_ads"),style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),







          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AboutAppScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("about_app"),style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),

          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PackagesScreen())),
            dense:true,

            title: Text(_homeProvider.currentLang=="ar"?"الباقات":"Packages",style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),


          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndRulesScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("rules_and_terms"),style: TextStyle(
                color:omarColor,fontSize: 15
            ),),
          ),
          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactWithUsScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("contact_us"),style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ),

          ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LanguageScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("language"),style: TextStyle(
                color:omarColor,fontSize: 15
            ),),
          ),

          Padding(padding: EdgeInsets.all(20)),
          (_authProvider.currentUser==null)?ListTile(
            onTap: ()=>    Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen())),
            dense:true,

            title: Text( AppLocalizations.of(context).translate("login"),style: TextStyle(
                color: omarColor,fontSize: 15
            ),),
          ):ListTile(
            dense:true,
            leading: Icon(FontAwesomeIcons.signOutAlt,color: mainAppColor,),
            title: Text( AppLocalizations.of(context).translate('logout'),style: TextStyle(
                color:omarColor,fontSize: 15
            ),),
            onTap: (){
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (_) {
                    return LogoutDialog(
                      alertMessage:
                      AppLocalizations.of(context).translate('want_to_logout'),
                      onPressedConfirm: () {
                        Navigator.pop(context);
                        SharedPreferencesHelper.remove("user");
                        _homeProvider.setCheckedValue("false");

                        Navigator.pushReplacementNamed(context,  '/navigation');
                        _authProvider.setCurrentUser(null);
                      },
                    );
                  });
            },
          ),




          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: _width * 0.1, vertical: _height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getTwitt() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/twitter.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    })
                ,

                Padding(padding: EdgeInsets.all(5)),
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getLinkid() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/tiktok.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
                Padding(padding: EdgeInsets.all(5)),
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getInst() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child: Image.asset(
                                  'assets/images/instagram.png',
                                  height: 40,
                                  width: 40,
                                ));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
                Padding(padding: EdgeInsets.all(5)),
                FutureBuilder<String>(
                    future: Provider.of<TermsProvider>(context,
                        listen: false)
                        .getFace() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage:  AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return GestureDetector(
                                onTap: () {
                                  launch(snapshot.data.toString());
                                },
                                child:Icon(FontAwesomeIcons.snapchat,size: 42,));
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
              ],
            ),
          ),






        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return _buildAppDrawer(context);
  }
}
