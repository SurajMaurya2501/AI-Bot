import 'package:firebase_gemini_ai/model/message_model.dart';
import 'package:firebase_gemini_ai/provider/message_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:provider/provider.dart';

class FirebaseGemini {
  final gemini = Gemini.instance;
  List<MessageModel> messages = [];
  List<Content> chats = [];
  List<MessageModel> messageModel = [];
  bool showLoading = false;

  Future<void> geminiStream(List<Content> message, BuildContext context,
      ScrollController scrollController) async {
    try {
      gemini
          .streamChat(
        chats,
      )
          .listen(
        (value) {
          // print(value?.output);
          if (chats[chats.length - 1].role == "model") {
            chats[chats.length - 1] = Content(
              role: "model",
              parts: [
                Parts(
                  text:
                      "${chats[chats.length - 1].parts?.lastOrNull?.text} ${value.output}",
                ),
              ],
            );
          } else {
            chats.add(
              Content(
                role: "model",
                parts: [
                  Parts(
                    text: value?.output,
                  ),
                ],
              ),
            );
          }
          scrollToEnd(scrollController, 500);

          final provider = Provider.of<MessageProvider>(context, listen: false);
          showLoading = false;
          provider.updateWidget();
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error Occured : ${e.toString()}",
          ),
        ),
      );
    }
  }

  scrollToEnd(ScrollController scrollController, int timer) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(
          milliseconds: timer,
        ),
        curve: Curves.easeInOut,
      );
    });
  }
}
