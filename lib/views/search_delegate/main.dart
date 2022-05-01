import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snau_survey/views/search_delegate/material_search_delegate.dart';
import 'package:snau_survey/views/search_delegate/platform_search_delegate.dart';

final List<PlatformItem> platforms = [
  PlatformItem(
    'Android',
    Image.asset(
      'assets/android.gif',
      width: 50.0,
      height: 50.0,
    ),
  ),
  PlatformItem(
    'iOS',
    Image.asset(
      'assets/iOS.png',
      width: 50.0,
      height: 50.0,
    ),
  ),
  PlatformItem(
    'Windows',
    Image.asset(
      'assets/windows.png',
      width: 50.0,
      height: 50.0,
    ),
  ),
  PlatformItem(
    'Linux',
    Image.asset(
      'assets/linux.png',
      width: 50.0,
      height: 50.0,
    ),
  ),
  PlatformItem(
    'MacOS',
    Image.asset(
      'assets/macOS.png',
      width: 50.0,
      height: 50.0,
    ),
  ),
  PlatformItem(
    'Web',
    Container(
      width: 50.0,
      height: 50.0,
    ),
  ),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pick a search demo'),
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MaterialSearch(search))),
                  child: PlatformItemWidget(
                    PlatformItem(
                      'Android',
                      Image.asset(
                        'assets/raised_fist.png',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PlatformItem> search(String text) {
    return platforms
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}

class MaterialSearch extends StatelessWidget {
  final List<PlatformItem> Function(String text) search;

  MaterialSearch(this.search);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showPlatformSearch(
                  context: context,
                  delegate: MaterialSearchDelegate(search),
                );
              },
            ),
          ],
        ),
        body: PlatformItemsWidget(platforms),
      ),
    );
  }
}

class PlatformItem {
  final String name;
  final Widget asset;

  const PlatformItem(this.name, this.asset);
}

class PlatformItemsWidget extends StatelessWidget {
  final List<PlatformItem> items;

  const PlatformItemsWidget(this.items);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];
        return PlatformItemWidget(item);
      },
    );
  }
}

class PlatformItemWidget extends StatelessWidget {
  final PlatformItem item;
  final bool small;
  const PlatformItemWidget(this.item, {this.small = false});
  @override
  Widget build(BuildContext context) {
    return small
        ? Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                item.name,
              ),
            ),
          )
        : Card(
            child: fluent.Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Row(
                  children: [
                    item.asset,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        item.name,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
  }
}
