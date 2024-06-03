import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:two_way_dael/core/theming/colors.dart';

class CustomDropDownList extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final Widget? prefixIcon;
  final bool isCitySelected;
  final String? Function(String?)? validation;
  final List<SelectedListItem>? dropedList;
  final Function(List<SelectedListItem>)? selectedItems;

  const CustomDropDownList({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.dropedList,
    super.key,
    this.prefixIcon,
    this.validation,
    this.selectedItems,
  });

  @override
  _CustomDropDownListState createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {
  void onTextFieldTap() {
    DropDownState(
      heightOfBottomSheet: 700,
      DropDown(
        bottomSheetTitle: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        data: widget.dropedList ?? [],
        selectedItems: widget.selectedItems,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          validator: widget.validation,
          readOnly: true,
          controller: widget.textEditingController,
          cursorColor: ColorManager.mainOrange,
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: ColorManager.mainOrange,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            hintText: widget.textEditingController.text == ''
                ? widget.hint
                : widget.textEditingController.text,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.gray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.gray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.mainOrange,
                width: 1.3,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(40.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
