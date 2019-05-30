import 'package:flutter/material.dart';

class LoaderComponent extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Center(
                child: CircularProgressIndicator(),
            ),
        );
    }
}