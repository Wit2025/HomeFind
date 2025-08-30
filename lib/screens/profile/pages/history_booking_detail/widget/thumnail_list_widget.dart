import 'package:flutter/material.dart';

class ThumbnailListWidget extends StatefulWidget {
  final List<String> images;
  final int currentIndex;
  final Function(int) onThumbnailTap;

  const ThumbnailListWidget({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.onThumbnailTap,
  });

  @override
  State<ThumbnailListWidget> createState() => _ThumbnailListWidgetState();
}

class _ThumbnailListWidgetState extends State<ThumbnailListWidget> {
  final ScrollController _thumbnailScrollController = ScrollController();

  @override
  void dispose() {
    _thumbnailScrollController.dispose();
    super.dispose();
  }

  void scrollToIndex(int index) {
    if (_thumbnailScrollController.hasClients) {
      const double thumbnailWidth = 92.0;
      final double targetOffset = index * thumbnailWidth;
      final double maxScrollExtent =
          _thumbnailScrollController.position.maxScrollExtent;
      final double viewportWidth = MediaQuery.of(context).size.width;

      double centeredOffset =
          targetOffset - (viewportWidth / 2) + (thumbnailWidth / 2);
      centeredOffset = centeredOffset.clamp(0.0, maxScrollExtent);

      _thumbnailScrollController.animateTo(
        centeredOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void didUpdateWidget(ThumbnailListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToIndex(widget.currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        controller: _thumbnailScrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          bool isSelected = index == widget.currentIndex;
          return GestureDetector(
            onTap: () => widget.onThumbnailTap(index),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 80,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 3,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    if (isSelected)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}