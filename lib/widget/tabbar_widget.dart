import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class TabBarWidget extends StatelessWidget {
  final String title;
  final List<Tab> tabs;
  final List<Widget> children;

  TabBarWidget({
    Key? key,
    required this.title,
    required this.tabs,
    required this.children,
  }) : super(key: key);

  final List<Map<String, dynamic>> locales = [
    {'name': 'English', 'locale': (Locale('en', 'US'))},
    {'name': 'Korean', 'locale': (Locale('ko', 'KR'))},
    {'name': 'Japanese', 'locale': (Locale('ja', 'JP'))},
    {'name': 'Chinese', 'locale': (Locale('zh', 'CN'))},
  ];

  showLocalDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Choose your language"),
              content: Container(
                // color: Colors.black26,
                width: double.maxFinite,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(locales[index]['name'].toString()),
                    ),
                    onTap: () => updateLocale(
                      locales[index]['locale'],
                      context,
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
                  itemCount: 4,
                ),
              ),
            ));
  }

  updateLocale(Locale locale, BuildContext context) {
    Navigator.of(context).pop();
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
            child: Container(
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2.0),
                  blurRadius: 20.0,
                )
              ]),
              child: NewGradientAppBar(
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.language),
                    onPressed: () => showLocalDialog(context),
                  ),
                ],
                title: Text(
                  title,
                  // 'appbar_title1'.tr,
                  // 제목 들어가는 부분 style: TextStyle(fontSize: 25, color: Colors.white)),
                  style: GoogleFonts.hiMelody(
                      // backgroundColor: Colors.white70,
                      fontStyle: FontStyle.normal,
                      color: Colors.yellow,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                gradient: LinearGradient(
                    colors: const [Colors.transparent, Colors.black54]),
                centerTitle: true,
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.yellowAccent,
                  indicator: BubbleTabIndicator(
                    indicatorHeight: 25.0,
                    indicatorColor: Colors.white,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  tabs: tabs,
                ),
                elevation: 5,
                titleSpacing: 20,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: TabBarView(children: children),
          ),
        ),
      );
}

class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  @override
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight = 20.0,
    this.indicatorColor = Colors.greenAccent,
    this.indicatorRadius = 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding = const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets = const EdgeInsets.symmetric(horizontal: 5.0),
  });

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t)!,
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _BubblePainter createBoxPainter([VoidCallback? onChanged]) {
    return _BubblePainter(this, onChanged);
  }
}

class _BubblePainter extends BoxPainter {
  _BubblePainter(this.decoration, VoidCallback? onChanged) : super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;
  Color get indicatorColor => decoration.indicatorColor;
  double get indicatorRadius => decoration.indicatorRadius;
  EdgeInsetsGeometry get padding => decoration.padding;
  EdgeInsetsGeometry get insets => decoration.insets;
  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    Rect indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    // ignore: unnecessary_new
    return new Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = Offset(
            offset.dx, (configuration.size!.height / 2) - indicatorHeight / 2) &
        Size(configuration.size!.width, indicatorHeight);
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = _indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
        RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)),
        paint);
  }
}
