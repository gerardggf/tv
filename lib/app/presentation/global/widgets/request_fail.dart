import 'package:flutter/material.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/translations.g.dart';

class RequestFail extends StatelessWidget {
  const RequestFail({
    super.key,
    required this.onRetry,
    this.text,
  });

  final VoidCallback onRetry;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Column(
        children: [
          Expanded(
            child: Assets.svg.error.svg(),
          ),
          Text(text ?? texts.misc.requestFailed),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blue,
            child: Text(texts.misc.retry),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
