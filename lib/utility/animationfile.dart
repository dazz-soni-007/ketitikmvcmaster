/*
import 'package:flutter/cupertino.dart';

class _SlideInOutWidgetState extends State<SlideInOutWidget>
    with SingleTickerProviderStateMixin {
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.elasticOut;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(startPos, 0), end: Offset(endPos, 0)),
      duration: Duration(seconds: 1),
      curve: curve,
      builder: (context, offset, child) {
        return FractionalTranslation(
          translation: offset,
          child: Container(
            width: double.infinity,
            child: Center(
              child: child,
            ),
          ),
        );
      },
      child: Text(
        'animated text',
        textScaleFactor: 3.0,
      ),
      onEnd: () {
        print('onEnd');
        Future.delayed(
          Duration(milliseconds: 500),
          () {
            curve = curve == Curves.elasticOut
                ? Curves.elasticIn
                : Curves.elasticOut;
            if (startPos == -1) {
              setState(() {
                startPos = 0.0;
                endPos = 1.0;
              });
            }
          },
        );
      },
    );
  }
}
*/
