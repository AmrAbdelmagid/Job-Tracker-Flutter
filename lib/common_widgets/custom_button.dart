// when creating custom reusable widgets you need three things
// 1- Add properties
// 2- Add Constructor
// 3- Use these properties inside the build method (inside the widget)

// if you want to reuse this widget through extending to other widget, you can
// just put a constructor in the child widget and call the super constructor
// with the values you want without adding a build method.