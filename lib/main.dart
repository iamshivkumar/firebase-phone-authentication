import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'package:flutter/services.dart';
import 'screens/get_phone.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'service/countries.dart';
import 'service/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhoneAuthDataProvider(),
        ),
      ],
      child: MaterialApp(
        home:  FutureBuilder<FirebaseUser>(
          builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
            if (snapshot.hasData) {
              FirebaseUser user = snapshot.data;
              return HomePage();
            } else {
              return  GetPhone();
            }
          },
          future: FirebaseAuth.instance.currentUser(),
        ),

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
