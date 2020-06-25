import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'get_phone.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        elevation: 0,
        title: Text(
          'Mother Nature Naturopathy Clinic',
          style: TextStyle(
            color: Colors.teal[700],
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                radius: 17,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [Icon(Icons.notifications_none,color: Colors.teal,)],
            ),
            onPressed: () async{
             await FirebaseAuth.instance.signOut();
             Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPhone()));
            },
          )
        ],
      ),
      drawerScrimColor: Colors.greenAccent[100].withOpacity(0.3),
      drawer: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: SizedBox(
                height: 600,
                width: 250,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightGreenAccent, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              top: 0,
              left: -100,
              right: -100,
              child: Image.asset(
                'assets/tree.png',
                height: MediaQuery.of(context).size.height * 2 / 3,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Hello, Ramesh', style: TextStyle(fontSize: 20)),
                      Text('25/01/2020 01:00 PM'),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.purple[700].withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  'Appointment on 30/01/2020',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  color: Colors.white,
                                  icon: Icon(Icons.clear),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  color: Colors.green[50].withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: appWidth / 18),
                    child: Column(
                      children: [
                        SizedBox(
                          height: appHeight / 36,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [MainCard('Book\nAppointment'), MainCard('Past\nMedical History')],
                        ),
                        SizedBox(
                          height: appHeight / 36,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [MainCard('View\nPrescription'), MainCard('Download\nBill')],
                        ),
                        SizedBox(
                          height: appHeight / 36,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [MainCard('Update\nHeath Info'), MainCard('BMI\nCalculator')],
                        ),
                        SizedBox(
                          height: appHeight / 36,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainCard extends StatelessWidget {
  final String text;
  MainCard(this.text);
  @override
  Widget build(BuildContext context) {
    double appWidth = MediaQuery.of(context).size.width;
    double cardWidth = appWidth / 3 + appWidth / 18;
    double appHeight = MediaQuery.of(context).size.height;
    double cardHeight = appHeight / 6 + appHeight / 36;
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appWidth / 36)),
      child: Container(
        height: cardHeight,
        width: cardWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 30,
            ),
            Text(text,textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
