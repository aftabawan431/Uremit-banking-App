import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/tabview/nav_button.dart';
import 'package:uremit/app/widgets/customs/tabview/nav_custom_painter.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/manager/payment_wrapper_view_model.dart';



typedef _LetIndexPage = bool Function(int value);

class CustomPaymentTabBar extends StatefulWidget {
 static late AnimationController animationController;


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
  bool isPaymentPage;

  CustomPaymentTabBar({
    Key? key,
    required this.titles,
    required this.pages,
    this.index = 0,

    this.color = Colors.white,
    this.isPaymentPage=false,
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
  CustomPaymentTabBarState createState() => CustomPaymentTabBarState();
}

class CustomPaymentTabBarState extends State<CustomPaymentTabBar> with SingleTickerProviderStateMixin {




  double _buttonHide = 0;
  late Widget _icon;



  int get currentIndex => context.read<PaymentWrapperViewModel>().endingIndex;
  // final PageController _pageController = PageController();



  @override
  void initState() {
    super.initState();
    var provider=Provider.of<PaymentWrapperViewModel>(context,listen: false);
    _icon = const SizedBox();
    provider.setInitial();
    provider.length = widget.titles.length;
    provider.pos = widget.index / provider.length;
    provider.startingPos = widget.index / provider.length;
    provider.animationCurve=widget.animationCurve;
    provider.animationDuration=widget.animationDuration;
    CustomPaymentTabBar.animationController = AnimationController(vsync: this, value:  provider.pos);
    CustomPaymentTabBar.animationController.addListener(() {
      setState(() {
        provider.pos = CustomPaymentTabBar.animationController.value;
        final endingPos =  provider.endingIndex / widget.titles.length;
        final middle = (endingPos + provider.startingPos) / 2;

        _buttonHide = (1 - ((middle -  provider.pos) / (provider.startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CustomPaymentTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      var provider=Provider.of<PaymentWrapperViewModel>(context,listen: false);

      final newPosition = widget.index / provider.length;
      provider.startingPos =  provider.pos;
      provider.endingIndex = widget.index;
      CustomPaymentTabBar.animationController.animateTo(newPosition, duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    CustomPaymentTabBar.animationController.dispose();
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


                    context.read<PaymentWrapperViewModel>().buttonTap(widget.titles.indexOf(title));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 12),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: widget.titles.indexOf(title) ==  context.read<PaymentWrapperViewModel>().pos ? Colors.white : Colors.white70, fontWeight: FontWeight.bold),
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
                  left: Directionality.of(context) == TextDirection.rtl ? null : context.read<PaymentWrapperViewModel>().pos * size.width,
                  right: Directionality.of(context) == TextDirection.rtl ? context.read<PaymentWrapperViewModel>().pos * size.width : null,
                  width: size.width / context.read<PaymentWrapperViewModel>().length,
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
                      painter: NavCustomPainter(context.read<PaymentWrapperViewModel>().pos, context.read<PaymentWrapperViewModel>().length, widget.color, Directionality.of(context)),
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
                          position: context.read<PaymentWrapperViewModel>().pos,
                          length: context.read<PaymentWrapperViewModel>().length,
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
                child: widget.pages[context.read<PaymentWrapperViewModel>().endingIndex],
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
    context.read<PaymentWrapperViewModel>().buttonTap(index);
  }
  void printSample (){
    print("Sample text");
  }
  void buttonTap(int index) {


    if (!widget.letIndexChange(index)) {
      return;
    }
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    final newPosition = index / context.read<PaymentWrapperViewModel>().length;
    setState(() {
      context.read<PaymentWrapperViewModel>().startingPos = context.read<PaymentWrapperViewModel>().pos;
      context.read<PaymentWrapperViewModel>().endingIndex = index;
      CustomPaymentTabBar.animationController.animateTo(newPosition, duration: widget.animationDuration, curve: widget.animationCurve);
      // _pageController.jumpToPage(index);
    });
  }

}
