import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/chat_message.dart';
import 'package:tabouk/models/chat_msg_between_members.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/chat_provider.dart';
import 'package:tabouk/ui/chat/widgets/chat_msg_item.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/error.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:tabouk/custom_widgets/MainDrawer.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String senderName;
  final String senderImg;
  final String senderPhone;
  final String adsId;

  const ChatScreen(
      {Key key,
        this.senderId,
        this.senderName,
        this.senderImg,
        this.senderPhone,
        this.adsId,
      })
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double _height = 0, _width = 0;
  AuthProvider _authProvider;
  ApiProvider _apiProvider = ApiProvider();
  TextEditingController _messageController = TextEditingController();

  Widget _buildBodyItem() {
    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Container(
          height: _height * 0.1,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.only(right: 15,left: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: hintColor.withOpacity(0.4),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[

              Text(
                widget.senderName,
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  launch("tel://${widget.senderPhone}");
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: _width * 0.025),
                    child: Image.asset('assets/images/phone1.png')),
              ),


            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ChatMsgBetweenMembers>>(
              future: Provider.of<ChatProvider>(context, listen: false)
                  .getChatMessageList(widget.senderId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return SpinKitFadingCircle(color: mainAppColor);
                  case ConnectionState.active:
                    return Text('');
                  case ConnectionState.waiting:
                    return SpinKitFadingCircle(color: mainAppColor);
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Error(
                        //  errorMessage: snapshot.error.toString(),
                          errorMessage:
                          AppLocalizations.of(context).translate('error'),
                          onRetryPressed: () {
                            //  setState(() {
                            //    _refreshHandle();
                            //  });
                          });
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: _width,
                                height: _height * 0.15,
                                child: ChatMsgItem(
                                  chatMessage: snapshot.data[index],
                                ),
                              );
                            });
                      } else {
                        return NoData(
                          message:
                          AppLocalizations.of(context).translate('no_msgs'),
                        );
                      }
                    }
                }
                return SpinKitFadingCircle(color: mainAppColor);
              }),
        ),
        Divider(),
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
          width: _width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: hintColor.withOpacity(0.4),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 6,
              ),
            ],
          ),
          child: CustomTextFormField(
            enableHorizontalMargin: false,
            controller: _messageController,
            hintTxt: AppLocalizations.of(context).translate('enter_msg'),
            suffix: IconButton(
              icon: Icon(Icons.send,color: mainAppColor,),
              onPressed: () async {
                if (_messageController.text.trim().length > 0) {
                  FocusScope.of(context).requestFocus(FocusNode());

                  final results = await _apiProvider.post(Urls.SEND_URL, body: {
                    "message_sender": _authProvider.currentUser.userId,
                    "message_recever": widget.senderId,
                    "message_content": _messageController.text,
                    "message_ads": "0",
                  });

                  if (results['response'] == "1") {
                    setState(() {
                      _messageController.clear();
                    });
                  } else {
                    Commons.showError(context, results["message"]);
                  }
                } else {
                  Commons.showToast(context,
                      message: AppLocalizations.of(context)
                          .translate('please_enter_msg'));
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,

      title:Text("مراسلة",style: TextStyle(fontSize: 15,color: omarColor),),
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

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: _buildBodyItem(),
      ),
    );
  }
}
