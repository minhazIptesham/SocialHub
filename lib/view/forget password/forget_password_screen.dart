import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/res/component/round_button.dart';
import 'package:social_hub/res/fonts.dart';
import 'package:social_hub/view/forget%20password/forgot_component/forgot_controller.dart';
import 'package:social_hub/view/login/login_component/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  @override

  //dispose method for disposing this page...
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //using mediaQuery to work dynamically...
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * .05,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            //HeadLine & title...
            Text(
              'Forgot password?',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontFamily: AppFonts.sfProDisplayMedium),
            ),
            Text(
              'Enter the email address associated\nwith your account.',
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
                padding: EdgeInsets.only(top: size.height * .12),
                child: Column(
                  children: [
                    TextFieldSignIn(
                      myController: emailController,
                      focusNode: emailFocusNode,
                      formFieldSetter: (value) {},
                      formFieldValidator: (value) {
                        return value.isEmpty ? 'Enter your email' : null;
                      },
                      textInputType: TextInputType.emailAddress,
                      hint: 'Email',
                      obscureText: false,
                      enable: true,
                    ),
                  ],
                ),
              ),
            ),
            //click button
            ChangeNotifierProvider(
              create: (_) => ForgotController(),
              child: Consumer<ForgotController>(
                  builder: (context, provider, child) {
                return RoundButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      provider.forgotPassword(emailController.text, context);
                    }
                  },
                  title: "Send",
                  color: AppColors.primaryMaterialColor,
                  loading: provider.loading,
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
