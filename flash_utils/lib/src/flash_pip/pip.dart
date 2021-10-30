import 'package:flash_utils/src/models/flash_aspect_ratio.dart';
import 'package:flash_utils/src/utils/typedef.dart';
import 'package:flutter/material.dart';

import '../method_callls.dart';

class FlashPIP extends StatefulWidget {
  final Widget? child;
  final PipWidgetBuilder builder;
  final bool enterPipOnHomeButton;
  final FlashAspectRatio aspectRatio;
  const FlashPIP({
    Key? key,
    this.child,
    this.enterPipOnHomeButton = false,
    required this.builder,
    this.aspectRatio = const FlashAspectRatio(h: 0, w: 0),
  }) : super(key: key);

  @override
  _FlashPIPState createState() => _FlashPIPState();
}

class _FlashPIPState extends State<FlashPIP> with WidgetsBindingObserver {
  bool? isInPIPMode;
  bool enterPipOnHomeButton = false;
  @override
  void initState() {
    super.initState();
    enterPipOnHomeButton = widget.enterPipOnHomeButton;
    isInPIPMode = false;
    setState(() {});
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        if (widget.enterPipOnHomeButton) {
          FlashUtilsMethodCall.enterPiPMode(
              widget.aspectRatio.h, widget.aspectRatio.w);
        }
        isInPIPMode = true;
        // setState(() {});
        break;
      case AppLifecycleState.resumed:
        isInPIPMode = false;
        setState(() {});
        break;
      default:
    }
  }

  @override
  void didUpdateWidget(covariant FlashPIP oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enterPipOnHomeButton != widget.enterPipOnHomeButton) {
      enterPipOnHomeButton = widget.enterPipOnHomeButton;
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.call(context, isInPIPMode!, widget.child);
  }
}
