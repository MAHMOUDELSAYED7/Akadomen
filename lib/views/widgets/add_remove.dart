import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/colors.dart';

class AddAndRemoveCard extends StatelessWidget {
  const AddAndRemoveCard({
    super.key,
    this.onIncrement,
    this.onDecrement,
  });
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  @override
  Widget build(BuildContext context) {
    const white = ColorManager.white;
    const black = ColorManager.black;
    return Positioned(
      bottom: 10,
      right: 10,
      left: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 16.sp,
            width: 16.sp,
            child: FloatingActionButton(
              heroTag: UniqueKey(),
              hoverColor: white,
              splashColor: white,
              backgroundColor: white.withOpacity(0.7),
              onPressed: onIncrement,
              child: const Icon(
                Icons.add,
                color: black,
              ),
            ),
          ),
          SizedBox(
            height: 16.sp,
            width: 16.sp,
            child: FloatingActionButton(
              heroTag: UniqueKey(),
              hoverColor: white,
              splashColor: white,
              backgroundColor: white.withOpacity(0.7),
              onPressed: onDecrement,
              child: const Icon(
                Icons.remove,
                color: black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}