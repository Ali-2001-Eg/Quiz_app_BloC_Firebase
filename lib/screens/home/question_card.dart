import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_app/common/helpers/app_icons.dart';
import 'package:firebase_app/common/widgets/icon_and_text.dart';
import 'package:firebase_app/config/themes/light_theme.dart';
import 'package:firebase_app/config/themes/ui_parameters.dart';
import 'package:firebase_app/models/question_paper_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../qeustions/questions_screen.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.model}) : super(key: key);
  final QuestionPaperModel model;
  @override
  Widget build(BuildContext context) {
    final padding = 10.w;
    return Container(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: Theme.of(context).cardColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Stack(
          // alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: CachedNetworkImage(
                        imageUrl: model.imageUrl!,
                        placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator()),
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/splash_logo.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: LightTheme.cartTitles,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(model.description),
                      ),
                      Row(
                        children: [
                          IconAndTextWidget(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: primaryRedColor.withOpacity(0.6),
                              ),
                              text: Text(
                                '${model.questionCount} questions',
                                style: LightTheme.detailsText.copyWith(
                                  color: primaryRedColor.withOpacity(0.6),
                                ),
                              )),
                          SizedBox(
                            width: 15.w,
                          ),
                          IconAndTextWidget(
                              icon: Icon(
                                Icons.timer,
                                color: primaryRedColor.withOpacity(0.6),
                              ),
                              text: Text(
                                '${(model.timeSeconds / 60).ceil()} mins',
                                style: LightTheme.detailsText.copyWith(
                                  color: primaryRedColor.withOpacity(0.6),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: -padding,
              right: -padding,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(cardBorderRadius),
                          bottomRight: Radius.circular(cardBorderRadius)),
                      color: primaryRedColor),
                  child:const Icon(Icons.wine_bar_sharp)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
