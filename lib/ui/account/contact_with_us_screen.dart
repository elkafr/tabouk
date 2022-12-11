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
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;
import 'package:tabouk/custom_widgets/MainDrawer.dart';

class ContactWithUsScreen extends StatefulWidget {
  @override
  _ContactWithUsScreenState createState() => _ContactWithUsScreenState();
}

class _ContactWithUsScreenState extends State<ContactWithUsScreen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
   ApiProvider _apiProvider = ApiProvider();
 bool _isLoading = false;
bool _initialRun = true;
AuthProvider _authProvider;
 String _userName ='' ,_userEmail ='' , _message ='';

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            CircleAvatar(
              radius: _height * 0.07,
              backgroundColor: mainAppColor,
              child: Icon(
                Icons.mail,
                size: _height * 0.07,
                color: Colors.white,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: _height * 0.04),
                child: CustomTextFormField(


                  prefixIconIsImage: true,
                  onChangedFunc: (text){
                    _userName = text;
                  },
                  prefixIconImagePath: 'assets/images/user.png',
                  hintTxt: AppLocalizations.of(context).translate('user_name'),
                  validationFunc: validateUserName
                
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(

                prefixIconIsImage: true,
                onChangedFunc: (text){
                  _userEmail = text;
                },
                prefixIconImagePath: 'assets/images/mail.png',
                hintTxt: AppLocalizations.of(context).translate('email'),
                validationFunc: validateUserEmail
              ),
            ),
            CustomTextFormField(
              maxLines: 3,
              onChangedFunc: (text){
                _message = text;
              },
              hintTxt: AppLocalizations.of(context).translate('message'),
              validationFunc:  validateMsg,
            ),
            Container(
              margin: EdgeInsets.only(top: _height *0.02,bottom: _height *0.02),
              child: _buildSendBtn()
            ),



          ],
        ),
      ),
    );
  }

Widget _buildSendBtn() {
    return _isLoading
        ? Center(
            child:SpinKitFadingCircle(color: mainAppColor),
          )
        : CustomButton(
              btnLbl: AppLocalizations.of(context).translate('send'),
              onPressedFunction: () async {
                if (_formKey.currentState.validate()) {

                  setState(() {
                    _isLoading = true;
                  });
                 final results = await _apiProvider
                      .post(Urls.CONTACT_URL + "?api_lang=${_authProvider.currentLang}", body: {
                    "msg_name":  _userName,
                    "msg_email": _userEmail,
                    "msg_details":_message

                  });
               
            setState(() => _isLoading = false);
                  if (results['response'] == "1") {
                    Commons.showToast(context, message:results["message"]);
                    Navigator.pop(context);

                      
                  } else {
                    Commons.showError(context, results["message"]);

                  }
                   
                }
              },
            );
  }

 



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _authProvider = Provider.of<AuthProvider>(context);

     _initialRun = false;
    }
  }
  @override
  Widget build(BuildContext context) {


    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Color(0xffF5F6F8),
      centerTitle: true,

      title:Text(AppLocalizations.of(context).translate('contact_us'),style: TextStyle(fontSize: 15,color: omarColor),),
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
    return PageContainer(

      child: Scaffold(
      backgroundColor: Color(0xffF5F6F8),
        appBar: appBar,


        body: _buildBodyItem(),
      ),
    );
  }
}
