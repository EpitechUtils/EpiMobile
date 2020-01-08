import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/dashboard/categoryButton.dart';

class CategoryButtonsList extends StatefulWidget {

    final int page;

    CategoryButtonsList({@required this.page});

    @override
    _CategoryButtonsList createState() => _CategoryButtonsList();
}

class _CategoryButtonsList extends State<CategoryButtonsList> {

    /// Build and render widget
    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

                CategoryButton(
                    currentPage: this.widget.page,
                    index: 0,
                    icon: Icons.access_alarm,
                    text: "En cours"
                ),

                CategoryButton(
                    currentPage: this.widget.page,
                    index: 1,
                    icon: Icons.check,
                    text: "Projets"
                ),

                CategoryButton(
                    currentPage: this.widget.page,
                    index: 2,
                    icon: Icons.dashboard,
                    text: "Modules"
                ),

                CategoryButton(
                    currentPage: this.widget.page,
                    index: 3,
                    icon: Icons.notifications_active,
                    text: "Notifications"
                ),

            ],
        );
    }
}