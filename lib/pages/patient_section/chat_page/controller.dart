import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'chat_index.dart';

class ChatController extends GetxController {
  ChatController();
  final state = ChatState();
  @override
  void onInit() {
    // TODO: implement onInit
    initChatData();
    super.onInit();
  }

  void deleteAll()async{
    await ZIMKit().deleteConversation('dilhanID123', ZIMConversationType.peer);
  }

  Future deleteMessage(
      {required ZIMKitMessage message, required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete this message?'),
        actions: [
          TextButton(
              onPressed: () async {
                await ZIMKit().deleteMessage([message]);
                Get.back();
              },
              child: kText(text: 'Yes')),
          TextButton(onPressed: () => Get.back(), child: kText(text: 'No')),
        ],
      ),
    );
  }

  Future initChatData() async {
    print('starting the initChatData function');
    await ZIMKit().disconnectUser();
    await Future.delayed(Duration(seconds: 1));
    await ZIMKit().connectUser(id: 'dilhanID1234', name: 'Dilhan');
    final user = await ZIMKit().queryUser('ramshidID1234');
    state.name = user.baseInfo.userName;
    update();
    print('akgalkdjsfalkdjsal');
  }

  Future connectUser() async { 
    // await ZIMKit().disconnectUser();
    // await ZIMKit().connectUser(id: 'ramshidID123',name: 'Ramsheed');

    await ZIMKit().disconnectUser();
    await ZIMKit().connectUser(id: 'dilhanID123', name: 'Dilhan');
  }
}
