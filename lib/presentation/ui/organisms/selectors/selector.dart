import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label13.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label17.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class Selector {

  void showIconMenu({
    required BuildContext context,
    required String title,
    required List<Map> options,
  }){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)
        ),
      context: context,
      builder: (BuildContext context){
          Size size = MediaQuery.of(context).size;
          return Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label17(
                        text: title,
                        color: GlobalThemeData.lightColorScheme.secondaryContainer,
                        weight: FontWeight.bold,
                        maxLines: 1
                    ).animate().fadeIn(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: GlobalThemeData.lightColorScheme.secondaryContainer,),
                    ).animate().fadeIn(),
                  ],
                ),
                Divider(color: GlobalThemeData.lightColorScheme.outline.withOpacity(0.5),).animate().fadeIn(),
                const Gap(20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                  children: [
                    ...options.map((e) => GestureDetector(
                      onTap: () {
                        if(e["widget"] != null) {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => e["widget"]));
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: GlobalThemeData.lightColorScheme.secondaryContainer, width: 0.7)
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: GlobalThemeData.lightColorScheme.onSecondaryContainer, width: 0.7)
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(300),
                                      child: Icon(
                                        e["iconData"],
                                        color: GlobalThemeData.lightColorScheme.secondaryContainer,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ),
                          const Gap(10),
                          Label10(text: e["label"], color: GlobalThemeData.lightColorScheme.secondaryContainer, weight: FontWeight.normal, maxLines: 2)
                        ],
                      ),
                    ).animate().fadeIn()),
                  ],
                ),
                const Gap(10),
              ],
            ),
          );
        }
    );
  }

  void showLabelMenu({
    required BuildContext context,
    required String title,
    required List<String> options,
    required Function(String) onSelected,
  }){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)
        ),
      context: context,
      builder: (BuildContext context){
          Size size = MediaQuery.of(context).size;
          return Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Label17(
                        text: title,
                        color: GlobalThemeData.lightColorScheme.secondaryContainer,
                        weight: FontWeight.bold,
                        maxLines: 1
                    ).animate().fadeIn(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: GlobalThemeData.lightColorScheme.secondaryContainer,),
                    ).animate().fadeIn(),
                  ],
                ),
                Divider(color: GlobalThemeData.lightColorScheme.outline.withOpacity(0.5),).animate().fadeIn(),
                const Gap(20),
                ...options.map((e) => InkWell(
                  splashColor: GlobalThemeData.lightColorScheme.secondaryContainer.withOpacity(0.1),
                  onTap: () {
                    onSelected(e);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    height: 50,
                    child: Label13(text: e, color: GlobalThemeData.lightColorScheme.secondaryContainer, weight: FontWeight.normal, maxLines: 2)
                  ),
                ).animate().fadeIn()),
                const Gap(10),
              ],
            ),
          );
        }
    );
  }

}