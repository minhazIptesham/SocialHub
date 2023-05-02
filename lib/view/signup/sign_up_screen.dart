import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/res/component/round_button.dart';
import 'package:social_hub/res/fonts.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/utility.dart';
import 'package:social_hub/view/login/login_component/text_field.dart';
import 'package:social_hub/view/signup/component/signup_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  @override

  //dispose method for disposing this page...
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController.dispose();
    userNameFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //using mediaQuery to work dynamically...
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * .05,
            ),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * .1,
                        ),

                        //HeadLine & title...
                        Text(
                          'Create a new account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontFamily: AppFonts.sfProDisplayMedium),
                        ),
                        Text(
                          'Sign up to start your journey with us!',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontFamily: AppFonts.sfProDisplayRegular),
                          textAlign: TextAlign.center,
                        ),

                        //textField...
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * .12),
                            child: Column(
                              children: [
                                TextFieldSignIn(
                                  myController: userNameController,
                                  focusNode: userNameFocusNode,
                                  formFieldSetter: (value) {},
                                  formFieldValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter your username'
                                        : null;
                                  },
                                  textInputType: TextInputType.emailAddress,
                                  hint: 'Username',
                                  obscureText: false,
                                  enable: true,
                                ),
                                SizedBox(height: size.height *.03,),
                                TextFieldSignIn(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  formFieldSetter: (value) {
                                    Utility.fieldFocus(context, emailFocusNode,
                                        passwordFocusNode);
                                  },
                                  formFieldValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter your email'
                                        : null;
                                  },
                                  textInputType: TextInputType.emailAddress,
                                  hint: 'Email',
                                  obscureText: false,
                                  enable: true,
                                ),
                                SizedBox(height: size.height *.03,),
                                TextFieldSignIn(
                                  myController: passwordController,
                                  focusNode: passwordFocusNode,
                                  formFieldSetter: (value) {},
                                  formFieldValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter your password'
                                        : null;
                                  },
                                  textInputType: TextInputType.emailAddress,
                                  hint: 'Password',
                                  obscureText: true,
                                  enable: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        //click button
                        RoundButton(
                          onTap: () {
                        if (_formKey.currentState!.validate()) {
                          provider.signUp(userNameController.text, emailController.text, passwordController.text,context);
                        }
                          },
                          title: "Sign Up",
                          color: AppColors.primaryMaterialColor,
                          loading: provider.loading,
                        ),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                              text: "Already have an account?\n",
                              style: const TextStyle(color: Colors.black54),
                              children: [
                                TextSpan(
                                  text: " Log In",
                                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.lightBlue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, RouteName.logInScreen);
                                }),
                              ]),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
