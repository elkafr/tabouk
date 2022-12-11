import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:path/path.dart' as Path;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/models/user.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/shared_preferences/shared_preferences_helper.dart';
import 'package:tabouk/ui/account/edit_password_screen.dart';
import 'package:tabouk/ui/account/edit_personal_info_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:tabouk/custom_widgets/MainDrawer.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
 double _height = 0 , _width = 0;
 bool _isLoading = false;
  File _imageFile;
  dynamic _pickImageError;
  ApiProvider _apiProvider = ApiProvider();
  final _picker = ImagePicker();
  AuthProvider _authProvider;

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile = File(pickedFile.path);
      if(_imageFile != null){
        setState(() {
          _isLoading = true;
        });

                  FormData formData = new FormData.fromMap({
                    "user_id": _authProvider.currentUser.userId,
                    "user_name":  _authProvider.currentUser.userName,
                    "user_phone" : _authProvider.currentUser.userPhone,
                    "user_email":  _authProvider.currentUser.userEmail,
                      "user_country":_authProvider.currentUser.userCountry,
                    "imgURL": _imageFile != null ? await MultipartFile.fromFile(_imageFile.path,
                        filename: Path.basename(_imageFile.path)) : null,
                  });
                  final results = await _apiProvider
                      .postWithDio(Urls.PROFILE_URL+ "?api_lang=${_authProvider.currentLang}", body: formData);
                  setState(() => _isLoading = false);

                  if (results['response'] == "1") {
                    _authProvider
                        .setCurrentUser(User.fromJson(results["user"]));
                    SharedPreferencesHelper.save(
                        "user", _authProvider.currentUser);
                    Commons.showToast(context,message: results["message"] );
                  } else {
                    Commons.showError(context, results["message"]);
                  }
      }

    } catch (e) {
      _pickImageError = e;
    }
  }

Widget _buildItem({@required String title,@required String value}){
 return Container(
   height: _height  *0.05,
   margin: EdgeInsets.symmetric(horizontal: _width *0.04),
   child: Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: <Widget>[
       Text(title,style: TextStyle(
         color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400
       ),),
        Text(value,style: TextStyle(
         color: mainAppColor,fontSize: 15,fontWeight: FontWeight.w400
       ),)
     ],
   ),
 );
}

Widget _buildBodyItem(){
  return SingleChildScrollView(
    child: Container(
      height: _height,
      width: _width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

         Column(
           children: <Widget>[

             Stack(
               children: <Widget>[
                 Consumer<AuthProvider>(
                     builder: (context,authProvider,child){
                       return CircleAvatar(
                         backgroundColor: mainAppColor,
                         radius: _height *0.05,
                         backgroundImage: NetworkImage(authProvider.currentUser.userPhoto),
                       );
                     }
                 ),
                 Positioned(

                   bottom: 0,
                   right: _width *0.22,
                   child:  GestureDetector(
                     onTap: () => _onImageButtonPressed(ImageSource.gallery,
                         context: context) ,
                     child: Container(

                       child: CircleAvatar(

                         backgroundColor: mainAppColor,
                         child: Icon(Icons.photo_camera,color: Colors.white,),
                       ),
                     ),
                   ),
                 )

               ],
             ),

          Padding(padding: EdgeInsets.all(10)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => _onImageButtonPressed(ImageSource.gallery,
                    context: context) ,
                child: Container(

                  child: CircleAvatar(


                    backgroundColor: mainAppColor,
                    child: Icon(Icons.photo_camera,color: Colors.white),

                  ),
                ),
              ),
              Text(_authProvider.currentUser.userName,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: omarColor),),

            ],
          )


           ],
         ),

          SizedBox(height: _width*.4,),
    Consumer<AuthProvider>(
      builder: (context,authProvider,child){
           return  Container(

             margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.01),
             padding: EdgeInsets.all(15),
             decoration: BoxDecoration(
               boxShadow: [
                 BoxShadow(
                   color: Color(0xffBFBFBF),
                   blurRadius: 4.0,
                   spreadRadius: 2
                 ),
               ],
               border: Border.all(
                 width: 0.1,
                 color: Color(0xffBFBFBF),
               ),
               borderRadius: BorderRadius.all(
                 Radius.circular(12.0),
               ),
               color: Colors.white,
             ),
             child: Row(
               children: <Widget>[
                 Text(authProvider.currentUser.userPhone,style: TextStyle(color: omarColor,fontSize: 18),),
                 Spacer(),
                 Image.asset("assets/images/phone111.png"),
               ],
             ),
           );
      }
    ),






          Consumer<AuthProvider>(
              builder: (context,authProvider,child){
                return  Container(

                  margin: EdgeInsets.symmetric(horizontal: _width * 0.07,vertical: _height * 0.01),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffBFBFBF),
                          blurRadius: 4.0,
                          spreadRadius: 2
                      ),
                    ],
                    border: Border.all(
                      width: 0.1,
                      color: Color(0xffBFBFBF),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(authProvider.currentUser.userEmail,style: TextStyle(color: omarColor,fontSize: 18),),
                      Spacer(),
                      Image.asset("assets/images/email.png"),
                    ],
                  ),
                );
              }
          ),





        SizedBox(height: _width*.27,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: _width *0.02),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: _width *0.90,
                  child: CustomButton(
                    defaultMargin: false,
                    btnLbl: AppLocalizations.of(context).translate('edit_info'),
                    onPressedFunction: ()=> Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPersonalInfoScreen())),
                  ),
                ),
                Container(
                  width: _width *0.90,
                  child: CustomButton(


                    btnStyle: TextStyle(
                      color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700
                    ),
                     defaultMargin: false,
                    btnColor: omarColor,
                    btnLbl:  AppLocalizations.of(context).translate('edit_password'),
                          onPressedFunction: ()=> Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPasswordScreen())),
                  ),
                ),
              ],
            ),
          )


,
SizedBox(
  height: _height *0.02,
)



        ],
      ),
    ),
  );
}


@override
  Widget build(BuildContext context) {


  final appBar = AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor:Color(0xffF5F6F8),
    centerTitle: true,

    title:Text(AppLocalizations.of(context).translate('personal_info'),style: TextStyle(fontSize: 15,color: omarColor),),
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


    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    return PageContainer(
      child: Container(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          appBar: appBar,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: _buildBodyItem(),
          ),
        ),
      ),
    );
  }
}