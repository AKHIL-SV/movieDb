import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/controller/provider.dart';
import '../components/masked_image.dart';
import '../constants.dart';

class MovieDetailScreen extends StatelessWidget {
  final int index;
  final List? movies;
  const MovieDetailScreen({Key? key, required this.index, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF19191B),
              Color(0xFF19191B),
            ],
          ),
        ),
        child: Consumer<MovieProvider>(
          builder: (context, state, child) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: screenHeight * 0.6,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          state.isloadingCast
                              ? '${Constants.imgUrl}${movies?[index].posterPath}'
                              : 'https://assets.stickpng.com/images/580b57fbd9996e24bc43bbdf.png',
                        ),
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: screenHeight * 0.55,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFF19191B),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.05,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 44,
                            width: 44,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 3, color: Colors.white),
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/icon-back.svg',
                            ),
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 3, color: Colors.white),
                          ),
                          child: SvgPicture.asset('assets/svg/icon-menu.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 9,
                  top: screenHeight * 0.42,
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFE53BB),
                          Color(0xFF09FBD3),
                        ],
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constants.kGreyColor,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Constants.kWhiteColor,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.7,
                    transform:
                        Matrix4.translationValues(0, -screenHeight * 0.05, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(child: SizedBox()),
                        SizedBox(
                          width: screenWidth * 0.72,
                          child: Column(
                            children: [
                              Text(
                                '${movies?[index].title}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Constants.kWhiteColor.withOpacity(
                                    0.85,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight <= 667 ? 10 : 20,
                              ),
                              Text(
                                '2021•Action-Adventure-Fantasy•2h36m',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Constants.kWhiteColor.withOpacity(
                                    0.75,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RatingBar.builder(
                                itemSize: 14,
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Constants.kYellowColor,
                                ),
                                onRatingUpdate: (rating) {
                                  debugPrint(rating.toString());
                                },
                                unratedColor: Constants.kWhiteColor,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                '${movies?[index].overview}',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: screenHeight <= 667 ? 4 : 4,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Constants.kWhiteColor.withOpacity(
                                    0.75,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          height: 2,
                          width: screenWidth * 0.8,
                          color: Constants.kWhiteColor.withOpacity(0.15),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 23,
                          ),
                          // color: Colors.amber,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Casts',
                                    style: TextStyle(
                                      color: Constants.kWhiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight <= 667 ? 10 : 18,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    minRadius: 16,
                                    maxRadius: screenWidth <= 375 ? 24 : 30,
                                    backgroundImage: NetworkImage(
                                      state.isloadingCast &&
                                              state.movieCredit![0]
                                                      .profilePath !=
                                                  null
                                          ? '${Constants.imgUrl}${state.movieCredit?[0].profilePath}'
                                          : 'https://assets.stickpng.com/images/580b57fbd9996e24bc43bbdf.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 50,
                                        maxWidth: 112,
                                      ),
                                      transform:
                                          Matrix4.translationValues(-6, 0, 0),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          const MaskedImage(
                                            asset: Constants.kMaskCast,
                                            mask: Constants.kMaskCast,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${state.movieCredit?[0].originalName}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    minRadius: 16,
                                    maxRadius: screenWidth <= 375 ? 24 : 30,
                                    backgroundImage: NetworkImage(
                                      state.isloadingCast &&
                                              state.movieCredit![1]
                                                      .profilePath !=
                                                  null
                                          ? '${Constants.imgUrl}${state.movieCredit?[1].profilePath}'
                                          : 'https://assets.stickpng.com/images/580b57fbd9996e24bc43bbdf.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 50,
                                        maxWidth: 112,
                                      ),
                                      transform:
                                          Matrix4.translationValues(-6, 0, 0),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          const MaskedImage(
                                            asset: Constants.kMaskCast,
                                            mask: Constants.kMaskCast,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${state.movieCredit?[1].originalName}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    minRadius: 16,
                                    maxRadius: screenWidth <= 375 ? 24 : 30,
                                    backgroundImage: NetworkImage(
                                      state.isloadingCast &&
                                              state.movieCredit![2]
                                                      .profilePath !=
                                                  null
                                          ? '${Constants.imgUrl}${state.movieCredit?[2].profilePath}'
                                          : 'https://assets.stickpng.com/images/580b57fbd9996e24bc43bbdf.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 50,
                                        maxWidth: 112,
                                      ),
                                      transform:
                                          Matrix4.translationValues(-6, 0, 0),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          const MaskedImage(
                                            asset: Constants.kMaskCast,
                                            mask: Constants.kMaskCast,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${state.movieCredit?[2].originalName}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    minRadius: 16,
                                    maxRadius: screenWidth <= 375 ? 24 : 30,
                                    backgroundImage: NetworkImage(
                                      state.isloadingCast &&
                                              state.movieCredit![3]
                                                      .profilePath !=
                                                  null
                                          ? '${Constants.imgUrl}${state.movieCredit?[3].profilePath}'
                                          : 'https://assets.stickpng.com/images/580b57fbd9996e24bc43bbdf.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxHeight: 50,
                                        maxWidth: 112,
                                      ),
                                      transform:
                                          Matrix4.translationValues(-6, 0, 0),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          const MaskedImage(
                                            asset: Constants.kMaskCast,
                                            mask: Constants.kMaskCast,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '${state.movieCredit?[3].originalName}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
