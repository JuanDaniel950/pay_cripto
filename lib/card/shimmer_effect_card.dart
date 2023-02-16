import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return card(context);
  }

  Widget card(BuildContext context) {
    final card = Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: cardContent(),
    );
    return Stack(
      children: [
        card,
      ],
    );
  }

  Widget cardContent() {
    return Row(
      children: [
        avatar(),
        content(),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            icon(),
          ],
        ),
      ],
    );
  }

  Widget avatar() {
    return Shimmer(
      duration: const Duration(seconds: 3),
      color: Colors.grey[300]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey[100],
        ),
      ),
    );
  }

  Widget content() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Shimmer(
              duration: const Duration(seconds: 3),
              color: Colors.white,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: 200,
                  height: 10,
                  color: Colors.grey[100],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget icon() {
    return Shimmer(
      duration: const Duration(seconds: 3),
      color: Colors.grey[300]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 40,
          height: 40,
          color: Colors.grey[100],
        ),
      ),
    );
  }
}
