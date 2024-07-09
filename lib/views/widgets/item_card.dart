import 'package:akadomen/utils/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.price, required this.name});
  final int price;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 15,
        left: 15,
        child: Column(
          children: [
            Text(name,
                style: context.textTheme.displaySmall?.copyWith(
                  fontSize: 5.sp,
                  shadows: [
                    const Shadow(
                      offset: Offset(1, -1),
                      color: ColorManager.black,
                      blurRadius: 5,
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price.toString(),
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: 9.sp,
                    color: ColorManager.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(1, -1),
                        color: ColorManager.black.withOpacity(0.7),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                ),
                Text('EG',
                    style: context.textTheme.displaySmall?.copyWith(
                      fontSize: 5.sp,
                      shadows: [
                        Shadow(
                          offset: const Offset(1, -1),
                          color: ColorManager.black.withOpacity(0.7),
                          blurRadius: 5,
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}