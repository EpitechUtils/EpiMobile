import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {

    final int currentPage;
    final int index;
    final IconData icon;
    final String text;

    CategoryButton({
        @required this.currentPage,
        @required this.index,
        @required this.icon,
        @required this.text
    });

    @override
    Widget build(BuildContext context) {
        if (this.currentPage == this.index) {
            return RaisedButton(
                disabledColor: Colors.white,
                onPressed: null,
                child: Row(
                    children: <Widget>[
                        Icon(this.icon,
                            color: Colors.black,
                            size: 20,
                        ),

                        SizedBox(width: 3),

                        Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(this.text,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20
                                )
                            ),
                        )
                    ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                )
            );
        }

        // Not selectionned
        return OutlineButton(
            color: Colors.white,
            child: Icon(this.icon,
                color: Colors.white,
                size: 20,
            ),
            onPressed: () {
                debugPrint("ok boomer");
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)
            )
        );
    }
}