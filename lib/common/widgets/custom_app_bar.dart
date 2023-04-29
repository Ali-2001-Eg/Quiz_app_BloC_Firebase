import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.titleWidget,
    this.onSubmitTab,
    this.title = '',
    this.showSubmit = false,
    this.leading,
  }) : super(key: key);
  final String title;
  final Widget? titleWidget;
  final bool showSubmit;
  final VoidCallback? onSubmitTab;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Positioned.fill(
            child: Center(
          child: titleWidget ??
              Center(
                child: Text(
                  title,
                  style: LightTheme.appBarText,
                ),
              ),
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showSubmit)
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: TextButton(
                    onPressed: onSubmitTab ?? () => {},
                    child: Text('Submit'.toUpperCase(),
                        style: LightTheme.countDownTimer.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold,)),
                  ),
                ),
            ],
          ),
        )
      ],
    ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 50.h);
}
