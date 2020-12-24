import 'package:Tahfizul/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfeild extends StatelessWidget {
  final String hintText, text;
  final bool obscureText, enabled;
  final Function onChanged;
  final TextInputType textInputType;
  final int maxLength;
  final int maxlines;
  final TextInputAction textInputAction;
  final Color textColor;
  final String error;
  final Function onEditComplete;
  final List<TextInputFormatter> textInputFormatter;
  final TextStyle textStyle;
  final IconData prefixicon;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final Function validator;
  final bool autovalidate;
  final Function onSaved;
  final bool readOnly;

  CustomTextfeild(
      {this.textInputFormatter,
      this.maxLength,
      this.onEditComplete,
      this.error,
      this.textColor,
      this.textInputAction,
      this.maxlines = 1,
      this.text,
      this.hintText,
      this.obscureText,
      this.onChanged,
      this.enabled,
      this.textInputType,
      this.textStyle,
      this.prefixicon,
      this.suffixIcon,
      this.focusNode,
      this.validator,
      this.autovalidate = false,
      this.onSaved, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller =
        text != null ? TextEditingController(text: text) : null;
    if (_controller != null) {
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
    }
    OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white, width: 2.0),
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.zero,
                bottomRight: Radius.zero,
              )),
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0, bottom: 14.0, left: 5),
            child: Icon(
              prefixicon,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: TextFormField(
            onFieldSubmitted: onEditComplete,
            maxLines: maxlines,
            validator: validator,
            focusNode: focusNode,
            readOnly: readOnly,
            style: AppStyles.greyTextStyle,
            keyboardType: textInputType,
            obscureText: obscureText == null ? false : obscureText,
            maxLength: maxLength != null ? maxLength : null,
            onChanged: onChanged,
            onSaved: onSaved,
            enabled: enabled != null ? enabled : true,
            inputFormatters: textInputFormatter,
            autovalidate: autovalidate,
            controller: _controller != null ? _controller : null,
            textInputAction: textInputAction != null
                ? textInputAction
                : TextInputAction.done,
            decoration: InputDecoration(
              isDense: true,
              counterText: '',
              errorText: error,
              focusedBorder: new OutlineInputBorder(
                borderSide:
                    new BorderSide(color: AppColors.whiteColor, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              hintText: hintText,
              hintStyle: AppStyles.greyTextStyle,
              filled: true,
              fillColor: AppColors.lightestGreyColor,
              suffixIcon: suffixIcon,
              enabledBorder: new OutlineInputBorder(
                borderSide:
                    new BorderSide(color: AppColors.whiteColor, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              border: new OutlineInputBorder(
                borderSide:
                    new BorderSide(color: AppColors.whiteColor, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(30.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(30.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
