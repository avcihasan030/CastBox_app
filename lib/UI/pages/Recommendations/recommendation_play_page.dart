import 'package:final_year_project/DATA/Ads/admob_service.dart';
import 'package:final_year_project/DATA/State_Management/widget_providers/favorite_track_names_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:like_button/like_button.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayRecommendations extends ConsumerStatefulWidget {
  final String name;
  final artists;
  final bool isFavorite;
  const PlayRecommendations(this.name, this.artists, this.isFavorite,
      {super.key});

  @override
  ConsumerState createState() => _PlayRecommendationsState();
}

class _PlayRecommendationsState extends ConsumerState<PlayRecommendations> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late PaletteGenerator _paletteGenerator;
  Color appBarColor = Colors.transparent;
  Color containerBackgroundColor = Colors.transparent;
  BannerAd? _bannerAd;
  final coverImagePath = "images/coverimage.jpeg";

  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double currentPosition = 0.0;
  double? maxPosition;

  void _initializeAudioPlayer() async {
    String filePath = "assets/audios/japandailynews_2023-05-10.mp3";
    await _audioPlayer.setAsset(filePath);
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: AdMobService.appIdTest,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudioPlayer();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => findAppBarColor(coverImagePath),
    );
    maxPosition = _audioPlayer.duration?.inSeconds.toDouble();
    debugPrint(maxPosition as String?);
    _createBannerAd();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: containerBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.share))
              ],
              expandedHeight: 370.0,
              floating: true,
              pinned: true,
              title: Text(widget.name),
              snap: false,
              backgroundColor: appBarColor,
              flexibleSpace: FlexibleSpaceBar(
                background: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      color: containerBackgroundColor,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 220,
                            height: 220,
                            child: Image.asset(
                              fit: BoxFit.fill,
                              coverImagePath,
                              colorBlendMode: BlendMode.difference,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 2,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  color: containerBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        2,
                        (index) => _buildDotIndicator(index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16, right: 24, left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          _buildLikeButton(widget.isFavorite),
                          Expanded(
                              child: ListTile(
                            title: Text(
                              widget.artists.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder<Duration>(
                        stream: _audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            currentPosition =
                                snapshot.data!.inSeconds.toDouble();
                          }
                          return Slider(
                            activeColor: Colors.black45,
                            inactiveColor: Colors.white,
                            value: currentPosition,
                            onChanged: (value) {
                              setState(() {
                                currentPosition = value;
                                _audioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                              });
                            },
                            min: 0.0,
                            max: _audioPlayer.duration?.inSeconds.toDouble() ??
                                100.0,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (currentPosition >= 10) {
                                _audioPlayer.seek(Duration(
                                    seconds: currentPosition.toInt() - 10));
                              }
                            },
                            icon: const Icon(Icons.fast_rewind, size: 32),
                          ),
                          IconButton(
                            onPressed: () {
                              if (isPlaying) {
                                _audioPlayer.pause();
                              } else {
                                _audioPlayer.play();
                              }
                              setState(() {
                                isPlaying = !isPlaying;
                              });
                            },
                            icon: isPlaying
                                ? const Icon(
                                    Icons.pause,
                                    size: 32,
                                  )
                                : const Icon(
                                    Icons.play_arrow,
                                    size: 32,
                                  ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (maxPosition != null && currentPosition <= (maxPosition! - 10)) {
                                _audioPlayer.seek(Duration(
                                    seconds: currentPosition.toInt() + 10));
                              }
                            },
                            icon: const Icon(
                              Icons.fast_forward,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      _bannerAd == null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 40),
                              child: Container(
                                height: 135,
                                width: 180,
                                child: const Center(
                                  child: Text("if banner is null"),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 40),
                              child: Container(
                                height: 120,
                                width: 180,
                                child: Center(
                                  child: AdWidget(ad: _bannerAd!),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              }, childCount: 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.white : Colors.grey,
      ),
    );
  }

  Future<void> findAppBarColor(String imageUrl) async {
    _paletteGenerator =
        await PaletteGenerator.fromImageProvider(AssetImage(imageUrl));
    setState(() {
      appBarColor =
          containerBackgroundColor = _paletteGenerator.lightMutedColor!.color;
    });
  }

  _buildLikeButton(bool isFavorite) {
    return SizedBox(
      height: 50,
      width: 50,
      child: LikeButton(
        isLiked: widget.isFavorite,
        size: 28,
        circleColor:
            const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Color(0xff33b5e5),
          dotSecondaryColor: Color(0xff0099cc),
        ),
        onTap: (isLiked) async {
          ref
              .read(favoriteTrackNamesProvider.notifier)
              .toggleFavoriteTrackNames(widget.name);
          return !isLiked;
        },
      ),
    );
  }
}
