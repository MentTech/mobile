import 'dart:ui';

import 'package:flutter/material.dart';

class HeroPopupRoute<T> extends StatefulWidget {
  HeroPopupRoute(
      {Key? key,
      required this.sourceChild,
      required this.destinationChild,
      required this.callback,
      bool? isUseMaterialWidget,
      EdgeInsetsGeometry? marginSourceCard,
      EdgeInsetsGeometry? marginDestinationCard,
      double? elelvationSourceCard,
      double? elelvationDestinationCard,
      BorderRadius? borderRadiusSourceCard,
      BorderRadius? borderRadiusDestinationCard,
      Color? colorSourceCard,
      Color? colorDestinationCard})
      : _marginSourceCard =
            marginSourceCard ?? const EdgeInsets.symmetric(horizontal: 20),
        _marginDestinationCard = marginDestinationCard ??
            const EdgeInsets.symmetric(horizontal: 30, vertical: 300),
        _elelvationSourceCard = elelvationSourceCard ?? 10,
        _elelvationDestinationCard = elelvationDestinationCard ?? 10,
        _borderRadiusSourceCard =
            borderRadiusSourceCard ?? BorderRadius.circular(10),
        _borderRadiusDestinationCard =
            borderRadiusDestinationCard ?? BorderRadius.circular(10),
        _colorSourceCard = colorSourceCard ?? Colors.white,
        _colorDestinationCard = colorDestinationCard ?? Colors.white,
        isUseMaterial = isUseMaterialWidget ?? true,
        super(key: key);

  final ValueChanged<T?> callback;
  final Widget sourceChild;
  final Widget destinationChild;

  final EdgeInsetsGeometry _marginSourceCard;
  final EdgeInsetsGeometry _marginDestinationCard;

  final double _elelvationSourceCard;
  final double _elelvationDestinationCard;

  final BorderRadius _borderRadiusSourceCard;
  final BorderRadius _borderRadiusDestinationCard;

  final Color _colorSourceCard;
  final Color _colorDestinationCard;

  final bool isUseMaterial;

  @override
  _HeroPopupRouteState<T> createState() => _HeroPopupRouteState<T>();
}

class _HeroPopupRouteState<T> extends State<HeroPopupRoute<T>> {
  final UniqueKey _uniqueKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget._marginSourceCard,
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context)
              .push(HeroDialogRoute<T>(
                  builder: (context) => Padding(
                      padding: widget._marginDestinationCard,
                      child: Hero(
                          tag: _uniqueKey,
                          createRectTween: (begin, end) =>
                              CustomRectTween(begin: begin!, end: end!),
                          child: Material(
                            color: widget._colorDestinationCard,
                            elevation: widget._elelvationDestinationCard,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    widget._borderRadiusDestinationCard),
                            child: widget.destinationChild,
                          )))))
              .then((index) {
            widget.callback.call(index);
          });
        },
        child: Hero(
          tag: _uniqueKey,
          createRectTween: (begin, end) =>
              CustomRectTween(begin: begin!, end: end!),
          child: widget.isUseMaterial
              ? Material(
                  color: widget._colorSourceCard,
                  elevation: widget._elelvationSourceCard,
                  shape: RoundedRectangleBorder(
                      borderRadius: widget._borderRadiusSourceCard),
                  child: widget.sourceChild,
                )
              : widget.sourceChild,
        ),
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute(
      {required WidgetBuilder builder,
      RouteSettings? settings,
      bool fullScreenDialog = false})
      : _builder = builder,
        super(fullscreenDialog: fullScreenDialog, settings: settings);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false; // is not show background

  @override
  Color? get barrierColor => Colors.black38; // color behide popup

  @override
  bool get barrierDismissible => true; // dismiss when tap outside

  @override
  String? get barrierLabel => 'Popup dialog open'; //

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}

class CustomRectTween extends RectTween {
  CustomRectTween({required Rect begin, required Rect end})
      : super(begin: begin, end: end);

  @override
  Rect? lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);

    return Rect.fromLTRB(
        lerpDouble(begin!.left, end!.left, elasticCurveValue)!,
        lerpDouble(begin!.top, end!.top, elasticCurveValue)!,
        lerpDouble(begin!.right, end!.right, elasticCurveValue)!,
        lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue)!);
  }
}
