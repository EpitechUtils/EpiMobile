import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {

    final int currentPage;
    final int index;
    final IconData icon;
    final String text;
    final VoidCallback onPressed;

    CategoryButton({
        @required this.currentPage,
        @required this.index,
        @required this.icon,
        @required this.text,
        @required this.onPressed
    });

    @override
    Widget build(BuildContext context) {
        if (this.currentPage == this.index) {
            return RaisedButton(
                disabledColor: Colors.white,
                onPressed: null,
                autofocus: true,
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
            focusColor: Colors.white,
            splashColor: Colors.white,
            child: Row(
                children: <Widget>[
                    Icon(this.icon,
                        color: Colors.white,
                        size: 20,
                    ),

                    SizedBox(width: 3),

                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(this.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            )
                        ),
                    )
                ],
            ),
            onPressed: this.onPressed,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)
            ),
            borderSide: BorderSide(
                color: Colors.white,
                style: BorderStyle.solid,
                width: 0.8,
            ),
        );
    }
}