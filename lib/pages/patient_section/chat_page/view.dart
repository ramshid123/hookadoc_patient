import 'package:doctor_app_v2/shared/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'chat_index.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.deleteAll();
    return GestureDetector(
      onTap: () => controller.state.chatInputFocusNode.unfocus(),
      child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Scaffold(
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () async => controller.update(),
              // ),
              body: ZIMKitMessageListPage(
                conversationID: 'ramshidID1234',
                conversationType: ZIMConversationType.peer,
                appBarBuilder: (context, defaultAppBar) {
                  return AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: Colors.blue[600],
                        ),
                        kWidth(20.w),
                        kText(
                          text: controller.state.name,
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.navigate_before),
                      color: Colors.black,
                      iconSize: 40.r,
                    ),
                  );
                },
                inputFocusNode: controller.state.chatInputFocusNode,
                messageItemBuilder: (context, message, defaultWidget) =>
                    GestureDetector(
                  onLongPress: () async => await controller.deleteMessage(
                      message: message, context: context),
                  child: message.info.direction == ZIMMessageDirection.send
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Get.width * 0.30,
                                right: Get.width * 0.03,
                                top: 5.h,
                                bottom: 5.h),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kText(
                                  text: message.textContent!.text,
                                  fontSize: 17,
                                ),
                                kHeight(5.h),
                                kText(
                                  text: DateFormat(DateFormat.HOUR_MINUTE)
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              message.info.timestamp)),
                                  fontSize: 12,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: Get.width * 0.33,
                                left: Get.width * 0.03,
                                top: 5.h,
                                bottom: 5.h),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kText(
                                  text: message.textContent!.text,
                                  fontSize: 17,
                                ),
                                kHeight(5.h),
                                kText(
                                  text: DateFormat(DateFormat.HOUR_MINUTE)
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              message.info.timestamp)),
                                  fontSize: 12,
                                  color: Colors.blueGrey,
                                )
                              ],
                            ),
                          ),
                        ),
                ),
                messageListLoadingBuilder: (context, defaultWidget) =>
                    Center(child: Text('Loading..')),
                showPickMediaButton: false,
                showPickFileButton: false,
                sendButtonWidget: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
                inputBackgroundDecoration:
                    BoxDecoration(color: Colors.transparent),
                inputDecoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    hintText: 'Type something..',
                    hintStyle: TextStyle(color: Colors.blueGrey)),
              ),
            );
          }),
    );
  }
}
