import 'package:flutter/material.dart';

/// 封装TextWidget
class GHTextWidget extends StatelessWidget {
  final String text;
  final ValueChanged<String>? onChanged;
  final double fontSize;
  final bool isShowBottomLine;
  final TextEditingController? textEditingController;

  const GHTextWidget(
    this.text, {
    Key? key,
    this.onChanged,
    this.fontSize = 14,
    this.isShowBottomLine = true,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: isShowBottomLine ? Colors.black12 : Colors.transparent,
          ),
        ),
      ),
      height: 50,
      child: TextField(
        controller: textEditingController,
        style: TextStyle(fontSize: fontSize),
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => textEditingController?.text = "",
              );
            },
            child: const Icon(Icons.clear),
          ),
          contentPadding: const EdgeInsets.only(left: 0, top: 0),
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
