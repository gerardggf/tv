import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global/widgets/request_fail.dart';
import '../../controller/home_controller.dart';
import '../../controller/state/home_state.dart';
import 'trending_tile.dart';
import 'trending_time_window.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = context.watch();
    final moviesAndSeries = controller.state.moviesAndSeries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrendingTimeWindow(
          timeWindow: moviesAndSeries.timeWindow,
          onChanged: controller.onTimeWindowChanged,
        ),
        const SizedBox(
          height: 10,
        ),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.65;
              return Center(
                child: moviesAndSeries.when(
                  loading: (_) => const CircularProgressIndicator(),
                  failed: (_) => RequestFail(
                    onRetry: () {
                      controller.loadMoviesAndSeries(
                        moviesAndSeries: MoviesAndSeriesState.loading(
                          moviesAndSeries.timeWindow,
                        ),
                      );
                    },
                  ),
                  loaded: (_, list) => ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: ((context, index) {
                      final media = list[index];
                      return TrendingTile(
                        media: media,
                        width: width,
                      );
                    }),
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
