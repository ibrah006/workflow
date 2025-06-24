import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String? labelText;
  final List<String>? items;

  const CustomDropdownMenu({super.key, this.labelText, this.items});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return // Border Container
        Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFecf0f6)),
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Text(labelText ?? "",
                style: textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.normal)),
          ),
          // Vertical Divider
          Container(color: Color(0xFFecf0f6), width: 2, height: 54),
          Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  DropDownState<String>(
                    dropDown: DropDown<String>(
                      data: items?.map((item) {
                            return SelectedListItem(data: item);
                          }).toList() ??
                          [],
                      onSelected: (selectedItems) {
                        List<String> list = [];
                        for (var item in selectedItems) {
                          list.add(item.data);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              list.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ).showModal(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(EvaIcons.arrowDown,
                        size: 20, color: Colors.blueGrey.shade600),
                    SizedBox(width: 15)
                  ],
                ),
              )
              // DropdownMenu(
              //   width: double.infinity,
              //   inputDecorationTheme: InputDecorationTheme(
              //     enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              //     isDense: true,
              //   ),
              //   trailingIcon: Icon(
              //     EvaIcons.chevronDown,
              //     color: Colors.blueGrey.shade600,
              //     size: 27,
              //   ),
              //   selectedTrailingIcon: Icon(
              //     EvaIcons.chevronUp,
              //     color: Colors.blueGrey.shade600,
              //     size: 27,
              //   ),
              //   dropdownMenuEntries: items?.map((item) {
              //         return DropdownMenuEntry(value: item, label: item);
              //       }).toList() ??
              //       [],
              // ),
              ),
        ],
      ),
    );
  }
}
