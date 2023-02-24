import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz_bet/layer_data/models/drop_down_common_model.dart';
import 'package:quiz_bet/layer_presentation/common/app_card.dart';
import 'package:quiz_bet/theme/app_colors.dart';
import 'package:quiz_bet/theme/app_sizes.dart';
import 'package:sizer/sizer.dart';

class AppDropdownInput extends StatefulWidget {
  const AppDropdownInput(
      {super.key,
      required this.list,
      required this.onChanged,
      required this.hint,
      this.initialValue});

  final List<DropDownCommonModel> list;
  final Function(DropDownCommonModel?) onChanged;
  final String hint;
  final DropDownCommonModel? initialValue;

  @override
  State<AppDropdownInput> createState() => _AppDropdownInputState();
}

class _AppDropdownInputState extends State<AppDropdownInput> {
  DropDownCommonModel? dropdownValue;

  @override
  void initState() {
    if (widget.initialValue != null) {
      dropdownValue = widget.initialValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: AppCard(
        child: Material(
          color: AppColors.white,
          elevation: 1,
          shadowColor: AppColors.completelyBlack.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.mp_w_6,
              vertical: AppSizes.mp_v_1 / 2,
            ),
            child: DropdownButton<String>(
              value: dropdownValue != null ? dropdownValue!.id : '',
              icon: Icon(
                FontAwesomeIcons.solidCircleArrowDown,
                color: AppColors.black,
                size: AppSizes.icon_size_4 * 0.9,
              ),
              elevation: 0,
              isExpanded: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black,
                    fontSize: AppSizes.font_12,
                    fontWeight: FontWeight.w600,
                  ),
              underline: const SizedBox(),
              hint: Text(
                widget.hint,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.grey,
                      fontSize: AppSizes.font_12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              onChanged: (String? value) {
                ///This is called when the user selects an item.
                widget.onChanged(
                  widget.list.firstWhere((element) => element.id == value),
                );

                ///
                setState(() {
                  dropdownValue = widget.list.firstWhere(
                    (element) => element.id == value,
                  );
                });
              },
              items: widget.list
                  .map<DropdownMenuItem<String>>((DropDownCommonModel value) {
                return DropdownMenuItem<String>(
                  value: value.id,
                  child: Text(value.name.nameAm),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
