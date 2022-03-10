import 'package:flutter/widgets.dart';

class CustomFadeTransitionPageRoute extends PageRouteBuilder {
  final int timeCast;
  final Widget child;

  CustomFadeTransitionPageRoute({required this.timeCast, required this.child})
      : super(
            transitionDuration: Duration(seconds: timeCast),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondAnimation) =>
                child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    animation = CurvedAnimation(
        parent: animation, curve: Curves.easeInOut); // or Curves.elasticInOut

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: child,
    );
  }
}

//--------------------------------------------------------------------------------------------

class CustomScaleTransitionPageRoute extends PageRouteBuilder {
  final int timeCast;
  final Widget child;

  CustomScaleTransitionPageRoute({required this.timeCast, required this.child})
      : super(
            transitionDuration: Duration(seconds: timeCast),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondAnimation) =>
                child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    animation = CurvedAnimation(
        parent: animation, curve: Curves.easeInOut); // or Curves.elasticInOut

    return ScaleTransition(
      alignment: Alignment.center,
      scale: animation,
      child: child,
    );
  }
}

//--------------------------------------------------------------------------------------------

class CustomSlideTransitionPageRoute extends PageRouteBuilder {
  final int timeCast;
  final Widget child;

  CustomSlideTransitionPageRoute({required this.timeCast, required this.child})
      : super(
            transitionDuration: Duration(seconds: timeCast),
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondAnimation) =>
                child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    animation = CurvedAnimation(
        parent: animation, curve: Curves.easeInOut); // or Curves.elasticInOut

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
          .animate(animation),
      child: child,
    );
  }
}
