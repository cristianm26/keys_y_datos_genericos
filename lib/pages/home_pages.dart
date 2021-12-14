import 'package:flutter/material.dart';
import 'package:generic_types_and_keys/utils/countries.dart';
import 'package:generic_types_and_keys/utils/search_picker.dart';

class HomePage extends StatelessWidget {
  final _scafoldKey = GlobalKey<ScaffoldState>();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_book_outlined),
          onPressed: () {
            _scafoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  final data = await showSearchPicker<String>(
                    context,
                    onItemBuild: (item) => ListTile(
                      title: Text(item.label),
                      subtitle: Text(item.value.toString()),
                    ),
                    onSearch: (e, query) {
                      if (e.value != null &&
                          e.value.toString().contains(query)) {
                        return true;
                      }
                      return e.label
                          .toLowerCase()
                          .contains(query.toLowerCase());
                    },
                    items: countries
                        .map((e) => SearchPickerItem<String>(
                              label: e['country'] as String,
                              value: e['calling_code'] as String,
                            ))
                        .toList(),
                  );
                  // ignore: avoid_print
                  print(data);
                },
                child: const Text('Seleccionar País'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
