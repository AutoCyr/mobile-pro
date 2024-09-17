import 'package:autocyr_pro/domain/models/abstractables/selectable.dart';
import 'package:autocyr_pro/domain/models/commons/country.dart';
import 'package:autocyr_pro/presentation/notifier/common_notifier.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label10.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label12.dart';
import 'package:autocyr_pro/presentation/ui/atoms/labels/label14.dart';
import 'package:autocyr_pro/presentation/ui/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class CustomSearchable extends StatefulWidget {
  final TextEditingController controller;
  final List<Selectable> list;
  final String typeSelection;
  CustomSearchable({super.key, required this.controller, required this.list, required this.typeSelection});

  @override
  State<CustomSearchable> createState() => _CustomSearchableState();
}

class _CustomSearchableState extends State<CustomSearchable> {

  late List<Selectable> localList = [];
  Selectable? localSelectedObject;

  void filterList(String searchQuery) {
    List<Selectable> filtered = [];
    for (var value in widget.list) {
      if (value.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        filtered.add(value);
      }
    }
    setState(() {
      localList = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    localList = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GlobalThemeData.lightColorScheme.primary),
        backgroundColor: GlobalThemeData.lightColorScheme.onPrimary,
        title: SizedBox(
          height: 45,
          child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: GlobalThemeData.lightColorScheme.primaryContainer.withOpacity(0.1),
                hintText: "Rechercher",
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  fontSize: 13
                ),
              ),
              style: const TextStyle(
                  fontSize: 13
              ),
              autofocus: false,
              onChanged: (value) => filterList(value),
            ),
        ).animate().fadeIn(),
        actions: [
          IconButton(
            onPressed: () {
              widget.controller.text = "";
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear, color: GlobalThemeData.lightColorScheme.errorContainer,),
          ).animate().fadeIn(),
          if(localSelectedObject != null)
            Consumer<CommonNotifier>(
              builder: (context, common, child) {
                return IconButton(
                  onPressed: () {
                    widget.controller.text = localSelectedObject!.name;
                    switch(widget.typeSelection) {
                      case "country":
                        common.setCountry(localSelectedObject! as Country);
                        break;
                    }
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.check, color: GlobalThemeData.lightColorScheme.primary,),
                ).animate().fadeIn();
              }
            ),
        ]
      ),
      body: GroupedListView<dynamic, String>(
        elements: localList,
        groupBy: (element) {
          return element.name.substring(0, 1);
        },
        groupSeparatorBuilder: (String groupByValue) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            width: size.width,
            color: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
            child: Row(
              children: [
                Label14(text: groupByValue, color: GlobalThemeData.lightColorScheme.primary, weight: FontWeight.bold, maxLines: 1),
              ],
            ),
          ).animate().fadeIn();
        },
        itemBuilder: (context, dynamic element) {
          return InkWell(
            splashColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
            onTap: () {
              setState(() {
                localSelectedObject = element == localSelectedObject ? null : element;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: size.width,
              decoration: BoxDecoration(
                color: localSelectedObject == element ? GlobalThemeData.lightColorScheme.primary : Colors.transparent,
              ),
              child: Row(
                children: [
                  Label14(
                    text: element.name,
                    color: localSelectedObject == element ? GlobalThemeData.lightColorScheme.onPrimary : GlobalThemeData.lightColorScheme.primary,
                    weight: FontWeight.w400,
                    maxLines: 1
                  ),
                ],
              ),
            ),
          ).animate().fadeIn();
        },
        itemComparator: (item1, item2) => item1.name.compareTo(item2.name),
        useStickyGroupSeparators: true,
        floatingHeader: true,
        order: GroupedListOrder.ASC,
      )
    );
  }
}
