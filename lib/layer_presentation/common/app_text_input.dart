import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput(
      {Key? key,
      required this.textEditingController,
      required this.validator,
      required this.hint,
      required this.prefixIcon,
      this.isPassword, this.keyboardType})
      : super(key: key);

  final TextEditingController textEditingController;
  final String? Function(String? value)? validator;
  final String hint;
  final IconData prefixIcon;
  final bool? isPassword;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightWhite.withOpacity(0.5),
      borderRadius: BorderRadius.circular(
        AppSizes.radius_6,
      ),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.next,
        inputFormatters: keyboardType==TextInputType.number ? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ]:null,
        obscureText: isPassword != null ? isPassword! : false,
        validator: validator,
        onChanged: (val) {},
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.mp_w_4,
            vertical: AppSizes.mp_v_2,
          ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.radius_6,
            ),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: AppSizes.icon_size_4,
            color: AppColors.gold,
          ),
        ),
      ),
    );
  }
}
