import 'package:flutter/cupertino.dart';

/// Custom BlueGraient builder
/// Display gradient
class GradientComponent {

    /// Build gradient color blue
    static Gradient blue() {
        return LinearGradient(
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
        );
    }

    /// Build gradient color green
    static Gradient green() {
        return LinearGradient(
            begin: Alignment(0.92, 1.1),
            end: Alignment(0.27, 0.46),
            stops: [
                0,
                1,
            ],
            colors: [
                Color.fromARGB(255, 86, 171, 47),
                Color.fromARGB(255, 168, 224, 99),
            ],
        );
    }

}
