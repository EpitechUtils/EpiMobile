import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenDisplay extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Stack(
                    alignment: Alignment.center,
                    children: [

                        Positioned(
                            left: 6,
                            right: 6,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [

                                    Container(
                                        height: MediaQuery.of(context).size.height,
                                        child: Opacity(
                                            opacity: 0.3,
                                            child: Image.asset(
                                                "assets/images/love--chat-3.png",
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                    )

                                ],
                            ),
                        ),
                        Positioned(
                            child: Container(
                                width: 305,
                                height: 140,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [

                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment(0.92, 1.1),
                                                        end: Alignment(0.27, 0.46),
                                                        stops: [
                                                            0,
                                                            1,
                                                        ],
                                                        colors: [
                                                            Color.fromARGB(255, 26, 204, 180),
                                                            Color.fromARGB(255, 41, 155, 203),
                                                        ],
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                                ),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                        Container(
                                                            margin: EdgeInsets.only(right: 19),
                                                            child: Text(
                                                                "E",
                                                                style: TextStyle(
                                                                    color: Color.fromARGB(255, 248, 248, 248),
                                                                    fontSize: 40,
                                                                    fontFamily: "takota",
                                                                ),
                                                                textAlign: TextAlign.left,
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ),
                                        Spacer(),
                                        Container(
                                            height: 70,
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                    Positioned(
                                                        bottom: 0,
                                                        child: Container(
                                                            child: Text(
                                                                "EpiMobile",
                                                                style: TextStyle(
                                                                    color: Color.fromARGB(255, 42, 153, 204),
                                                                    fontSize: 55,
                                                                    letterSpacing: 1.12,
                                                                    fontFamily: "takota",
                                                                ),
                                                                textAlign: TextAlign.center,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),

                                    ],
                                ),
                            ),
                        ),

                    ],
                ),
            ),
        );
    }

}
