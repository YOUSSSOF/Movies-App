import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/api/api_service.dart';
import 'package:movies_app/controllers/bottom_navigator_controller.dart';
import 'package:movies_app/controllers/movies_controller.dart';

import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/review.dart';
import 'package:movies_app/utils/utils.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    ApiService.getMovieReviews(movie.id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Back to home',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detail',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip(
                      message: 'Save this movie to your watch list',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchList(movie);
                        
                        },
                        icon: Obx(
                          () =>
                              Get.find<MoviesController>().isInWatchList(movie)
                                  ? const Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                      size: 33,
                                    )
                                  : const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.white,
                                      size: 33,
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        Api.imageBaseUrl + movie.backdropPath,
                        width: Get.width,
                        height: 250,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, __, ___) {
                          if (___ == null) return __;
                          return FadeShimmer(
                            width: Get.width,
                            height: 250,
                            highlightColor: const Color(0xff22272f),
                            baseColor: const Color(0xff20252d),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/' +
                                movie.posterPath,
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 110,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/Star.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              movie.voteAverage == 0.0
                                  ? 'N/A'
                                  : movie.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: .6,
                child: SizedBox(
                  width: Get.width / 1.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/calender.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.releaseDate.split('-')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Text('|'),
                      Row(
                        children: [
                          SvgPicture.asset('assets/Ticket.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            Utils.getGenres(movie),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'About Movie'),
                            Tab(text: 'Reviews'),
                            Tab(text: 'Cast'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              movie.overview,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                          FutureBuilder<List<Review>?>(
                            future: ApiService.getMovieReviews(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.length == 0
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 30.0),
                                        child: Text(
                                          'No review',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (_, index) => Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/avatar.svg',
                                                    height: 50,
                                                    width: 50,
                                                    // fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    snapshot.data![index].rating
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xff0296E5),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data![index].author,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 250,
                                                    child: Text(snapshot
                                                        .data![index].comment),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              } else {
                                return const Center(
                                  child: Text('Wait...'),
                                );
                              }
                            },
                          ),
                          Container(),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
