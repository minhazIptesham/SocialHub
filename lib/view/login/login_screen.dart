import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/res/component/round_button.dart';
import 'package:social_hub/res/fonts.dart';
import 'package:social_hub/utils/routes/route_name.dart';
import 'package:social_hub/utils/utility.dart';
import 'package:social_hub/view/login/login_component/login_service.dart';
import 'package:social_hub/view/login/login_component/text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  @override

  //dispose method for disposing this page...
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            create: (_) => LogInController(),
            child: Consumer<LogInController>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .1,
                      ),

                      //HeadLine & title...
                      Text(
                        'Good to see you again',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontFamily: AppFonts.sfProDisplayMedium),
                      ),
                      Text(
                        'Hey, Enter your details to get sign in to connect your account',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontFamily: AppFonts.sfProDisplayRegular),
                        textAlign: TextAlign.center,
                      ),

                      //textField...
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height * .15),
                          child: Column(
                            children: [
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
                                obscureText: false,
                                enable: true,
                              ),
                            ],
                          ),
                        ),
                      ),

                      //forget password....
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, RouteName.forgetPassword);
                          },
                          child: Text('Forget password?',style: Theme.of(context).textTheme.titleSmall!.copyWith(decoration: TextDecoration.underline,),),
                        ),
                      ),

                      //click button
                      RoundButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            provider.logIn(emailController.text, passwordController.text, context);
                          }
                        },
                        title: "Log In",
                        color: AppColors.primaryMaterialColor,
                        loading: false,
                      ),
                      Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                            text: "Don't have an account?\n",
                            style: const TextStyle(color: Colors.black54),
                            children: [
                              TextSpan(
                                  text: " Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.lightBlue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, RouteName.signUpScreen);
                                    }),
                            ]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
