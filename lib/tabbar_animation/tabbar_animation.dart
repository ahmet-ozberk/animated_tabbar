import 'package:flutter/material.dart';

class TabbarAnimation extends StatefulWidget {
  const TabbarAnimation({Key? key}) : super(key: key);

  @override
  State<TabbarAnimation> createState() => _TabbarAnimationState();
}

class _TabbarAnimationState extends State<TabbarAnimation> {
  int _currentIndex = 0;
  double _selectedPositioned = 0;

  final Color _currentColor = Colors.black;

  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();

  _selectedItem(int id) {
    _currentIndex = id;
    GlobalKey selectedKey;

    switch (id) {
      case 0:
        selectedKey = _key1;
        break;
      case 1:
        selectedKey = _key2;
        break;
      case 2:
        selectedKey = _key3;
        break;
      default:
        selectedKey = _key1;
        break;
    }
    _setIndicatorPositioned(selectedKey);
    setState(() {});
  }

  _setIndicatorPositioned(GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    _selectedPositioned = position.dx;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _setIndicatorPositioned(_key1);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabbar Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              width: double.maxFinite,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: textWidget(
                              size: size,
                              globalKey: _key1,
                              valueKey: ValueKey<Color>(_currentIndex == 0
                                  ? Colors.black
                                  : Colors.grey),
                              text: "Tab 1",
                              onTap: () => _selectedItem(0)),
                        ),
                        Expanded(
                          child: textWidget(
                              size: size,
                              globalKey: _key2,
                              valueKey: ValueKey<Color>(_currentIndex == 1
                                  ? Colors.black
                                  : Colors.grey),
                              text: "Tab 2",
                              onTap: () => _selectedItem(1)),
                        ),
                        Expanded(
                          child: textWidget(
                              size: size,
                              globalKey: _key3,
                              valueKey: ValueKey<Color>(_currentIndex == 2
                                  ? Colors.black
                                  : Colors.grey),
                              text: "Tab 3",
                              onTap: () => _selectedItem(2)),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    left: _selectedPositioned,
                    bottom: 0,
                    child: Container(
                      height: 5,
                      width: size.width * 0.13,
                      decoration: ShapeDecoration(
                        shape: const StadiumBorder(),
                        color: Colors.amber.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textWidget({
    required GlobalKey globalKey,
    required ValueKey<Color> valueKey,
    required String text,
    required void Function()? onTap,
    Size? size,
  }) {
    return InkWell(
      key: globalKey,
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: SizedBox(
        width: size!.width * 0.3,
        height: 47,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: Theme.of(context).textTheme.button!.copyWith(
                  color: valueKey.value,
                ),
            textAlign: TextAlign.center,
            child: Text(
              text,
              key: valueKey,
            ),
          ),
        ),
      ),
    );
  }
}
