import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/controller/provider.dart';
import 'package:tmdb/screens/movie_detail_screen.dart';
import 'package:widget_mask/widget_mask.dart';
import '../components/search_field_widget.dart';
import '../constants.dart';
import '../model/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<MovieProvider>().getMoviedata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Constants.kBlackColor,
      extendBody: true,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            Positioned(
              top: -100,
              left: -100,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kGreenColor.withOpacity(0.5),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.4,
              right: -88,
              child: Container(
                height: 166,
                width: 166,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kPinkColor.withOpacity(0.5),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 166,
                    width: 166,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -100,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kCyanColor.withOpacity(0.5),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 200,
                    sigmaY: 200,
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Consumer<MovieProvider>(
                builder: (context, state, child) {
                  return ListView(
                    primary: true,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'What would you\nlike to watch?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          color: Constants.kWhiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SearchFieldWidget(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 39,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'New movies',
                          style: TextStyle(
                            color: Constants.kWhiteColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trendingmovie?.results.length,
                          itemBuilder: (context, index) {
                            String mask;
                            if (index == 0) {
                              mask = Constants.kMaskFirstIndex;
                            } else if (index == 19) {
                              mask = Constants.kMaskLastIndex;
                            } else {
                              mask = Constants.kMaskCenter;
                            }
                            return GestureDetector(
                              onTap: () async {
                                await state.getMovieCreditdata(
                                    state.trendingmovie!.results[index].id);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      index: index,
                                      movies: state.trendingmovie?.results,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: index == 0 ? 20 : 0,
                                ),
                                height: 160,
                                width: 142,
                                child: WidgetMask(
                                  blendMode: BlendMode.dstATop,
                                  childSaveLayer: true,
                                  mask: Image.asset(mask),
                                  child: Image.network(
                                    state.isloading
                                        ? '${Constants.imgUrl}${state.trendingmovie?.results[index].posterPath}'
                                        : 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Upcoming movies',
                          style: TextStyle(
                            color: Constants.kWhiteColor,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.upcomingmovie?.results.length,
                          itemBuilder: (context, index) {
                            String mask;
                            if (index == 0) {
                              mask = Constants.kMaskFirstIndex;
                            } else if (index == 19) {
                              mask = Constants.kMaskLastIndex;
                            } else {
                              mask = Constants.kMaskCenter;
                            }
                            return GestureDetector(
                              onTap: () async {
                                await state.getMovieCreditdata(
                                    state.upcomingmovie!.results[index].id);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      index: index,
                                      movies: state.upcomingmovie?.results,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: index == 0 ? 20 : 0,
                                ),
                                height: 160,
                                width: 142,
                                child: WidgetMask(
                                  blendMode: BlendMode.dstATop,
                                  childSaveLayer: true,
                                  mask: Image.asset(mask),
                                  child: Image.network(
                                    state.isloading
                                        ? '${Constants.imgUrl}${state.upcomingmovie?.results[index].posterPath}'
                                        : 'https://upload.wikimedia.org/wikipedia/commons/5/59/Empty.png?20091205084734',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 64,
        width: 64,
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Constants.kPinkColor.withOpacity(0.2),
              Constants.kGreenColor.withOpacity(0.2)
            ],
          ),
        ),
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Constants.kPinkColor,
                Constants.kGreenColor,
              ],
            ),
          ),
          child: RawMaterialButton(
            onPressed: () {},
            shape: const CircleBorder(),
            fillColor: const Color(0xff404c57),
            child: SvgPicture.asset(Constants.kIconPlus),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GlassmorphicContainer(
        width: screenWidth,
        height: 50,
        borderRadius: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Constants.kWhiteColor.withOpacity(0.1),
            Constants.kWhiteColor.withOpacity(0.1),
          ],
        ),
        border: 0,
        blur: 30,
        borderGradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Constants.kPinkColor,
            Constants.kGreenColor,
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          notchMargin: 4,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Constants.kIconHome,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Constants.kIconPlayOnTv,
                  ),
                ),
              ),
              const Expanded(
                child: Text(''),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Constants.kIconCategories,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Constants.kIconDownload,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
