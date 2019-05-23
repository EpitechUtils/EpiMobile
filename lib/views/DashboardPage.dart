import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
    DashboardPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Container(
                            height: 140,
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                            height: 140,
                                            child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                    Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        child: Container(
                                                            height: 140,
                                                            child: Image.asset(
                                                                "assets/images/mask-7.png",
                                                                fit: BoxFit.cover,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Positioned(
                                        left: 16,
                                        top: 82,
                                        right: 16,
                                        child: Container(
                                            height: 41,
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                            "Tableau de bord",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                                fontSize: 30,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.left,
                                                        ),
                                                    ),
                                                    Spacer(),
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Container(
                                                            width: 39,
                                                            height: 39,
                                                            margin: EdgeInsets.only(top: 2),
                                                            child: Image.asset(
                                                                "assets/images/search.png",
                                                                fit: BoxFit.none,
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Container(
                            height: 216,
                            margin: EdgeInsets.only(left: 16, top: 16),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 215,
                                            margin: EdgeInsets.only(right: 16),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                            "Story",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 53, 53, 53),
                                                                fontSize: 18,
                                                                letterSpacing: -0.3,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.left,
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 177,
                                                        margin: EdgeInsets.only(top: 17),
                                                        child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    right: 0,
                                                                    bottom: 0,
                                                                    child: Container(
                                                                        height: 177,
                                                                        child: Stack(
                                                                            alignment: Alignment.center,
                                                                            children: [
                                                                                Positioned(
                                                                                    left: 0,
                                                                                    right: 0,
                                                                                    child: Container(
                                                                                        height: 177,
                                                                                        decoration: BoxDecoration(
                                                                                            boxShadow: [
                                                                                                BoxShadow(
                                                                                                    color: Color.fromARGB(13, 0, 0, 0),
                                                                                                    offset: Offset(0, 20),
                                                                                                    blurRadius: 30,
                                                                                                ),
                                                                                            ],
                                                                                        ),
                                                                                        child: Image.asset(
                                                                                            "assets/images/image-4.png",
                                                                                            fit: BoxFit.none,
                                                                                        ),
                                                                                    ),
                                                                                ),
                                                                                Positioned(
                                                                                    left: 0,
                                                                                    right: 0,
                                                                                    child: Opacity(
                                                                                        opacity: 0.49,
                                                                                        child: Container(
                                                                                            height: 177,
                                                                                            decoration: BoxDecoration(
                                                                                                gradient: LinearGradient(
                                                                                                    begin: Alignment(0.94, -0.12),
                                                                                                    end: Alignment(0.59, 0.87),
                                                                                                    stops: [
                                                                                                        0,
                                                                                                        1,
                                                                                                    ],
                                                                                                    colors: [
                                                                                                        Colors.transparent,
                                                                                                        Color.fromARGB(236, 24, 30, 39),
                                                                                                    ],
                                                                                                ),
                                                                                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                                                                            ),
                                                                                            child: Container(),
                                                                                        ),
                                                                                    ),
                                                                                ),
                                                                                Positioned(
                                                                                    left: 10,
                                                                                    right: 60,
                                                                                    bottom: 12,
                                                                                    child: Text(
                                                                                        "Add Story",
                                                                                        style: TextStyle(
                                                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                                                            fontSize: 10,
                                                                                            letterSpacing: 0.17,
                                                                                            fontFamily: "",
                                                                                        ),
                                                                                        textAlign: TextAlign.left,
                                                                                    ),
                                                                                ),
                                                                            ],
                                                                        ),
                                                                    ),
                                                                ),
                                                                Positioned(
                                                                    child: Container(
                                                                        width: 48,
                                                                        height: 48,
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromARGB(89, 158, 158, 158),
                                                                            boxShadow: [
                                                                                BoxShadow(
                                                                                    color: Color.fromARGB(26, 0, 0, 0),
                                                                                    offset: Offset(0, 6),
                                                                                    blurRadius: 6,
                                                                                ),
                                                                            ],
                                                                            borderRadius: BorderRadius.all(Radius.circular(24)),
                                                                        ),
                                                                        child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                            children: [
                                                                                Container(
                                                                                    height: 24,
                                                                                    margin: EdgeInsets.symmetric(horizontal: 12),
                                                                                    child: Image.asset(
                                                                                        "assets/images/icon-4.png",
                                                                                        fit: BoxFit.none,
                                                                                    ),
                                                                                ),
                                                                            ],
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
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 177,
                                            margin: EdgeInsets.only(left: 16, top: 39, right: 16),
                                            child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                    Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        child: Container(
                                                            height: 177,
                                                            decoration: BoxDecoration(
                                                                boxShadow: [
                                                                    BoxShadow(
                                                                        color: Color.fromARGB(13, 0, 0, 0),
                                                                        offset: Offset(0, 20),
                                                                        blurRadius: 30,
                                                                    ),
                                                                ],
                                                            ),
                                                            child: Image.asset(
                                                                "assets/images/image-6.png",
                                                                fit: BoxFit.none,
                                                            ),
                                                        ),
                                                    ),
                                                    Positioned(
                                                        left: 0,
                                                        right: 0,
                                                        child: Opacity(
                                                            opacity: 0.4,
                                                            child: Container(
                                                                height: 177,
                                                                decoration: BoxDecoration(
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment(0.87, -0.03),
                                                                        end: Alignment(0.59, 0.78),
                                                                        stops: [
                                                                            0,
                                                                            1,
                                                                        ],
                                                                        colors: [
                                                                            Colors.transparent,
                                                                            Color.fromARGB(255, 24, 30, 39),
                                                                        ],
                                                                    ),
                                                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                                                ),
                                                                child: Container(),
                                                            ),
                                                        ),
                                                    ),
                                                    Positioned(
                                                        left: 10,
                                                        right: 14,
                                                        bottom: 10,
                                                        child: Container(
                                                            height: 28,
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                children: [
                                                                    Container(
                                                                        margin: EdgeInsets.only(right: 51),
                                                                        child: Text(
                                                                            "Christina",
                                                                            style: TextStyle(
                                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                                                fontSize: 10,
                                                                                letterSpacing: 0.17,
                                                                                fontFamily: "",
                                                                            ),
                                                                            textAlign: TextAlign.left,
                                                                        ),
                                                                    ),
                                                                    Container(
                                                                        margin: EdgeInsets.only(top: 2, right: 64),
                                                                        child: Text(
                                                                            "Nancy",
                                                                            style: TextStyle(
                                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                                                fontSize: 10,
                                                                                letterSpacing: 0.17,
                                                                                fontFamily: "",
                                                                            ),
                                                                            textAlign: TextAlign.left,
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 212,
                                            margin: EdgeInsets.only(left: 16, top: 4),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Align(
                                                        alignment: Alignment.topRight,
                                                        child: Container(
                                                            margin: EdgeInsets.only(right: 48),
                                                            child: Text(
                                                                "See all",
                                                                style: TextStyle(
                                                                    color: Color.fromARGB(255, 154, 154, 154),
                                                                    fontSize: 12,
                                                                    fontFamily: "",
                                                                ),
                                                                textAlign: TextAlign.left,
                                                            ),
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 177,
                                                        margin: EdgeInsets.only(top: 20),
                                                        child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    right: 0,
                                                                    child: Container(
                                                                        height: 177,
                                                                        decoration: BoxDecoration(
                                                                            boxShadow: [
                                                                                BoxShadow(
                                                                                    color: Color.fromARGB(13, 0, 0, 0),
                                                                                    offset: Offset(0, 20),
                                                                                    blurRadius: 30,
                                                                                ),
                                                                            ],
                                                                        ),
                                                                        child: Image.asset(
                                                                            "assets/images/image-6.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                                Positioned(
                                                                    left: 0,
                                                                    right: 0,
                                                                    child: Opacity(
                                                                        opacity: 0.4,
                                                                        child: Container(
                                                                            height: 177,
                                                                            decoration: BoxDecoration(
                                                                                gradient: LinearGradient(
                                                                                    begin: Alignment(0.87, -0.03),
                                                                                    end: Alignment(0.59, 0.78),
                                                                                    stops: [
                                                                                        0,
                                                                                        1,
                                                                                    ],
                                                                                    colors: [
                                                                                        Colors.transparent,
                                                                                        Color.fromARGB(255, 24, 30, 39),
                                                                                    ],
                                                                                ),
                                                                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                                                            ),
                                                                            child: Container(),
                                                                        ),
                                                                    ),
                                                                ),
                                                                Positioned(
                                                                    left: 10,
                                                                    right: 14,
                                                                    bottom: 10,
                                                                    child: Container(
                                                                        height: 28,
                                                                        child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                            children: [
                                                                                Container(
                                                                                    margin: EdgeInsets.only(right: 41),
                                                                                    child: Text(
                                                                                        "Sadia Jaha",
                                                                                        style: TextStyle(
                                                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                                                            fontSize: 10,
                                                                                            letterSpacing: 0.17,
                                                                                            fontFamily: "",
                                                                                        ),
                                                                                        textAlign: TextAlign.left,
                                                                                    ),
                                                                                ),
                                                                                Container(
                                                                                    margin: EdgeInsets.only(top: 2, right: 68),
                                                                                    child: Text(
                                                                                        "Prova",
                                                                                        style: TextStyle(
                                                                                            color: Color.fromARGB(255, 255, 255, 255),
                                                                                            fontSize: 10,
                                                                                            letterSpacing: 0.17,
                                                                                            fontFamily: "",
                                                                                        ),
                                                                                        textAlign: TextAlign.left,
                                                                                    ),
                                                                                ),
                                                                            ],
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
                        Container(
                            height: 122,
                            margin: EdgeInsets.only(left: 16, top: 24, right: 1),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 122,
                                            margin: EdgeInsets.only(right: 16),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                            "Active",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 53, 53, 53),
                                                                fontSize: 18,
                                                                letterSpacing: -0.3,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.left,
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 82,
                                                        margin: EdgeInsets.only(left: 4, top: 19),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Container(
                                                                    height: 59,
                                                                    child: Stack(
                                                                        alignment: Alignment.center,
                                                                        children: [
                                                                            Positioned(
                                                                                left: 0,
                                                                                top: 0,
                                                                                right: 0,
                                                                                child: Container(
                                                                                    height: 59,
                                                                                    child: Image.asset(
                                                                                        "assets/images/image-5.png",
                                                                                        fit: BoxFit.none,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                            Positioned(
                                                                                top: 1,
                                                                                right: 2,
                                                                                child: Container(
                                                                                    width: 14,
                                                                                    height: 13,
                                                                                    child: Image.asset(
                                                                                        "assets/images/active-3.png",
                                                                                        fit: BoxFit.none,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                    margin: EdgeInsets.symmetric(horizontal: 9),
                                                                    child: Text(
                                                                        "Jabeda",
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(255, 64, 64, 64),
                                                                            fontSize: 12,
                                                                            letterSpacing: 0.2,
                                                                            fontFamily: "",
                                                                        ),
                                                                        textAlign: TextAlign.center,
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 82,
                                            margin: EdgeInsets.only(left: 16, top: 40, right: 16),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Container(
                                                        height: 59,
                                                        child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    right: 0,
                                                                    child: Container(
                                                                        height: 59,
                                                                        child: Image.asset(
                                                                            "assets/images/image-5.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                                Positioned(
                                                                    top: 1,
                                                                    right: 2,
                                                                    child: Container(
                                                                        width: 14,
                                                                        height: 13,
                                                                        child: Image.asset(
                                                                            "assets/images/active-3.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                                                        child: Text(
                                                            "Charls",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 64, 64, 64),
                                                                fontSize: 12,
                                                                letterSpacing: 0.2,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 82,
                                            margin: EdgeInsets.only(left: 16, top: 40, right: 16),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Container(
                                                        height: 59,
                                                        child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    right: 0,
                                                                    child: Container(
                                                                        height: 59,
                                                                        child: Image.asset(
                                                                            "assets/images/image-5.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                                Positioned(
                                                                    top: 1,
                                                                    right: 2,
                                                                    child: Container(
                                                                        width: 14,
                                                                        height: 13,
                                                                        child: Image.asset(
                                                                            "assets/images/active-3.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 1),
                                                        child: Text(
                                                            "Nancy",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 64, 64, 64),
                                                                fontSize: 12,
                                                                letterSpacing: 0.2,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 82,
                                            margin: EdgeInsets.only(left: 16, top: 40, right: 16),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Container(
                                                        height: 59,
                                                        child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                                Positioned(
                                                                    left: 0,
                                                                    top: 0,
                                                                    right: 0,
                                                                    child: Container(
                                                                        height: 59,
                                                                        child: Image.asset(
                                                                            "assets/images/image-5.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                                Positioned(
                                                                    top: 1,
                                                                    right: 2,
                                                                    child: Container(
                                                                        width: 14,
                                                                        height: 13,
                                                                        child: Image.asset(
                                                                            "assets/images/active-3.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                        margin: EdgeInsets.only(left: 12, right: 12, bottom: 1),
                                                        child: Text(
                                                            "Sadia",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 64, 64, 64),
                                                                fontSize: 12,
                                                                letterSpacing: 0.2,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: 118,
                                            margin: EdgeInsets.only(left: 16, top: 4),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Align(
                                                        alignment: Alignment.topRight,
                                                        child: Container(
                                                            margin: EdgeInsets.only(right: 14),
                                                            child: Text(
                                                                "See all",
                                                                style: TextStyle(
                                                                    color: Color.fromARGB(255, 154, 154, 154),
                                                                    fontSize: 12,
                                                                    fontFamily: "",
                                                                ),
                                                                textAlign: TextAlign.left,
                                                            ),
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 82,
                                                        margin: EdgeInsets.only(top: 21),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Container(
                                                                    height: 59,
                                                                    child: Stack(
                                                                        alignment: Alignment.center,
                                                                        children: [
                                                                            Positioned(
                                                                                left: 0,
                                                                                top: 0,
                                                                                right: 0,
                                                                                child: Container(
                                                                                    height: 59,
                                                                                    child: Image.asset(
                                                                                        "assets/images/image-5.png",
                                                                                        fit: BoxFit.none,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                            Positioned(
                                                                                top: 1,
                                                                                right: 2,
                                                                                child: Container(
                                                                                    width: 14,
                                                                                    height: 13,
                                                                                    child: Image.asset(
                                                                                        "assets/images/active-3.png",
                                                                                        fit: BoxFit.none,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 1),
                                                                    child: Text(
                                                                        "Prova",
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(255, 64, 64, 64),
                                                                            fontSize: 12,
                                                                            letterSpacing: 0.2,
                                                                            fontFamily: "",
                                                                        ),
                                                                        textAlign: TextAlign.center,
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
                        Spacer(),
                        Container(
                            height: 270,
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                    Positioned(
                                        left: 16,
                                        right: 16,
                                        bottom: 9,
                                        child: Container(
                                            height: 261,
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Container(
                                                        height: 21,
                                                        child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Text(
                                                                        "Recent Chat",
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(255, 53, 53, 53),
                                                                            fontSize: 18,
                                                                            letterSpacing: -0.3,
                                                                            fontFamily: "",
                                                                        ),
                                                                        textAlign: TextAlign.left,
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        margin: EdgeInsets.only(top: 4),
                                                                        child: Text(
                                                                            "See all",
                                                                            style: TextStyle(
                                                                                color: Color.fromARGB(255, 154, 154, 154),
                                                                                fontSize: 12,
                                                                                fontFamily: "",
                                                                            ),
                                                                            textAlign: TextAlign.left,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 71,
                                                        margin: EdgeInsets.only(top: 19),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Container(
                                                                    height: 66,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                                    ),
                                                                    child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                        children: [
                                                                            Align(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Container(
                                                                                    width: 50,
                                                                                    height: 50,
                                                                                    margin: EdgeInsets.only(left: 8),
                                                                                    child: Stack(
                                                                                        alignment: Alignment.centerRight,
                                                                                        children: [
                                                                                            Positioned(
                                                                                                left: 0,
                                                                                                right: 0,
                                                                                                child: Container(
                                                                                                    height: 51,
                                                                                                    child: Image.asset(
                                                                                                        "assets/images/image-8.png",
                                                                                                        fit: BoxFit.none,
                                                                                                    ),
                                                                                                ),
                                                                                            ),
                                                                                            Positioned(
                                                                                                top: 0,
                                                                                                right: 0,
                                                                                                child: Container(
                                                                                                    width: 14,
                                                                                                    height: 13,
                                                                                                    child: Image.asset(
                                                                                                        "assets/images/active-3.png",
                                                                                                        fit: BoxFit.none,
                                                                                                    ),
                                                                                                ),
                                                                                            ),
                                                                                        ],
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                            Container(
                                                                                width: 155,
                                                                                margin: EdgeInsets.only(left: 16, top: 15, bottom: 1),
                                                                                child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                    children: [
                                                                                        Align(
                                                                                            alignment: Alignment.topLeft,
                                                                                            child: Text(
                                                                                                "Topon Chowdhury",
                                                                                                style: TextStyle(
                                                                                                    color: Color.fromARGB(255, 38, 166, 198),
                                                                                                    fontSize: 12,
                                                                                                    letterSpacing: 0.46,
                                                                                                    fontFamily: "",
                                                                                                ),
                                                                                                textAlign: TextAlign.left,
                                                                                            ),
                                                                                        ),
                                                                                        Spacer(),
                                                                                        Align(
                                                                                            alignment: Alignment.topLeft,
                                                                                            child: Container(
                                                                                                width: 155,
                                                                                                child: Text(
                                                                                                    "Yeah. that's what I'm saying",
                                                                                                    style: TextStyle(
                                                                                                        color: Color.fromARGB(255, 64, 64, 64),
                                                                                                        fontSize: 12,
                                                                                                        fontFamily: "",
                                                                                                    ),
                                                                                                    textAlign: TextAlign.left,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),
                                                                            Spacer(),
                                                                            Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Container(
                                                                                    width: 49,
                                                                                    height: 35,
                                                                                    margin: EdgeInsets.only(top: 16, right: 8),
                                                                                    child: Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                        children: [
                                                                                            Align(
                                                                                                alignment: Alignment.topRight,
                                                                                                child: Text(
                                                                                                    "10:43 PM",
                                                                                                    style: TextStyle(
                                                                                                        color: Color.fromARGB(255, 151, 162, 164),
                                                                                                        fontSize: 10,
                                                                                                        letterSpacing: 0.38,
                                                                                                        fontFamily: "",
                                                                                                    ),
                                                                                                    textAlign: TextAlign.right,
                                                                                                ),
                                                                                            ),
                                                                                            Align(
                                                                                                alignment: Alignment.topRight,
                                                                                                child: Container(
                                                                                                    width: 16,
                                                                                                    height: 16,
                                                                                                    margin: EdgeInsets.only(top: 7),
                                                                                                    decoration: BoxDecoration(
                                                                                                        gradient: LinearGradient(
                                                                                                            begin: Alignment(0.86, 0.14),
                                                                                                            end: Alignment(0.12, 1),
                                                                                                            stops: [
                                                                                                                0,
                                                                                                                1,
                                                                                                            ],
                                                                                                            colors: [
                                                                                                                Color.fromARGB(255, 26, 204, 180),
                                                                                                                Color.fromARGB(255, 41, 155, 203),
                                                                                                            ],
                                                                                                        ),
                                                                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                                                                    ),
                                                                                                    child: Column(
                                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                                        children: [
                                                                                                            Container(
                                                                                                                margin: EdgeInsets.only(left: 6, right: 4),
                                                                                                                child: Text(
                                                                                                                    "2",
                                                                                                                    style: TextStyle(
                                                                                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                                                                                        fontSize: 8,
                                                                                                                        fontFamily: "",
                                                                                                                    ),
                                                                                                                    textAlign: TextAlign.left,
                                                                                                                ),
                                                                                                            ),
                                                                                                        ],
                                                                                                    ),
                                                                                                ),
                                                                                            ),
                                                                                        ],
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                    height: 1,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 233, 233, 233),
                                                                    ),
                                                                    child: Container(),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Container(
                                                        height: 71,
                                                        margin: EdgeInsets.only(top: 4),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Container(
                                                                    height: 66,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                                    ),
                                                                    child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            Container(
                                                                                width: 51,
                                                                                height: 52,
                                                                                margin: EdgeInsets.only(left: 8, top: 7),
                                                                                child: Stack(
                                                                                    alignment: Alignment.center,
                                                                                    children: [
                                                                                        Positioned(
                                                                                            left: 0,
                                                                                            child: Container(
                                                                                                width: 51,
                                                                                                height: 51,
                                                                                                child: Image.asset(
                                                                                                    "assets/images/image-10.png",
                                                                                                    fit: BoxFit.none,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                        Positioned(
                                                                                            left: 37,
                                                                                            top: 0,
                                                                                            child: Container(
                                                                                                width: 14,
                                                                                                height: 13,
                                                                                                child: Image.asset(
                                                                                                    "assets/images/active-2.png",
                                                                                                    fit: BoxFit.none,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                        Positioned(
                                                                                            left: 41,
                                                                                            top: 4,
                                                                                            child: Container(
                                                                                                width: 6,
                                                                                                height: 6,
                                                                                                child: Image.asset(
                                                                                                    "assets/images/icon-5.png",
                                                                                                    fit: BoxFit.none,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),
                                                                            Container(
                                                                                width: 97,
                                                                                height: 35,
                                                                                margin: EdgeInsets.only(left: 15, top: 15),
                                                                                child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                    children: [
                                                                                        Align(
                                                                                            alignment: Alignment.topLeft,
                                                                                            child: Text(
                                                                                                "Maria Jane",
                                                                                                style: TextStyle(
                                                                                                    color: Color.fromARGB(255, 38, 166, 198),
                                                                                                    fontSize: 12,
                                                                                                    letterSpacing: 0.46,
                                                                                                    fontFamily: "",
                                                                                                ),
                                                                                                textAlign: TextAlign.left,
                                                                                            ),
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: Alignment.topLeft,
                                                                                            child: Container(
                                                                                                margin: EdgeInsets.only(top: 5),
                                                                                                child: Text(
                                                                                                    "are you there ???",
                                                                                                    style: TextStyle(
                                                                                                        color: Color.fromARGB(255, 121, 121, 121),
                                                                                                        fontSize: 12,
                                                                                                        fontFamily: "",
                                                                                                    ),
                                                                                                    textAlign: TextAlign.left,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),
                                                                            Spacer(),
                                                                            Container(
                                                                                margin: EdgeInsets.only(top: 16, right: 8),
                                                                                child: Text(
                                                                                    "10:24 PM",
                                                                                    style: TextStyle(
                                                                                        color: Color.fromARGB(255, 151, 162, 164),
                                                                                        fontSize: 10,
                                                                                        letterSpacing: 0.38,
                                                                                        fontFamily: "",
                                                                                    ),
                                                                                    textAlign: TextAlign.right,
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                    height: 1,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 233, 233, 233),
                                                                    ),
                                                                    child: Container(),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                        height: 71,
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Container(
                                                                    height: 66,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                                    ),
                                                                    child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            Container(
                                                                                width: 51,
                                                                                height: 52,
                                                                                margin: EdgeInsets.only(left: 8, top: 7),
                                                                                child: Stack(
                                                                                    alignment: Alignment.center,
                                                                                    children: [
                                                                                        Positioned(
                                                                                            left: 0,
                                                                                            child: Container(
                                                                                                width: 51,
                                                                                                height: 51,
                                                                                                child: Image.asset(
                                                                                                    "assets/images/image-8.png",
                                                                                                    fit: BoxFit.none,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                        Positioned(
                                                                                            left: 37,
                                                                                            top: 0,
                                                                                            child: Container(
                                                                                                width: 14,
                                                                                                height: 13,
                                                                                                child: Image.asset(
                                                                                                    "assets/images/active.png",
                                                                                                    fit: BoxFit.none,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),
                                                                            Container(
                                                                                width: 126,
                                                                                height: 35,
                                                                                margin: EdgeInsets.only(left: 15, top: 15),
                                                                                child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                    children: [
                                                                                        Align(
                                                                                            alignment: Alignment.topLeft,
                                                                                            child: Text(
                                                                                                "Tamanna Sadh",
                                                                                                style: TextStyle(
                                                                                                    color: Color.fromARGB(255, 38, 166, 198),
                                                                                                    fontSize: 12,
                                                                                                    letterSpacing: 0.46,
                                                                                                    fontFamily: "",
                                                                                                ),
                                                                                                textAlign: TextAlign.left,
                                                                                            ),
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: Alignment.topLeft,
                                                                                            child: Container(
                                                                                                margin: EdgeInsets.only(top: 5),
                                                                                                child: Text(
                                                                                                    "i like to work with you.",
                                                                                                    style: TextStyle(
                                                                                                        color: Color.fromARGB(255, 121, 121, 121),
                                                                                                        fontSize: 12,
                                                                                                        fontFamily: "",
                                                                                                    ),
                                                                                                    textAlign: TextAlign.left,
                                                                                                ),
                                                                                            ),
                                                                                        ),
                                                                                    ],
                                                                                ),
                                                                            ),
                                                                            Spacer(),
                                                                            Container(
                                                                                margin: EdgeInsets.only(top: 16, right: 8),
                                                                                child: Text(
                                                                                    "9:12 PM",
                                                                                    style: TextStyle(
                                                                                        color: Color.fromARGB(255, 151, 162, 164),
                                                                                        fontSize: 10,
                                                                                        letterSpacing: 0.38,
                                                                                        fontFamily: "",
                                                                                    ),
                                                                                    textAlign: TextAlign.right,
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Container(
                                                                    height: 1,
                                                                    decoration: BoxDecoration(
                                                                        color: Color.fromARGB(255, 233, 233, 233),
                                                                    ),
                                                                    child: Container(),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),
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
                                            child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                    Positioned(
                                                        top: 17,
                                                        child: Container(
                                                            width: 20,
                                                            height: 17,
                                                            child: Image.asset(
                                                                "assets/images/story-2.png",
                                                                fit: BoxFit.none,
                                                            ),
                                                        ),
                                                    ),
                                                    Positioned(
                                                        left: 33,
                                                        top: 16,
                                                        right: 37,
                                                        bottom: 8,
                                                        child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                                            children: [
                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        width: 18,
                                                                        height: 18,
                                                                        child: Image.asset(
                                                                            "assets/images/home-2.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                                Container(
                                                                    width: 149,
                                                                    margin: EdgeInsets.only(left: 55),
                                                                    child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                        children: [
                                                                            Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Container(
                                                                                    width: 18,
                                                                                    height: 18,
                                                                                    child: Image.asset(
                                                                                        "assets/images/chat-2.png",
                                                                                        fit: BoxFit.none,
                                                                                    ),
                                                                                ),
                                                                            ),
                                                                            Spacer(),
                                                                            Align(
                                                                                alignment: Alignment.topCenter,
                                                                                child: Container(
                                                                                    width: 135,
                                                                                    height: 5,
                                                                                    decoration: BoxDecoration(
                                                                                        color: Color.fromARGB(255, 0, 0, 0),
                                                                                        borderRadius: BorderRadius.all(Radius.circular(2.5)),
                                                                                    ),
                                                                                    child: Container(),
                                                                                ),
                                                                            ),
                                                                        ],
                                                                    ),
                                                                ),
                                                                Spacer(),
                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        width: 19,
                                                                        height: 16,
                                                                        margin: EdgeInsets.only(top: 1, right: 53),
                                                                        child: Image.asset(
                                                                            "assets/images/friends.png",
                                                                            fit: BoxFit.none,
                                                                        ),
                                                                    ),
                                                                ),
                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Container(
                                                                        width: 17,
                                                                        height: 17,
                                                                        margin: EdgeInsets.only(top: 1),
                                                                        child: Image.asset(
                                                                            "assets/images/profile-2.png",
                                                                            fit: BoxFit.none,
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
                    ],
                ),
            ),
        );
    }

}
