import 'package:flutter/material.dart';

typedef OnEnterPip = Function(bool);
typedef OnLeavePip = Function(bool);
typedef PipWidgetBuilder = Widget Function(BuildContext, bool, Widget?);
