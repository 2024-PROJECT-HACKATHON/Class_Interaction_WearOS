import 'dart:async';
import 'package:class_interaction_wear_os/Apiurl.dart';
import 'package:class_interaction_wear_os/Opinion/Opinion.dart';
import 'package:class_interaction_wear_os/Opinion/OpinionService.dart';
import 'package:class_interaction_wear_os/Websocket/Dialogs.dart';
import 'package:class_interaction_wear_os/Websocket/MessageDTO.dart';
import 'package:class_interaction_wear_os/member/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'dart:convert';

class Websocket {
  late String classId;
  String? jwt;
  StompClient? stompClient;
  late User? user;
  dynamic unsubscribe;
  late BuildContext context;

  // late BuildContext context;
  Websocket(this.classId, this.user, this.context) {
    stompClient = stomClient(jwt, context);
    stompClient?.activate();
  }

  StompClient stomClient(String? jwt, context) {
    return StompClient(
      config: StompConfig.sockJS(
        url: '${Apiurl().url}/classroomEnter',
        onConnect: (StompFrame frame) => onConnect(frame, context),
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(const Duration(milliseconds: 2000));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
        onDisconnect: (frame) {},
        reconnectDelay: const Duration(milliseconds: 0),
        stompConnectHeaders: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        webSocketConnectHeaders: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
  }

  Future<void> onConnect(StompFrame frame, context) async {
    unsubscribe = stompClient!.subscribe(
      destination: '/sub/classroom/$classId',
      callback: (frame) async {
        Map<String, dynamic> json = jsonDecode(frame.body ?? "");
        print("수신 json:");
        print(json);
        MessageDTO message = MessageDTO.fromJson(json);
        switch (message.status) {
          case Status.OPINIONUPDATE:
            // 교수 의견 업데이트 처리
            if (user?.role == "student") {
              Provider.of<OpinionService>(context, listen: false)
                  .setOpinionList(message.opList);
              Provider.of<OpinionService>(context, listen: false)
                  .setOpinionList(message.opList);
              Provider.of<OpinionService>(context, listen: false)
                  .setOpinionSend(true);
            }

            break;
          case Status.OPINIONINITIALIZE:
            print("의견초기화");
            //의견초기화
            if (user?.role == "student") {
              Provider.of<OpinionService>(context, listen: false)
                  .setOpinionSend(true);
            }
            break;
          case Status.CLOSE:
            // 사용자에게 수업끝났다고 알림
            if (user?.role == "student") {
              await Dialogs.showErrorDialog(context, "교수님께서 수업을 종료하셨습니다 ");
              Navigator.pop(context);
            }
            break;
          default:
            print("예외문제 확인용(default switch문) ${message.status}");
            break;
        }
      },
    );
  }

  //의견 보내기
  Future<void> opinionSend(Opinion opinion) async {
    stompClient?.send(
      destination: '/pub/classroom/$classId/message',
      body: json.encode({
        'status': Status.OPINION.toString().split('.').last,
        'classId': classId,
        'opinion': opinion,
      }),
    );
  }

  //의견 초기화
  Future<void> opinionInit() async {
    stompClient?.send(
      destination: '/pub/classroom/$classId/message',
      body: json.encode({
        'status': Status.OPINIONINITIALIZE.toString().split('.').last,
        'classId': classId,
      }),
    );
  }

  //의견 수정 정보 알리기
  Future<void> sendOpinionUpdate(List<Opinion> opinion) async {
    stompClient?.send(
      destination: '/pub/classroom/$classId/message',
      body: json.encode({
        'status': Status.OPINIONUPDATE.toString().split('.').last,
        'classId': classId,
        'opinionList': opinion,
      }),
    );
  }
}
//   //연결끊기
//   void disconnect() {
//     try {
//       unsubscribe(); // 구독 취소
//       stompClient?.deactivate();
//       print('연결 끊기 완료');
//     } catch (e) {
//       print('연결 끊기 실패: $e');
//     }
//   }
// }

// unsubscribeFn(unsubscribeHeaders: {});
// client.deactivate();
