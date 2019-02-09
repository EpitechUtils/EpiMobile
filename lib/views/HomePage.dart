import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
    HomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _counter = 0;
    int _selectedIndex = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            'You have pushed the button this many times:',
                        ),
                        Text(
                            '$_counter',
                            style: Theme.of(context).textTheme.display1,
                        ),
                    ],
                ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    Navigator.pushNamed(context, '/login');
                },
                tooltip: 'Increment',
                child: Icon(Icons.directions_run),
                backgroundColor: Colors.red,
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), title: Text('Accueil')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_today), title: Text('Planning')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.people), title: Text('Profil')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), title: Text('Options')),
                ],
                currentIndex: _selectedIndex,
                fixedColor: Colors.indigo,
                onTap: _onItemTapped,
            ),
        );
    }

    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }
}
