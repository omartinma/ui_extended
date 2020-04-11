import 'package:flutter/material.dart';

class ExtendedAppBar extends StatefulWidget implements PreferredSizeWidget {
  ExtendedAppBar(
    this.title, {
    this.clickOnSearch,
    this.doSearch,
    this.cancelSearch,
    this.searchController,
    this.actionButtons,
    this.willDisplaySearchBar = false,
    this.willDisplaySettingsButton = true,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.leading,
    Key key,
  }) : super(key: key);
  final String title;
  final Function clickOnSearch;
  final Function doSearch;
  final Function cancelSearch;
  final TextEditingController searchController;
  final List<Widget> actionButtons;
  final bool willDisplaySearchBar;
  final bool willDisplaySettingsButton;
  final PreferredSizeWidget bottom;
  final bool automaticallyImplyLeading;
  final Widget leading;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

  @override
  _ExtendedAppBarState createState() => _ExtendedAppBarState();
}

class _ExtendedAppBarState extends State<ExtendedAppBar>
    with SingleTickerProviderStateMixin {
  bool _isSearching = false;
  String title;
  Function clickOnSearch;
  Function doSearch;
  Function cancelSearch;
  TextEditingController searchController;
  List<Widget> actionButtons;
  bool willDisplaySearchBar;
  bool willDisplaySettingsButton;
  PreferredSizeWidget bottom;
  bool automaticallyImplyLeading;
  Widget leading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    title = widget.title;
    clickOnSearch = widget.clickOnSearch;
    doSearch = widget.doSearch;
    cancelSearch = widget.cancelSearch;
    searchController = widget.searchController;
    actionButtons = widget.actionButtons;
    willDisplaySearchBar = widget.willDisplaySearchBar;
    willDisplaySettingsButton = widget.willDisplaySettingsButton;
    bottom = widget.bottom;
    automaticallyImplyLeading = widget.automaticallyImplyLeading;
    leading = widget.leading;
    return _isSearching ? getAppBarSearching() : getAppBarNotSearching();
  }

  Widget getAppBarNotSearching() {
    return AppBar(
      title: Text(title),
      actions: _getActionsButton(),
      bottom: bottom,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
    );
  }

  List<Widget> _getActionsButton() {
    List<Widget> buttons = new List<Widget>();
    if (willDisplaySearchBar) {
      buttons.add(_getSearchButton());
    }
    if (actionButtons != null) {
      for (var actionButton in actionButtons) {
        buttons.add(actionButton);
      }
    }

    return buttons;
  }

  Widget _getSearchButton() {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          if (clickOnSearch != null) clickOnSearch();
          setState(() {
            _isSearching = true;
          });
        });
  }

  Widget getAppBarSearching() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (cancelSearch != null) cancelSearch();
            setState(() {
              _isSearching = false;
            });
          }),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          controller: searchController,
          onEditingComplete: () {
            if (doSearch != null) return doSearch();
            setState(() {
              _isSearching = false;
            });
          },
          style: new TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          autofocus: true,
          decoration: InputDecoration(
            focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
