import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MiniPlayer extends StatefulWidget {
  final MiniPlayerController miniPlayerController;
  final Widget? child;
  final Widget? playerChild;
  final Widget? collapseChild;
  final Function(double)? percentage;
  const MiniPlayer({
    Key? key,
    this.child,
    this.percentage,
    this.playerChild,
    this.collapseChild,
    required this.miniPlayerController,
  }) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    widget.miniPlayerController._playerState = this;
    final range = widget.miniPlayerController.maxHeight -
        widget.miniPlayerController.minHeight;
    final _value = () {
      if (widget.miniPlayerController.startOpen != null &&
          widget.miniPlayerController.startOpen == true) {
        return 1.0;
      } else {
        return 0.0;
      }
    }();
    _controller = AnimationController(
      vsync: this,
      duration: widget.miniPlayerController.animationDuration,
      value: _value,
    )..addListener(() {
        final value = _calCulateSizeWithController(
            widget.miniPlayerController.minHeight,
            widget.miniPlayerController.maxHeight);
        final dragRange = value - widget.miniPlayerController.minHeight;
        final percentage = (dragRange * 100) / range;
        widget.percentage?.call(percentage);
      });
  }

  @override
  void didUpdateWidget(covariant MiniPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.miniPlayerController._playerState = this;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            height: _calCulateSizeWithController(
                widget.miniPlayerController.minHeight,
                widget.miniPlayerController.maxHeight),
            width: max(
                _calCulateSizeWithController(
                    (MediaQuery.of(context).size.width / 100) * 50,
                    MediaQuery.of(context).size.width,
                    // 6.5
                    valueMultiplier: 4.5),
                0),
            // color: Colors.white,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  minHeight:
                                      widget.miniPlayerController.minHeight),
                              child: widget.playerChild ?? const SizedBox()),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onVerticalDragEnd: (e) {
                              widget.miniPlayerController._handleDragEnd(e);
                            },
                            onVerticalDragUpdate: (e) {
                              widget.miniPlayerController._handleDragUpdate(e);
                            },
                            child: const AspectRatio(
                              aspectRatio: 2.0,
                              child: SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _controller.value >= 0.8 ? 1 : 0,
                    child: widget.child ?? const SizedBox(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _calCulateSizeWithController(double minSize, double maxSize,
      {double valueMultiplier = 1}) {
    final result =
        lerpDouble(minSize, maxSize, _controller.value * valueMultiplier)!;
    return result;
  }

  void _toggleOpenClodePanel() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    // _controller.fling(velocity: isOpen ? -1 : 1);
    if (isOpen) {
      widget.miniPlayerController.closeMiniPlayer();
    } else {
      widget.miniPlayerController.openMiniPlayer();
      setState(() {});
    }
  }
}

class MiniPlayerController extends ChangeNotifier {
  final double minHeight;
  final double maxHeight;
  final bool? startOpen;
  final Duration animationDuration;

  MiniPlayerController({
    required this.minHeight,
    required this.maxHeight,
    this.startOpen,
    this.animationDuration = const Duration(seconds: 1),
  }) : _isClosed = startOpen!;

  _MiniPlayerState? _playerState;

  factory MiniPlayerController.nil() {
    return MiniPlayerController(minHeight: 0, maxHeight: 0, startOpen: true);
  }

  @protected
  _MiniPlayerState? get playerState => _playerState;
  // ignore: avoid_setters_without_getters
  set setPlayerState(_MiniPlayerState? _state) {
    _playerState = _state;
  }

  bool? _isClosed;
  bool get isClosed => _isClosed ?? true;

  void closeMiniPlayer() {
    _playerState!._controller.reverse();
    _isClosed = true;
    notifyListeners();
  }

  void openMiniPlayer() {
    _playerState!._controller.forward();
    _isClosed = false;
    notifyListeners();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _playerState!._controller.value -= details.primaryDelta! / maxHeight;
    // notifyListeners();
    // print(_playerState!._calCulateSizeWithController(minHeight, maxHeight));
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_playerState!._controller.isAnimating ||
        _playerState!._controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0) {
      _playerState!._controller.fling(velocity: max(1.0, -flingVelocity));
      _isClosed = false;
    } else if (flingVelocity > 0.0) {
      _playerState!._controller.fling(velocity: min(-1.0, -flingVelocity));
      _isClosed = true;
    } else {
      _playerState!._controller
          .fling(velocity: _playerState!._controller.value < 0.5 ? -1.0 : 1.0);
      if (_playerState!._controller.value < 0.5) {
        _isClosed = true;
      } else {
        _isClosed = false;
      }
    }
    // notifyListeners();
  }
}
