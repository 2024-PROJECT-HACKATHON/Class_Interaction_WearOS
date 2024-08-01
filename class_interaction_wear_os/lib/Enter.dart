import 'package:flutter/material.dart';

class Enter extends StatefulWidget {
  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  labelText: 'Enter number',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // 입력된 숫자를 처리하는 로직을 여기에 추가
                  print('Entered number: ${_controller.text}');
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
