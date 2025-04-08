import 'package:autocyr_pro/domain/models/abstractables/selectable.dart';
import 'package:autocyr_pro/domain/models/commons/bike_make.dart';
import 'package:autocyr_pro/domain/models/commons/car_make.dart';
import 'package:autocyr_pro/domain/models/commons/country.dart';
import 'package:autocyr_pro/domain/models/core/article.dart';
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
  final bool multiple;
  final Function onSave;
  CustomSearchable({super.key, required this.controller, required this.list, required this.typeSelection, required this.multiple, required this.onSave});

  @override
  State<CustomSearchable> createState() => _CustomSearchableState();
}

class _CustomSearchableState extends State<CustomSearchable> {

  late List<Selectable> localList = [];
  List<Selectable>? selectedList = [];
  Selectable? localSelectedObject;

  loadList() async {
    final common = Provider.of<CommonNotifier>(context, listen: false);
    setState(() {
      switch(widget.typeSelection) {
        case "country":
          localList = widget.list.where((element) => element.name.toLowerCase() != "togo").toList();
          break;
        case "article":
          localList = widget.list;
          break;
        case "bike":
          localList = widget.list;
          if(widget.multiple) {
            List<BikeMake> selected = [];
            for(var element in common.selectedBikeMakes) {
              selected.add(element);
            }
            selectedList = selected;
          }
          break;
        case "car":
          localList = widget.list;
          if(widget.multiple) {
            List<CarMake> selected = [];
            for(var element in common.selectedCarMakes) {
              selected.add(element);
            }
            selectedList = selected;
          }
          break;
      }
    });
  }

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
    loadList();
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
                fillColor: GlobalThemeData.lightColorScheme.primary.withOpacity(0.1),
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
            icon: Icon(Icons.clear, color: GlobalThemeData.lightColorScheme.error,),
          ).animate().fadeIn(),
          if(localSelectedObject != null || selectedList != null)
            Consumer<CommonNotifier>(
              builder: (context, common, child) {
                return IconButton(
                  onPressed: () async {
                    if(widget.multiple) {
                      widget.controller.text = "${selectedList!.length} ${selectedList!.length > 1 ? "marques sélectionnées" : "marque sélectionnée"}";
                    } else {
                      widget.controller.text = localSelectedObject!.name;
                    }
                    switch(widget.typeSelection) {
                      case "country":
                        common.setCountry(localSelectedObject! as Country);
                        break;
                      case "article":
                        common.setArticle(localSelectedObject! as Article);
                        break;
                      case "bike":
                        List<BikeMake> selected = [];
                        for(var element in selectedList!) {
                          selected.add(element as BikeMake);
                        }
                        common.setSelectedBikeMakes(selected);
                        break;
                      case "car":
                        List<CarMake> selected = [];
                        for(var element in selectedList!) {
                          selected.add(element as CarMake);
                        }
                        common.setSelectedCarMakes(selected);
                        break;
                    }
                    await widget.onSave();
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
                if(widget.multiple) {
                  if(selectedList!.contains(element)) {
                    selectedList!.remove(element);
                  } else {
                    selectedList!.add(element);
                  }
                } else {
                  localSelectedObject = element == localSelectedObject ? null : element;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: size.width,
              decoration: BoxDecoration(
                color: localSelectedObject == element || selectedList!.contains(element) ? GlobalThemeData.lightColorScheme.primary : Colors.transparent,
              ),
              child: Row(
                children: [
                  Label14(
                    text: element.name,
                    color: localSelectedObject == element || selectedList!.contains(element) ? GlobalThemeData.lightColorScheme.onPrimary : GlobalThemeData.lightColorScheme.primary,
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
