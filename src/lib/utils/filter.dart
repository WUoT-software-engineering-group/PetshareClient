import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:test_io2/utils/tileFilter.dart';
import 'package:test_io2/utils/ourColors.dart';

class OurFilter extends StatefulWidget {
  final List<String> filters;

  const OurFilter(this.filters, {Key? key}) : super(key: key);

  @override
  State<OurFilter> createState() => _OurFilterState(filters);
}

class _OurFilterState extends State<OurFilter> {
  List<String>? selectedFilters = [];
  List<String> filters;

  _OurFilterState(this.filters);

  void openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: filters,
      selectedListData: selectedFilters,
      hideSearchField: true,
      hideCloseIcon: true,
      hideHeader: true,
      height: 300,
      insetPadding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25),
      themeData: FilterListThemeData(
        context,
        backgroundColor: TBasicScaffoldColor,
        choiceChipTheme: const ChoiceChipThemeData(
          selectedBackgroundColor: DarkRose,
        ),
        controlButtonBarTheme: ControlButtonBarThemeData(context,
            backgroundColor: Rose,
            buttonSpacing: 5,
            controlButtonTheme: const ControlButtonThemeData(
              primaryButtonBackgroundColor: Mountbatten,
              backgroundColor: Mountbatten,
              elevation: 1,
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
            )),
      ),
      choiceChipLabel: (name) => name,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (name, query) {
        return name.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedFilters = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.5, left: 26, right: 26, bottom: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              child: SizedBox(
            height: 40,
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: selectedFilters!.length,
              itemBuilder: (context, index) =>
                  TileFilter(selectedFilters![index]),
            ),
          )),
          const SizedBox(width: 10),
          ElevatedButton(
              onPressed: () {
                openFilterDialog();
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                backgroundColor: MaterialStateProperty.all(Rose),
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed)) return Wenge;
                  return null; // <-- Splash color
                }),
              ),
              child: const Icon(Icons.filter_list_rounded))
        ],
      ),
    );
  }
}
