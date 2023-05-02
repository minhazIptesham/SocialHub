import 'package:flutter/material.dart';
import 'package:social_hub/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final color, textColor;
  final bool loading;
  final VoidCallback onTap;
  const RoundButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.color = AppColors.whiteColor,
    this.textColor = AppColors.primaryTextTextColor,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: loading ? null : onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: size.height *.02),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: loading
              ? const Center(child: CircularProgressIndicator(color: Colors.white,))
              : Center(
                  child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
        ),
      ),
    );
  }
}
