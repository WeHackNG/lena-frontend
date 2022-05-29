import 'dart:convert';
import 'assignments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lena_frontend/courseList.dart';
import 'package:json_annotation/json_annotation.dart';
import 'course.dart';
import 'courseList.dart';



Future<CourseList> fetchCourses() async {
  final response = await http
      .get(Uri.parse('https://courses.cs.northwestern.edu/394/data/cs-courses.php'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Map<String, dynamic> courseListMap = jsonDecode(response.body);
    var courseList = CourseList.fromJson(courseListMap);
    return courseList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load CourseList');
  }
}



void main() {
  runApp(const MyApp());
  //print(fetchCourses());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lena Application',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Lena'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Future<CourseList> futureCourses;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    futureCourses = fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder<CourseList>(
        future: futureCourses,
        builder: (BuildContext context, AsyncSnapshot<CourseList> snapshot){
          return GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              children: List.generate(snapshot.data!.courses.length, (index) {
                return  Center(
                  child: Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {  // click on a course
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AssignmentPage(course: snapshot.data!.courses[index].title)),
                          );
                        },
                      child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Column(
                            children:<Widget>[
                              Text(snapshot.data!.courses[index].id),
                              Text(snapshot.data!.courses[index].title),
                              Text(snapshot.data!.courses[index].meets),
                            ],
                          ))
                    ),
                  ),
                );
            }),
          );
        },

      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




