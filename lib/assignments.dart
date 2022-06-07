import 'package:flutter/material.dart';

final List<int> entries = <int>[1, 2, 3];

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key, required this.course}) : super(key: key);


  final String course;

  @override
  State<AssignmentPage> createState() => _MyAssignmentPageState();

}

class _MyAssignmentPageState extends State<AssignmentPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.course),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Assignment ${entries[index]}')),
            );
          }
      ),
      // + button to add new assignment
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          // add a new assignment to the assignment list
          if (entries.isEmpty) entries.add(1),  // add to empty entry
          entries.add(entries.last + 1),  // increment the last added assignment
          setState(() {})  // refresh the page
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      )
    );
  }
}

