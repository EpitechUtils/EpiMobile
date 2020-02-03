import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/dashboard/categoryButton.dart';

class CategoryButtonsList extends StatefulWidget {

    final int page;
    final Function changePageCallback;

    CategoryButtonsList({@required this.page, @required this.changePageCallback});

    @override
    _CategoryButtonsList createState() => _CategoryButtonsList();
}

class _CategoryButtonsList extends State<CategoryButtonsList> {

    /// Build and render widget
    @override
    Widget build(BuildContext context) {
        return Container(
            height: 40,
            child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[

                        Padding(
                            padding: const EdgeInsets.only(left: 20, right: 5),
                            child: CategoryButton(
                                currentPage: this.widget.page,
                                index: 0,
                                icon: Icons.access_alarm,
                                text: "Rappels",
                                onPressed: () {
                                    this.widget.changePageCallback(0);
                                },
                            ),
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CategoryButton(
                                currentPage: this.widget.page,
                                index: 1,
                                icon: Icons.menu,
                                text: "Projets",
                                onPressed: () {
                                    this.widget.changePageCallback(1);
                                },
                            ),
                        ),

                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: CategoryButton(
                                currentPage: this.widget.page,
                                index: 2,
                                icon: Icons.dashboard,
                                text: "Modules",
                                onPressed: () {
                                    this.widget.changePageCallback(2);
                                },
                            ),
                        ),

                        Padding(
                            padding: const EdgeInsets.only(left: 5, right: 20),
                            child: CategoryButton(
                                currentPage: this.widget.page,
                                index: 3,
                                icon: Icons.check,
                                text: "Dernières notes",
                                onPressed: () {
                                    this.widget.changePageCallback(3);
                                },
                            ),
                        ),

                    ],
                ),
            ),
        );
    }
}