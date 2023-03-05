import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget with PreferredSizeWidget {
  const FavoritesAppBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: const TextStyle(color: Colors.black),
      centerTitle: true,
      title: const Text('Favorites'),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      bottom: TabBar(
        padding: const EdgeInsets.symmetric(vertical: 10),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black,
        indicator: const _Decoration(color: Colors.blue, width: 20),
        tabs: const [
          Tab(
            text: 'Movies',
          ),
          Tab(
            text: 'Series',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  final Color color;
  final double width;

  const _Decoration({
    required this.color,
    required this.width,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _Painter(color, width);
}

class _Painter extends BoxPainter {
  final Color color;
  final double width;

  _Painter(
    this.color,
    this.width,
  );

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * 0.5 + offset.dx - width * 0.5,
            size.height * 0.9,
            width,
            width * 0.3,
          ),
          const Radius.circular(4),
        ),
        paint);
  }
}
