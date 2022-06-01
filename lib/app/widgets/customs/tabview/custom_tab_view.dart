import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'nav_button.dart';
import 'nav_custom_painter.dart';

typedef _LetIndexPage = bool Function(int value);

class CustomTabView extends StatefulWidget {
  final List<String> titles;
  final List<Widget> pages;
  final int index;
  final Color color;
  final Color? buttonBackgroundColor;
  final Color backgroundColor;
  final ValueChanged<int>? onTap;
  final _LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;


  CustomTabView({
    Key? key,
    required this.titles,
    required this.pages,
    this.index = 0,

    this.color = Colors.white,

    this.buttonBackgroundColor,
    this.backgroundColor = Colors.blueAccent,
    this.onTap,
    _LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 300),
    this.height = 75.0,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(titles.isNotEmpty),
        assert(pages.isNotEmpty),
        assert(0 <= index && index < pages.length),
        assert(0 <= index && index < titles.length),
        assert(pages.length == titles.length),
        assert(0 <= height && height <= 75.0),
        super(key: key);

  @override
  CustomTabViewState createState() => CustomTabViewState();
}

class CustomTabViewState extends State<CustomTabView> with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late AnimationController _animationController;
  late int _length;

  int get currentIndex => _endingIndex;
  // final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _icon = const SizedBox();
    _length = widget.titles.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.titles.length;
        final middle = (endingPos + _startingPos) / 2;

        _buttonHide = (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CustomTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition, duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: widget.titles.map((title) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    _buttonTap(widget.titles.indexOf(title));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 12),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: widget.titles.indexOf(title) == _endingIndex ? Colors.white : Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          Container(
            color: widget.backgroundColor,
            height: widget.height,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Positioned(
                  bottom: -40 - (75.0 - widget.height),
                  left: Directionality.of(context) == TextDirection.rtl ? null : _pos * size.width,
                  right: Directionality.of(context) == TextDirection.rtl ? _pos * size.width : null,
                  width: size.width / _length,
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        -(1 - _buttonHide) * 90,
                      ),
                      child: Material(
                        color: widget.buttonBackgroundColor ?? widget.color,
                        type: MaterialType.circle,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: _icon,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0 - (75.0 - widget.height),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    child: CustomPaint(
                      painter: NavCustomPainter(_pos, _length, widget.color, Directionality.of(context)),
                      child: Container(
                        height: 64.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0 - (75.0 - widget.height),
                  child: SizedBox(
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.titles.map((item) {
                        return NavButton(
                          position: _pos,
                          length: _length,
                          index: widget.titles.indexOf(item),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: PageTransitionSwitcher(
                duration: const Duration(seconds: 1),
                reverse: false,
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    child: child,
                    animation: animation,
                    fillColor: Colors.white,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                  );
                },
                child: widget.pages[_endingIndex],
              ),
            ),
          ),
          // Expanded(
          //   child: PageView(
          //     controller: _pageController,
          //     physics: const NeverScrollableScrollPhysics(),
          //     children: widget.pages,
          //   ),
          // )
        ],
      ),
    );
  }

  void setPage(int index) {
    print(index);
    _buttonTap(index);
  }

  void _buttonTap(int index) {


    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition, duration: widget.animationDuration, curve: widget.animationCurve);
      // _pageController.jumpToPage(index);
    });
  }
}
