import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/bottomNavigation.dart';

/// Header component
/// Must be integrated in all routes
class DefaultLayout extends StatelessWidget {

    // Configure default values
    final Widget body;
    final Function floatingMethod;

    // Constructor
    DefaultLayout({@required this.body, this.floatingMethod});

    /// Build header
    @override
    Widget build(BuildContext context) {
        return BottomNavigation(
            floatingMethod: this.floatingMethod,
            child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Container(
                    child: this.body
                ),
            ),
        );
    }
}