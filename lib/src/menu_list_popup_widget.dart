import 'package:flutter/material.dart';
import 'package:list_treeview/tree/controller/tree_controller.dart';
import 'package:list_treeview/tree/node/tree_node.dart';
import 'package:list_treeview/tree/tree_view.dart';

import '../flutter_popup_menulist.dart';
import 'menu.dart';

typedef void MenuItemClick(MenuItem menuItem);

class MenuListPopupWidget extends StatefulWidget {
  ///menu list for display
  ///if not set,cannot display any menu
  final List<MenuItem> menuList;

  ///tranfer body to scaffold body
  final Widget bodyWidget;

  ///popup view background color
  final Color color;

  ///txt color
  final Color txtColor;

  ///leading background color
  final Color leadingBKColor;

  ///leading color
  final Color leadingColor;

  ///title image url
  final String headerImageUrl;

  ///leading background color init
  final Color initLeadingBKColor;

  ///leading color init
  final Color initLeadingColor;

  ///divider side color
  final Color dividerColor;

  ///appbar background color
  final Color appBarBgColor;

  ///width of header image
  final double headerImageWidth;

  ///image ratio of header image
  final double headerImageRatio;

  ///check whether the second level font weight is bold or not
  final bool isSecondLevelBold;

  ///fit style of header image
  final BoxFit headerImageFit;

  ///menu click event
  final MenuItemClick menuItemClick;

  MenuListPopupWidget(
      {Key key,
      @required this.menuList,
      @required this.bodyWidget,
      this.headerImageUrl,
      this.headerImageWidth,
      this.headerImageRatio,
      this.color,
      this.txtColor,
      this.leadingBKColor,
      this.leadingColor,
      this.initLeadingBKColor,
      this.initLeadingColor,
      this.dividerColor,
      this.appBarBgColor,
      this.isSecondLevelBold,
      this.headerImageFit,
      this.menuItemClick})
      : super(key: key);

  @override
  MenuListPopupWidgetState createState() => new MenuListPopupWidgetState();
}

class MenuListPopupWidgetState extends State<MenuListPopupWidget> {
  OverlayEntry overlayEntry;
  bool isShow = false;
  GlobalKey _tapWidget = GlobalKey();
  GlobalKey _appbottomWidget = GlobalKey();
  ScrollController _scrollController = new ScrollController();
  TreeViewController _controller;
  List<MenuItem> menuList = new List<MenuItem>();
  Color color = Colors.white;
  Color txtColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    double headerImageWidth =
        widget.headerImageWidth == null ? 150.0 : widget.headerImageWidth;
    double headerImageRatio =
        widget.headerImageRatio == null ? 1 : widget.headerImageRatio;

    Color appBarBgColor =
        widget.appBarBgColor == null ? Colors.white : widget.appBarBgColor;
    Color leadingColor = widget.initLeadingColor == null
        ? Colors.black
        : widget.initLeadingColor;
    Color leadingBKColor = widget.initLeadingBKColor == null
        ? Colors.white
        : widget.initLeadingBKColor;
    if (isShow) {
      color = widget.color == null
          ? Color.fromRGBO(28, 39, 82, 0.95)
          : widget.color;
      txtColor = widget.txtColor == null
          ? Color.fromRGBO(171, 189, 255, 1)
          : widget.txtColor;
      leadingColor = widget.leadingColor == null
          ? Color.fromRGBO(171, 189, 255, 1)
          : widget.leadingColor;
      leadingBKColor = widget.leadingBKColor == null
          ? Color.fromRGBO(28, 39, 82, 0.95)
          : widget.leadingBKColor;
    }

    return Scaffold(
        appBar: AppBar(
          key: _tapWidget,
          title: Container(
            width: headerImageWidth,
            child: AspectRatio(
              aspectRatio: headerImageRatio,
              child: buildNetWorkImage(widget.headerImageUrl,
                  fit: widget.headerImageFit == null
                      ? BoxFit.fitWidth
                      : widget.headerImageFit,
                  defaultImageAssetPath: "assets/image/default_avatar.png"),
            ),
            height: 40,
          ),
          centerTitle: true,
          leading: Container(
            color: leadingBKColor,
            child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: leadingColor,
                ),
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                    show(isShow: isShow);
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  });
                }),
          ),
          backgroundColor: appBarBgColor,
        ),
        body: Container(
          color: Colors.white,
          child: widget.bodyWidget,
        ));
  }

  void createOverLay() {
    Color color =
        widget.color == null ? Color.fromRGBO(28, 39, 82, 0.95) : widget.color;
    Color txtColor = widget.txtColor == null
        ? Color.fromRGBO(171, 189, 255, 1)
        : widget.txtColor;
    RenderBox renderBox = context.findRenderObject();
    var screenSize = renderBox.size;
    print("screenSize:" + screenSize.toString());
    renderBox = _tapWidget.currentContext.findRenderObject();
    var parentSize = renderBox.size;
    var parentPosition = renderBox.localToGlobal(Offset.zero);

    var appbarBottomHeight = 0.0;
    RenderBox appbarBottomRenderBox =
        _appbottomWidget.currentContext?.findRenderObject();
    if (appbarBottomRenderBox != null) {
      appbarBottomHeight = appbarBottomRenderBox.size.height;
    }

    overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
          top: parentPosition.dy + parentSize.height - appbarBottomHeight,
          child: Material(
            child: Container(
                color: color,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    (parentPosition.dy +
                        parentSize.height -
                        appbarBottomHeight),
                child: ListTreeView(
                  shrinkWrap: false,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (BuildContext context, NodeData data) {
                    MenuItem item = data;
                    double offsetX = item.level * 16.0;
                    return Container(
                      height: 54,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: color,
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: offsetX),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${item.name}',
                                    style: TextStyle(
                                        fontSize: 15, color: txtColor),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                              visible: item.children != null &&
                                  item.children.length > 0,
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    _controller.expandOrCollapse(item.index);
                                  },
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: txtColor,
                                    size: 30,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                  onTap: (NodeData data) {
                    MenuItem item = data;
                    print('name = ${item.name}');
                    print('index = ${item.index}');
                    if (widget.menuItemClick != null) {
                      widget.menuItemClick(item);
                    }
                  },
                  onLongPress: (data) {},
                  controller: _controller,
                  toggleNodeOnTap: true,
                )),
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TreeViewController();
    getMenuList();
  }

  void getMenuList() {
    if (widget.menuList != null && widget.menuList.length > 0) {
      _controller.treeData(widget.menuList);
    }
  }

  void cancelOverLay() {
    if (overlayEntry != null) {
      setState(() {
        isShow = false;
        overlayEntry.remove();
      });
    }
  }

  void show({bool isShow}) {
    if (isShow) {
      if (overlayEntry == null) {
        createOverLay();
      }
      Overlay.of(context).insert(overlayEntry);
    } else {
      if (overlayEntry != null) {
        overlayEntry.remove();
      }
    }
  }

  @override
  void dispose() {
    if (overlayEntry != null) {
      overlayEntry.remove();
    }
    overlayEntry = null;
    super.dispose();
  }
}
