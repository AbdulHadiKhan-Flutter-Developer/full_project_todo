import 'package:flutter/material.dart';
import 'package:todo/utils/app_constant.dart';

class TodoWidget extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final String description;
  final bool isDone;
  final Function(bool?) toggle;

  const TodoWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.onpress,
      required this.isDone,
      required this.toggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppConstant.card,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ]),
        height: 120,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: AppConstant.textPrimary,
                        fontFamily: AppConstant.primaryfonts,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      onpress();
                    },
                    child: CircleAvatar(
                      backgroundColor: AppConstant.background,
                      radius: 14,
                      child: Icon(
                        Icons.delete,
                        color: AppConstant.textPrimary,
                        size: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                        color: AppConstant.textSecondary,
                        fontFamily: AppConstant.primaryfonts,
                        fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                    value: isDone,
                    onChanged: toggle,
                    activeColor: AppConstant.primary,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
