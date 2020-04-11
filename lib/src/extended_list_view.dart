import 'dart:async';

import 'package:flutter/material.dart';

class ExtendedListView<T> extends StatefulWidget {
  ExtendedListView({
    Key key,
    @required this.items,
    @required this.buildItem,
    this.onRefresh,
  }) : super(key: key);
  final List<T> items;
  final Function onRefresh;
  final Function(T) buildItem;
  @override
  _ExtendedListViewState createState() => _ExtendedListViewState();
}

class _ExtendedListViewState extends State<ExtendedListView> {
  List<dynamic> _items;
  Function _onRefresh;
  Function _buildItem;
  @override
  void initState() {
    super.initState();
    _items = widget.items;
    _onRefresh = widget.onRefresh;
    _buildItem = widget.buildItem;
  }

  @override
  Widget build(BuildContext context) {
    if (_onRefresh != null) {
      return RefreshIndicator(
          child: _getListViewBuilder(),
          onRefresh: () async {
            _onRefresh();
          });
    } else {
      return _getListViewBuilder();
    }
  }

  Widget _getListViewBuilder() {
    return ListView.separated(
        padding: EdgeInsets.all(0),
        separatorBuilder: (context, index) =>
            Container(color: Color.fromRGBO(0, 0, 0, 0.2), height: 1),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(_items[index]);
        },
        itemCount: _items.length);
  }
}
