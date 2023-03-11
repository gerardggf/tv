import 'package:flutter/material.dart';

import '../../domain/models/media/media.dart';
import '../routes/routes.dart';

//TODO: pendiente implementar navegación a pantalla con series
Future<void> goToMediaDetails(BuildContext context, Media media) async {
  if (media.type == MediaType.movie) {
    await Navigator.pushNamed(
      context,
      Routes.movie,
      arguments: media.id,
    );
  }
}
