import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/details_screen.dart';

class TabBuilder extends StatelessWidget {
  const TabBuilder({
    required this.future,
    Key? key,
  }) : super(key: key);
  final Future<List<Movie>?> future;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
      child: FutureBuilder<List<Movie>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.6,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.to(DetailsScreen(movie: snapshot.data![index]));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500/${snapshot.data![index].posterPath}',
                    height: 300,
                    width: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 180,
                    ),
                    loadingBuilder: (_, __, ___) {
                      if (___ == null) return __;
                      return const FadeShimmer(
                        width: 180,
                        height: 250,
                        highlightColor: Color(0xff22272f),
                        baseColor: Color(0xff20252d),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
