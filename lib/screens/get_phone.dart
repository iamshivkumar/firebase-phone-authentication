import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:natureclinic/screens/country_selector_page.dart';
import 'package:provider/provider.dart';
import 'package:natureclinic/service/countries.dart';
import 'package:natureclinic/service/phone_auth.dart';
import 'verify_phone.dart';

class GetPhone extends StatefulWidget {
  @override
  _GetPhoneState createState() => _GetPhoneState();
}

class _GetPhoneState extends State<GetPhone> {
  double _height, _width, _fixedPadding;
  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  startPhoneAuth() async {
    final phoneAuthDataProvider =
        Provider.of<PhoneAuthDataProvider>(context, listen: false);
    phoneAuthDataProvider.loading = true;
    var countryProvider = Provider.of<CountryProvider>(context, listen: false);
    bool validPhone = await phoneAuthDataProvider.instantiate(
        dialCode: countryProvider.selectedCountry.dialCode,
        onCodeSent: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (BuildContext context) => VerifyPhone()));
        },
        onFailed: () {
          _showSnackBar(phoneAuthDataProvider.message);
        },
        onError: () {
          _showSnackBar(phoneAuthDataProvider.message);
        });
    if (!validPhone) {
      phoneAuthDataProvider.loading = false;
      _showSnackBar("Oops! Number seems invaild");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;
    final countriesProvider = Provider.of<CountryProvider>(context);
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
                  color: Colors.white.withOpacity(0.5),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                  child: SizedBox(
                    height: _height * 8 / 10,
                    width: _width * 8 / 10,
                    child: countriesProvider.countries.length > 0
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(_fixedPadding),
                                child: CircleAvatar(radius: MediaQuery.of(context).size.height*0.1)
                              ),
                              Text('Mother Nature Naturopathy\nClinic',textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: _fixedPadding, left: _fixedPadding),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Select your country',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: _fixedPadding,
                                    left: _fixedPadding,
                                    right: _fixedPadding),
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectCountry()),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 4.0,
                                          right: 4.0,
                                          top: 8.0,
                                          bottom: 8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                                  ' ${countriesProvider.selectedCountry.flag}  ${countriesProvider.selectedCountry.name} ')),
                                          Icon(Icons.arrow_drop_down, size: 24.0)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: _fixedPadding, left: _fixedPadding),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Enter your phone',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: _fixedPadding,
                                    right: _fixedPadding,
                                    bottom: _fixedPadding),
                                child: Card(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          "  " +
                                                  countriesProvider
                                                      .selectedCountry.dialCode ??
                                              "+91" + "  ",
                                          style: TextStyle(fontSize: 16.0)),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormField(
                                          controller:
                                              Provider.of<PhoneAuthDataProvider>(
                                                      context,
                                                      listen: false)
                                                  .phoneNumberController,
                                          autofocus: false,
                                          keyboardType: TextInputType.phone,
                                          key: Key('EnterPhone-TextFormField'),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            errorMaxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(width: _fixedPadding),
                                  Icon(Icons.info,
                                      color: Colors.white, size: 20.0),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'We will send ',
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
                                          text: ' to this mobile number',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400)),
                                    ])),
                                  ),
                                  SizedBox(width: _fixedPadding),
                                ],
                              ),
                              SizedBox(height: _fixedPadding * 1.5),
                              RaisedButton(
                                elevation: 16.0,
                                onPressed: startPhoneAuth,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'SEND OTP',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                              ),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
