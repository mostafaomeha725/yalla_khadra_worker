import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yallakhadra/core/theme/app_colors.dart';
import 'package:yallakhadra/core/widgets/app_form_field.dart';

class OtpCodeFieldsRow extends StatelessWidget {
  const OtpCodeFieldsRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        controllers.length,
        (index) => AnimatedBuilder(
          animation: focusNodes[index],
          builder: (context, child) {
            final bool isActiveField = focusNodes[index].hasFocus;

            return SizedBox(
              width: 42.w,
              child: Focus(
                onKeyEvent: (FocusNode node, KeyEvent event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace &&
                      controllers[index].text.isEmpty &&
                      index > 0) {
                    controllers[index - 1].clear();
                    FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                    return KeyEventResult.handled;
                  }

                  return KeyEventResult.ignored;
                },
                child: AppFormField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  hintText: '',
                  keyboardType: TextInputType.number,
                  textInputAction: index == controllers.length - 1
                      ? TextInputAction.done
                      : TextInputAction.next,
                  fillColor: AppColors.authFieldFill,
                  borderColor: isActiveField
                      ? AppColors.authPrimary
                      : AppColors.authFieldBorder,
                  borderWidth: isActiveField ? 1.8 : 1.2,
                  radius: 12.r,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) {
                    if (value.length == 1 && index < controllers.length - 1) {
                      FocusScope.of(
                        context,
                      ).requestFocus(focusNodes[index + 1]);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
