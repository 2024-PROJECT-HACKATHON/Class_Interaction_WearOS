import 'package:class_interaction_wear_os/Websocket/Dialogs.dart';
import 'package:class_interaction_wear_os/classroomWatch.dart';
import 'package:flutter/material.dart';

class Enter extends StatefulWidget {
  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String value = "";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.compact,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('수업 입장')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '수업숫자 입력',
                  ),
                  onChanged: (text) {
                    value = text;
                  }),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (value == "") {
                    Dialogs.showErrorDialog(context, "수업 입력");
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Classroomwatch(value)));
                },
                child: Text('Submit', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
