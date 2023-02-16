import 'package:flutter/material.dart';
import 'package:pay_crypto/model/notification_model.dart';
import 'package:pay_crypto/utils/resolve_img.dart' as img_cache;

// esto se puede modificar a un staless widget
class NotificationCard extends StatefulWidget {
  final NotificationModel notificationModel;
  final Function onTap;

  const NotificationCard(
      {super.key, required this.notificationModel, required this.onTap});

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return card(context);
  }

  Widget card(BuildContext context) {
    final cardTemplate = SizedBox(
      height: 120,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            avatar(),
            content(),
          ],
        ),
      ),
    );
    return Stack(
      children: [
        cardTemplate,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10.0),
              onTap: () => widget.onTap(),
            ),
          ),
        ),
      ],
    );
  }

  Widget avatar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
      ),
      child: img_cache.fadeImg(
        widget.notificationModel.img,
        width: 120,
        height: 120,
      ),
    );
  }

  Widget content() {
    return Expanded(
      child: Container(
        height: 110,
        padding: const EdgeInsets.only(left: 10.0, top: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Text(
              widget.notificationModel.hint,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              widget.notificationModel.detail,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 12.0,
                overflow: TextOverflow.visible,
              ),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
