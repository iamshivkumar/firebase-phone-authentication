import 'package:flutter/material.dart';
import 'package:natureclinic/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:natureclinic/service/phone_auth.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  double _height, _width, _fixedPadding;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();

  String code = "";

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-verify-phone");
  @override
  void initState() {
    super.initState();
  }

  signIn() {
    if (code.length != 6) {
      _showSnackBar("Invalid OTP");
    }
    Provider.of<PhoneAuthDataProvider>(context, listen: false)
        .verifyOTPAndLogin(smsCode: code);
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
      duration: Duration(seconds: 2),
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  onStarted() {
    _showSnackBar("PhoneAuth started");
  }

  onCodeSent() {
    _showSnackBar("OPT sent");
  }

  onCodeResent() {
    _showSnackBar("OPT resent");
  }

  onVerified() async {
    _showSnackBar(
        "${Provider.of<PhoneAuthDataProvider>(context, listen: false).message}");
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
  }

  onFailed() {
    _showSnackBar("PhoneAuth failed");
  }

  onError() {
    _showSnackBar(
        "PhoneAuth error ${Provider.of<PhoneAuthDataProvider>(context, listen: false).message}");
  }

  onAutoRetrievalTimeOut() {
    _showSnackBar("PhoneAuth autoretrieval timeout");
  }

  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: TextField(
          key: Key(key),
          expands: false,
          autofocus: false,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              switch (code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
//          decoration: InputDecoration(
//              contentPadding: const EdgeInsets.only(
//                  bottom: 10.0, top: 10.0, left: 4.0, right: 4.0),
//              focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide:
//                      BorderSide(color: Colors.blueAccent, width: 2.25)),
//              border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(5.0),
//                  borderSide: BorderSide(color: Colors.white))),
        ),
      );
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;

    final phoneAuthDataProvider =
        Provider.of<PhoneAuthDataProvider>(context, listen: false);

    phoneAuthDataProvider.setMethods(
      onStarted: onStarted,
      onError: onError,
      onFailed: onFailed,
      onVerified: onVerified,
      onCodeResent: onCodeResent,
      onCodeSent: onCodeSent,
      onAutoRetrievalTimeout: onAutoRetrievalTimeOut,
    );

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreenAccent, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
            child: Stack(

              children: [
                Positioned(
                  bottom: 0,
                  top: 55,
                  left: -100,
                  right: -100,
                  child: Image.asset(
                    'assets/tree.png',
                    height: MediaQuery.of(context).size.height * 2.3 / 3,
                  ),
                ),
                Center(
          child: SingleChildScrollView(
                child: Card(
                  color: Colors.white.withOpacity(0.6),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: SizedBox(
                    height: _height * 8 / 10,
                    width: _width * 8 / 10,
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.all(_fixedPadding),
                            child: CircleAvatar(radius: MediaQuery.of(context).size.height*0.1)
                        ),

                        // AppName:
                        Text('Mother Nature Naturopathy\nClinic',textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),),
                        SizedBox(height: _fixedPadding,),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: _fixedPadding,
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Please enter the ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: 'One Time Password',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700)),
                                    TextSpan(
                                      text: ' sent to your mobile',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: _fixedPadding),
                          ],
                        ),
                        SizedBox(height: 16.0),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getPinField(key: "1", focusNode: focusNode1),
                            SizedBox(width: 5.0),
                            getPinField(key: "2", focusNode: focusNode2),
                            SizedBox(width: 5.0),
                            getPinField(key: "3", focusNode: focusNode3),
                            SizedBox(width: 5.0),
                            getPinField(key: "4", focusNode: focusNode4),
                            SizedBox(width: 5.0),
                            getPinField(key: "5", focusNode: focusNode5),
                            SizedBox(width: 5.0),
                            getPinField(key: "6", focusNode: focusNode6),
                            SizedBox(width: 5.0),
                          ],
                        ),

                        SizedBox(height: 32.0),
                        RaisedButton(
                          elevation: 16.0,
                          onPressed: signIn,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'VERIFY',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        )
                      ],
                    ),
                  ),
                ),
          ),
        ),
              ],
            )),
      ),
    );
  }
}
