import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/res/component/round_button.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/services/session_manager.dart';
import 'package:social_hub/utils/utility.dart';
import 'package:social_hub/view/profile/profile_component/profile_controller.dart';
import 'package:social_hub/view/profile/profile_component/profile_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('UserName');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        Text('Data is loading'),
                      ],
                    );
                  } else if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    return SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * .05,
                          ),

                          //user profile..
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * .02),
                                child: Center(
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 5,
                                        )),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: provider.image == null
                                            ? map['profile'].toString() == ""
                                                ? Icon(
                                                    Icons.person,
                                                    size: size.height * .09,
                                                  )
                                                : const Image(
                                                    image: NetworkImage(''),
                                                    fit: BoxFit.cover,
                                                  )
                                            : Image.file(
                                                File(provider.image!.path)
                                                    .absolute)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  provider.pickImage(context);
                                },
                                child: const CircleAvatar(
                                  backgroundColor:
                                      AppColors.iconBackgroundColor,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.primaryIconColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * .05,
                          ),

                          //profile data list...
                          ProfileList(
                              title: 'Name',
                              value: map['userName'],
                              iconData: const Icon(Icons.person)),
                          ProfileList(
                              title: 'Phone',
                              value: map['phone'] == ""
                                  ? '+8801712345678'
                                  : map['phone'],
                              iconData: const Icon(
                                Icons.phone,
                              )),
                          ProfileList(
                              title: 'Email',
                              value: map['email'],
                              iconData: const Icon(Icons.email)),

                          //LogOut button..
                          RoundButton(
                            title: 'Log Out',
                            onTap: () {
                              auth.signOut().then((value) {
                                Navigator.pushNamed(
                                    context, RouteName.logInScreen);
                              }).onError((error, stackTrace) {
                                Utility.customSnackBar(
                                    context: context,
                                    contentType: ContentType.failure,
                                    title: 'LogOut Failed',
                                    massage: error.toString());
                              });
                            },
                            color: AppColors.primaryMaterialColor,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Something Wrong'),
                    );
                  }
                },
              ),
            ));
          },
        ),
      ),
    );
  }
}
