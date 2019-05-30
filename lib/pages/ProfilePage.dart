import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/components/HeaderComponent.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ProfilePage extends StatefulWidget {
    ProfilePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                        // Header
                        HeaderComponent(title: "Profile")

                        /*Spacer(),
                        Container(
                            height: 200,
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(13, 31, 40, 51),
                                                        offset: Offset(0, -5),
                                                        blurRadius: 20,
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),*/
                    ],
                ),
            ),
            bottomNavigationBar: BottomNavigationComponent()
        );
    }

}
