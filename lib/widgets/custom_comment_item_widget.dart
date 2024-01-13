import 'package:ecommerce_web_app/utils/theme_settings.dart';
import 'package:ecommerce_web_app/widgets/custom_icon_button_widget.dart';
import 'package:flutter/material.dart';

class CustomCommentItemWidget extends StatefulWidget {
  final int currentIdUser;
  final int idUser;
  final String username;
  final String commentText;
  final String createdAt;
  final VoidCallback editComment;
  const CustomCommentItemWidget({
    super.key,
    required this.username,
    required this.commentText,
    required this.createdAt,
    required this.idUser,
    required this.currentIdUser,
    required this.editComment,
  });

  @override
  State<CustomCommentItemWidget> createState() =>
      _CustomCommentItemWidgetState();
}

class _CustomCommentItemWidgetState extends State<CustomCommentItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 160,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 280,
                child: Text(
                  widget.commentText,
                  style: TextStyle(
                    fontSize: 12,
                    color: blueWhiteColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
              ),
              const Spacer(),
              Text(
                widget.createdAt,
                style: TextStyle(
                  color: yellowColor,
                ),
              ),
            ],
          ),
        ),
        if (widget.idUser == widget.currentIdUser)
          Positioned(
            right: 0,
            child: CustomIconButtonWidget(
              onTap: widget.editComment,
              iconButton: Icons.edit_rounded,
              iconSize: 18,
              iconColor: darkBlueColor,
              width: 30,
              height: 30,
              color: yellowColor,
            ),
          ),
      ],
    );
  }
}
