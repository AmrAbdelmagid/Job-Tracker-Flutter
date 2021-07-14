import 'package:flutter/material.dart';

double getInnerHeight(BuildContext context, AppBar appBar) {
  return MediaQuery.of(context).size.height -
      appBar.preferredSize.height -
      MediaQuery.of(context).padding.top;
}

double getHeightWithoutAppBar(BuildContext context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top;
}

double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getUpperComponentsHeight(BuildContext context, AppBar appBar) {
  return appBar.preferredSize.height + MediaQuery.of(context).padding.top;
}

// onTap: () => FocusManager.instance.primaryFocus?.unfocus()

// log(getUpperComponentsHeight(context, appBar).toString());
// log(getLowerComponentsHeight(context, appBar));
// log(getInnerHeight(context, appBar).toString());
// log(getDeviceWidth(context).toString());
// log(constraints.maxWidth.toString());
// log(constraints.maxHeight.toString());
// log(Scaffold.of(context).appBarMaxHeight.toString());
// log(AppBar().preferredSize.height.toString());
// log(MediaQuery.of(context).padding.top.toString());
// log(kToolbarHeight.toString());
// log(MediaQueryData.fromWindow(ui.window).padding.top.toString());


// GlobalKey _paddingKey = GlobalKey();
// _getPaddingSize() {
//   final RenderBox renderBox =
//       _paddingKey.currentContext!.findRenderObject() as RenderBox;
//   final size = renderBox.size;
//   log('here');
//   log(size.toString());
// }