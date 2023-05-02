import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_hub/utils/services/session_manager.dart';
import 'package:social_hub/view/chat/massege_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  //Database reference..
  DatabaseReference reference = FirebaseDatabase.instance.ref.call('UserName');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FirebaseAnimatedList(
            query: reference,
            itemBuilder: (context, snapshot, animation, index) {
              if (SessionController().userId.toString() ==
                  snapshot.child('uid').value.toString()) {
                return Container();
              } else {
                return Card(
                  child: ListTile(
                    onTap: (){
                      PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MessageScreen(
                            name: snapshot.child('userName').value.toString(),
                            image: snapshot.child('email').value.toString(),
                            email: snapshot.child('email').value.toString(),
                            receiverID: snapshot.child('uid').value.toString(),
                          ),
                        withNavBar: false,
                      );
                    },
                    title: Text(snapshot.child('userName').value.toString()),
                    subtitle: Text(snapshot.child('email').value.toString()),
                    leading: Container(
                      child: snapshot.child('image').value.toString() == ""
                          ? const Icon(Icons.person)
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.child('image').toString()),
                            ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
