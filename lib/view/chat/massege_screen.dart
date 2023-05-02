import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/utils/services/session_manager.dart';
import 'package:social_hub/utils/utility.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  final String image;
  final String email;
  final String receiverID;
  const MessageScreen({Key? key,
    required this.name,
    required this.image,
    required this.email,
    required this.receiverID,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('chat');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index){
                    return Text(index.toString());
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 0.0),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: (){
                            sendMessage();
                          },
                      icon: const Icon(Icons.send)),
                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 0.0),
                      contentPadding: const EdgeInsets.all(15.00),
                      border:  const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.alertColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.textFieldDefaultBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sendMessage(){
    if(messageController.text.isEmpty){
      Utility.customSnackBar(context: context, contentType: ContentType.warning, title: 'Error', massage: 'Write a message first!');
    }else{
      final timeStrap = DateTime.now().millisecondsSinceEpoch.toString();
      reference.child(timeStrap).set({
        'isSeen' : false,
        'message' : messageController.text.toString(),
        'sender' : SessionController().userId.toString(),
        'receiver' : widget.receiverID,
        'type' : 'text',
        'time' : timeStrap.toString(),
      }).then((value){
        messageController.clear();
      });
    }
  }

}
