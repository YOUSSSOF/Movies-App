import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/controllers/bottom_navigator_controller.dart';
import 'package:movies_app/controllers/search_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/details_screen.dart';
import 'package:movies_app/utils/utils.dart';
import 'package:movies_app/widgets/infos.dart';
import 'package:movies_app/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Back to home',
                  onPressed: () =>
                      Get.find<BottomNavigatorController>().setIndex(0),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Search',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
                const Tooltip(
                  message: 'Search your wanted movie here !',
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SearchBox(
              onSumbit: () {
                String search =
                    Get.find<SearchController>().searchController.text;
                Get.find<SearchController>().searchController.text = '';
                Get.find<SearchController>().search(search);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(
              height: 34,
            ),
            Obx(
              (() => Get.find<SearchController>().isLoading.value
                  ? const CircularProgressIndicator()
                  : Get.find<SearchController>().foundedMovies.isEmpty
                      ? SizedBox(
                          width: Get.width / 1.5,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 120,
                              ),
                              SvgPicture.asset(
                                'assets/no.svg',
                                height: 120,
                                width: 120,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'We Are Sorry, We Can Not Find The Movie :(',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  wordSpacing: 1,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Opacity(
                                opacity: .8,
                                child: Text(
                                  'Find your movie by Type title, categories, years, etc ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          itemCount:
                              Get.find<SearchController>().foundedMovies.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 24),
                          itemBuilder: (_, index) {
                            Movie movie = Get.find<SearchController>()
                                .foundedMovies[index];
                            return GestureDetector(
                              onTap: () => Get.to(DetailsScreen(movie: movie)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      Api.imageBaseUrl + movie.posterPath,
                                      height: 180,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(
                                        Icons.broken_image,
                                        size: 120,
                                      ),
                                      loadingBuilder: (_, __, ___) {
                                        if (___ == null) return __;
                                        return const FadeShimmer(
                                          width: 120,
                                          height: 180,
                                          highlightColor: Color(0xff22272f),
                                          baseColor: Color(0xff20252d),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Infos(movie: movie)
                                ],
                              ),
                            );
                          })),
            ),
          ],
        ),
      ),
    );
  }
}
