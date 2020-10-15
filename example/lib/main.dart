import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_popup_menulist/flutter_popup_menulist.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<MenuItem> menuList = new List<MenuItem>();

  @override
  void initState() {
    super.initState();
    getMenuList();
  }

  void getMenuList() {
    String menuListJson =
        "[{\"id\":8,\"parentId\":0,\"name\":\"测试1\",\"type\":0,\"typeValue\":\"brand-new\",\"subMenuList\":null,\"level\":1},{\"id\":12,\"parentId\":0,\"name\":\"测试2\",\"type\":2,\"typeValue\":\"3\",\"subMenuList\":null,\"level\":1},{\"id\":4,\"parentId\":0,\"name\":\"测试3\",\"type\":0,\"typeValue\":\"hfmszs\",\"subMenuList\":[{\"id\":13,\"parentId\":4,\"name\":\"测试31\",\"type\":0,\"typeValue\":\"hfqxcp\",\"subMenuList\":null,\"level\":2},{\"id\":19,\"parentId\":4,\"name\":\"测试32\",\"type\":null,\"typeValue\":null,\"subMenuList\":[{\"id\":35,\"parentId\":19,\"name\":\"测试321\",\"type\":0,\"typeValue\":\"xzqjtl\",\"subMenuList\":null,\"level\":3},{\"id\":36,\"parentId\":19,\"name\":\"测试322\",\"type\":0,\"typeValue\":\"jhs\",\"subMenuList\":null,\"level\":3},{\"id\":37,\"parentId\":19,\"name\":\"测试323\",\"type\":0,\"typeValue\":\"xhjh\",\"subMenuList\":null,\"level\":3}],\"level\":2}],\"level\":1}]";
    List array = json.decode(menuListJson);
    array.forEach((item) {
      MenuItem menu = MenuItem.fromMap(item);
      print(menu.typeValue);
      menuList.add(menu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: MenuListPopupWidget(
            bodyWidget: Center(
              child: Text('test'),
            ),
            menuList: menuList,
            headerImageUrl:
                "https://img.alicdn.com/tfs/TB1EGGoLXXXXXcLXpXXXXXXXXXX-123-38.png",
            headerImageRatio: 3.236,
            headerImageFit: BoxFit.fitHeight,
            menuItemClick: (MenuItem item) {
              if (item.children == null || item.children.length == 0) {
                print('clicked : ${item.name}');
              }
            },
          )),
    );
  }
}
