import 'package:flutter/cupertino.dart';

/// HeaderComponent class extends StatelessWidget
/// Component will draw header of page
class HeaderComponent extends StatelessWidget {
    final String title;

    /// Constructor
    HeaderComponent({Key key, @required this.title}) : super(key: key);

    /// Build and display widget
    @override
    Widget build(BuildContext context) {
        return Container(
            height: 160,
            child: Stack(
                alignment: Alignment.center,
                children: [

                    // Background
                    Container(
                        child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                                Positioned(
                                    top: -1,
                                    left: -5,
                                    right: 0,
                                    child: Image.asset("assets/images/mask-7.png",
                                        fit: BoxFit.cover,
                                    ),
                                ),
                            ],
                        ),
                    ),

                    // Text
                    Positioned(
                        left: 10,
                        top: 95,
                        child: Container(
                            height: 40,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(this.title,
                                            style: TextStyle(
                                                color: Color.fromARGB(255, 255, 255, 255),
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "NunitoSans",
                                            ),
                                            textAlign: TextAlign.left,
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    )
                ],
            ),
        );
    }
}