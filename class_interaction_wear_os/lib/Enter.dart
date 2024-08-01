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
          title: Center(
              child: Text('수업 입장', style: TextStyle(color: Colors.white))),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black, // 배경색을 검정으로 설정
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 10, color: Colors.white), // 텍스트 색상 변경
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0), // 라운드 처리
                  ),
                  labelText: '수업 코드를 입력하세요',
                  labelStyle: TextStyle(color: Colors.white), // 라벨 색상 변경
                  filled: true,
                  fillColor: Colors.grey[800], // 텍스트 박스 배경색 설정
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // 입력된 숫자를 처리하는 로직을 여기에 추가
                  print('Entered number: ${_controller.text}');
                },
                child: Text('수업입장',
                    style: TextStyle(fontSize: 10, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0), // 버튼 라운드 처리
                  ),
                  backgroundColor: Color(0xfffbaf01), // 버튼 배경색
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
