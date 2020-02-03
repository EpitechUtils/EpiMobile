import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// CustomLoader components
/// Display a loading loader
class CustomLoader extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            height: 100,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                    SizedBox(height: 20),
                    SpinKitFadingCube(
                        color: Colors.white,
                        size: 40,
                    )
                ],
            ),
        );
    }
}