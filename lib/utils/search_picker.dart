import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef _OnItemBuild<T> = Widget Function(SearchPickerItem<T>);

typedef _OnSearch<T> = bool Function(SearchPickerItem<T>, String);

bool _filter<T>(SearchPickerItem<T> e, String query) {
  return e.label.toLowerCase().contains(query.toLowerCase());
}

class _SearchPicker<T> extends StatefulWidget {
  final List<SearchPickerItem<T>> items;
  final _OnItemBuild<T>? onItemBuild;
  /*  final Widget Function(SearchPickerItem<T>)? onItemBuild; */
  /*  final bool Function(SearchPickerItem<T>, String)? onSearch; */
  final _OnSearch<T>? onSearch;
  const _SearchPicker({
    Key? key,
    required this.items,
    this.onItemBuild,
    this.onSearch,
  }) : super(key: key);

  @override
  _SearchPickerState createState() => _SearchPickerState<T>();
}

class _SearchPickerState<T> extends State<_SearchPicker<T>> {
  String _query = "";
  @override
  Widget build(BuildContext context) {
    final List<SearchPickerItem<T>> filteredList = widget.items
        .where(
          widget.onSearch != null
              ? (e) => widget.onSearch!(e, _query)
              : (element) => _filter<T>(element, _query),
        )
        .toList();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CupertinoTextField(
                placeholder: 'Buscar',
                onChanged: (text) {
                  setState(() {
                    _query = text;
                  });
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    /* final item = widget.items[index]; */
                    final item = filteredList[index];
                    return widget.onItemBuild != null
                        ? CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: widget.onItemBuild!(item),
                            onPressed: () =>
                                Navigator.pop<T>(context, item.value))
                        : ListTile(
                            title: Text(item.label),
                            onTap: () {
                              /*  Navigator.pop(context, item.value); */
                              Navigator.pop<T>(context, item.value);
                            },
                          );
                  },
                  itemCount: filteredList.length,
                  /*  itemCount: widget.items.length, */
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPickerItem<T> {
  final String label;
  final T value;

  SearchPickerItem({
    required this.label,
    required this.value,
  });
}

Future<T?> showSearchPicker<T>(
  BuildContext context, {
  required List<SearchPickerItem<T>> items,
  _OnItemBuild<T>? onItemBuild,
  /* Widget Function(SearchPickerItem<T>)? onItemBuild, */
  /*  bool Function(SearchPickerItem<T>, String)? onSearch, */
  _OnSearch<T>? onSearch,
}) async {
  return showDialog<T>(
    context: context,
    builder: (_) => _SearchPicker<T>(
      items: items,
      onItemBuild: onItemBuild,
      onSearch: onSearch,
    ),
  );
}
