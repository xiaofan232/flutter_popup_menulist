import 'package:list_treeview/list_treeview.dart';

class MenuItem extends NodeData {
  int id;
  int parentId;
  String name;
  /// type key for some situation
  int type;
  /// type value for some situation
  String typeValue;
  int level;
  List<MenuItem> subMenuList;

  MenuItem(
      {this.id,
      this.parentId,
      this.name,
      this.type,
      this.typeValue,
      this.level,
      this.subMenuList});

  static MenuItem fromMap(Map map) {
    if (map == null) {
      return null;
    }

    List<MenuItem> datas;
    if (map["subMenuList"] != null && map["subMenuList"].length > 0) {
      datas = _parseOrgans(map["subMenuList"]);
    }

    MenuItem menu = new MenuItem(
      id: map["id"],
      parentId: map["parentId"],
      name: map["name"],
      type: map["type"],
      typeValue: map["typeValue"],
      level: map["level"],
      subMenuList: datas,
    );

    menu.addChildrenMenu(menu, datas);
    return menu;
  }

  void addChildrenMenu(MenuItem menu, List<MenuItem> menus) {
    if (menus != null && menus.length > 0) {
      menus.forEach((item) {
        menu.addChild(item);
      });
    }
  }

  static List<MenuItem> _parseOrgans(List maps) {
    List<MenuItem> subList = new List();
    for (Map map in maps) {
      subList.add(_parseOrgan(map));
    }
    return subList;
  }

  static MenuItem _parseOrgan(Map map) {
    MenuItem item = MenuItem.fromMap(map);
    return item;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['typeValue'] = this.typeValue;
    data['subMenuList'] = this.subMenuList;
    data['level'] = this.level;
    return data;
  }
}
