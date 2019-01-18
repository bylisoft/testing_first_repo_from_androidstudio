import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.red[800],
        primaryColor: Colors.yellow,
        primaryIconTheme: IconThemeData(
          color: Colors.blueAccent
        ),
        iconTheme: IconThemeData(
            color: Colors.brown
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  bool reviewsLoaded = false;

  Color flutterColor = Colors.yellow[800];

  List<String> dogs = List<String>();

  String flutterTag = "flutterTag";
  Widget flutterLogo = CircleAvatar(
    backgroundImage: AssetImage("assets/flutter.jpg"),
    radius: 40,
  );

  var pageController = PageController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
//      statusBarColor: Colors.yellow[800], //or set color with: Color(0xFF0000FF)
//    ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text('Drawer test'),
//          backgroundColor: Colors.yellow[800],
          centerTitle: true,
          elevation: 10,
        ),
        drawer: Drawer(
          
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Kontonamnet"),
                accountEmail: Text("info@mail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/flutter.jpg"),
                  radius: 40,
                ),
              ),
              ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text("Alarm",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo
                ),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.accessible),
                title: Text("b"),
                onTap: () {},
              ),
              ListTile(
                title: Text("To tab-page",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo
                  ),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => page5()));
                },
              )
            ],
          ),
        ),
        body: PageView(
          controller: pageController,
          children: <Widget>[page1(), page2(), page4()],
        ));
  }

  Widget page5(){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );

  }

  Widget page4() {
    return new Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetch();
        },
//        backgroundColor: Colors.indigo[800],
        child: Icon(Icons.refresh),
      ),
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.3, 0.6, 0.8],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[800],
              Colors.indigo[600],
              Colors.indigo[300],
              Colors.indigo[100],
            ],
          ),
        ),
        child: GridView.builder(
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: dogs.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10.0),


                child: Image.network(dogs[index], fit: BoxFit.fill),
              );
            }),
      ),
    );
  }

  fetch() async {
    final response = await http.get("https://dog.ceo/api/breeds/image/random");

    setState(() {
      dogs.add(json.decode(response.body)["message"]);
    });
  }

  fetchFive() {
    for (var i = 0; i < 5; i++) {
      fetch();
    }
  }

  Widget page3() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 3"),
//        backgroundColor: Colors.indigo[800],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
/*
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.1, 0.3, 0.6, 0.8],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[800],
              Colors.indigo[600],
              Colors.indigo[300],
              Colors.indigo[100],
            ],
          ),
        ),
*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: flutterTag,
                      child: flutterLogo,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 62, top: 62),
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 64, top: 64),
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget page2() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlutterLogo(
            size: 160,
            style: FlutterLogoStyle.horizontal,
          ),
          GestureDetector(
            onTap: () {
              if (flutterColor == Colors.indigo) {
                flutterColor = Colors.green;
              } else {
                flutterColor = Colors.indigo;
              }

              setState(() {});
            },
            child: FlutterLogo(
              size: 160,
              style: FlutterLogoStyle.horizontal,
              duration: Duration(seconds: 2),
              textColor: flutterColor,
            ),
          ),
          FlutterLogo(
            size: 160,
          ),
          FlutterLogo(
            size: 160,
          )
        ],
      ),
    );
  }

  Widget page1() {
    return Builder(
      builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                foregroundColor: Colors.indigo,
                backgroundColor: Colors.black12,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "M",
                        style: TextStyle(
                            fontSize: 30, color: Colors.indigo)),
                    TextSpan(
                        text: "B",
                        style: TextStyle(fontSize: 30, color: Colors.red))
                  ]),
                ),
              ),
              Center(child: reviewsLoaded ? Text('Marcus') : Container()),
              RaisedButton(
                child: Text('Show more'),
                elevation: 4.0,
                color: Colors.teal,
                textColor: Colors.white,
                onPressed: () {
                  showReview(context);
                  reviewsLoaded = true;
                  setState(() {});
                },
              ),
              RaisedButton(
                child: Text('Default'),
                elevation: 4.0,
                color: Colors.teal,
                textColor: Colors.white,
                onPressed: () {
                  infoDialog(context);
                  setState(() {
                    reviewsLoaded = false;
                  });
                },
              ),
              RaisedButton(
                child: Text('Snackbar'),
                elevation: 4.0,
                color: Colors.teal,
                textColor: Colors.white,
                onPressed: () {
                  showSnackbar(context);
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => page3()));
                },
                child: Hero(
                  tag: flutterTag,
                  child: flutterLogo,
                ),
              ),
              Icon(
                Icons.local_gas_station,
                size: 45.0
              )
            ],
          ),
    );
  }
}

showSnackbar(BuildContext context) {
  final snackbar = SnackBar(content: Text("Ett superbra meddelande!"));
  Scaffold.of(context).showSnackBar(snackbar);
}

Future<bool> infoDialog(context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review'),
          content: Text('Dialog-text'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

Future<bool> showReview(context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
                height: 350.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[

                    Stack(
                      children: <Widget>[
                        Container(height: 150.0),
                        Container(
                          height: 100.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              color: Colors.teal),
                        ),
                        Positioned(
                            top: 50.0,
                            left: 94.0,
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45.0),
                                border: Border.all(
                                    color: Colors.lightBlueAccent,
                                    style: BorderStyle.solid,
                                    width: 2.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: FlutterLogo(
                                  size: 10.0,
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Dialog-text',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                    SizedBox(height: 15.0),
                    FlatButton(
                        child: Center(
                          child: Text(
                            'OKAY',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.teal),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.transparent)
                  ],
                )));
      });
}
