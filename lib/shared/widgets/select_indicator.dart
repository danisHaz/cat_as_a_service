import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SelectIndicatorInfo {
  enabled,
  disabled,
}

class StatelessSelectIndicator extends StatelessWidget {
  final SelectIndicatorInfo defaultState;
  const StatelessSelectIndicator({
    Key? key,
    this.defaultState = SelectIndicatorInfo.disabled,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: 40,
        height: 40,
        child: CustomPaint(
          painter: OpenPainter(info: defaultState),
        )
      )
    );
  }
}

class SelectIndicator extends StatefulWidget {
  final SelectIndicatorInfo defaultState;
  final void Function()? onPressed;
  const SelectIndicator({
    Key? key,
    this.defaultState = SelectIndicatorInfo.disabled,
    this.onPressed,
  }): super(key: key);

  @override
  SelectIndicatorState createState() => SelectIndicatorState();
}

class SelectIndicatorState extends State<SelectIndicator> {
  SelectIndicatorState(): super();
  late SelectIndicatorInfo _info;

  void onTap() {
    if (widget.onPressed != null) {
      widget.onPressed!();
    }

    setState(() {
      _info = (_info == SelectIndicatorInfo.enabled) ? SelectIndicatorInfo.disabled : SelectIndicatorInfo.enabled;
    });
  }

  @override
  void initState() {
    super.initState();
    _info = widget.defaultState;
  }

  Widget _buildDetector() {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
        setState(() {
          _info = (_info == SelectIndicatorInfo.enabled) ? SelectIndicatorInfo.disabled : SelectIndicatorInfo.enabled;
        });
      },
      child: SizedBox(
        width: 40,
        height: 40,
        child: CustomPaint(
          painter: OpenPainter(info: _info),
        )
      ),
    );
  }

  Widget _buildSimple() {
    return IgnorePointer(
      child: SizedBox(
        width: 40,
        height: 40,
        child: CustomPaint(
          painter: OpenPainter(info: _info),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget.onPressed == null) ? _buildSimple() : _buildDetector();
  }
}

class OpenPainter extends CustomPainter {
  final SelectIndicatorInfo info;

  OpenPainter({required this.info});

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xff4a76e9)
      ..style = PaintingStyle.fill;

    var paint2 = Paint()
      ..color = const Color(0x88ebeae9)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    
    canvas.drawCircle(const Offset(20, 20), 15,
      info == SelectIndicatorInfo.enabled ? paint1 : paint2);
  }
 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}