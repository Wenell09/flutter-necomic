import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/characters/chara_bloc.dart';
import 'package:flutter_komik/bloc/detail_comic/detail_comic_bloc.dart';
import 'package:flutter_komik/bloc/favorites/favorites_bloc.dart';
import 'package:flutter_komik/bloc/recommendations/recom_bloc.dart';
import 'package:flutter_komik/bloc/reviews/review_bloc.dart';
import 'package:flutter_komik/bloc/save_userId/save_user_id_bloc.dart';
import 'package:flutter_komik/bloc/star/star_bloc.dart';
import 'package:flutter_komik/bloc/theme/theme_bloc.dart';
import 'package:flutter_komik/bloc/user/user_bloc.dart';
import 'package:flutter_komik/repository/comic_repo.dart';
import 'package:flutter_komik/repository/review_repo.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatelessWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final inputReview = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DetailComicBloc(ComicRepo())..add(GetDetail(id: id)),
        ),
        BlocProvider(
          create: (context) =>
              CharaBloc(ComicRepo())..add(GetCharacters(id: id)),
        ),
        BlocProvider(
          create: (context) => RecomBloc(ComicRepo())..add(GetRecom(id: id)),
        ),
        BlocProvider(create: (context) => StarBloc()),
        BlocProvider(
          create: (context) => ReviewBloc(ReviewRepo()),
        ),
      ],
      child: BlocListener<DetailComicBloc, DetailComicState>(
        listener: (context, state) {
          if (state is DetailComicLoaded) {
            context
                .read<ReviewBloc>()
                .add(GetReview(title: state.detailComic.englishTitle));
          }
        },
        child: BlocBuilder<DetailComicBloc, DetailComicState>(
          builder: (context, state) {
            if (state is DetailComicLoading) {
              return const ScaffoldShimmerLoading();
            } else if (state is DetailComicLoaded) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(310),
                        child: AppBar(
                          title: const Text(
                            "Community",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          centerTitle: true,
                          flexibleSpace: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 55, left: 20, right: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      state.detailComic.images,
                                      fit: BoxFit.cover,
                                      width: 140,
                                      height: 200,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.detailComic.englishTitle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: (state
                                                            .detailComic.type ==
                                                        "Manga")
                                                    ? Colors.blue
                                                    : (state.detailComic.type ==
                                                            "Manhwa")
                                                        ? Colors.red[700]
                                                        : (state.detailComic
                                                                    .type ==
                                                                "Manhua")
                                                            ? Colors.orange[700]
                                                            : (state.detailComic
                                                                        .type ==
                                                                    "Novel")
                                                                ? Colors
                                                                    .green[700]
                                                                : Colors.purple[
                                                                    700],
                                              ),
                                              child: Text(
                                                state.detailComic.type,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "  • ${formatMonth(state.detailComic.publishedWhen)}",
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "★ ${convertScoreToRating(state.detailComic.score)} Community Rating",
                                          style: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "${state.detailComic.members} Reading Members",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        BlocBuilder<SaveUserIdBloc,
                                            SaveUserIdState>(
                                          builder: (context, saveState) {
                                            if (saveState is SaveUserLoaded) {
                                              return BlocListener<FavoritesBloc,
                                                  FavoritesState>(
                                                listener: (context, state) {
                                                  if (state
                                                          is FavoritesAddSuccess ||
                                                      state
                                                          is FavoritesDeleteSuccess) {
                                                    context
                                                        .read<FavoritesBloc>()
                                                        .add(GetFavorites(
                                                            userId: saveState
                                                                .userId));
                                                  }
                                                },
                                                child: BlocBuilder<
                                                    FavoritesBloc,
                                                    FavoritesState>(
                                                  builder:
                                                      (context, favoriteState) {
                                                    if (favoriteState
                                                        is FavoritesLoaded) {
                                                      final isFavorite =
                                                          favoriteState
                                                              .favorites
                                                              .any((data) =>
                                                                  data.userId ==
                                                                      saveState
                                                                          .userId &&
                                                                  data.malId ==
                                                                      id);
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (isFavorite) {
                                                            context
                                                                .read<
                                                                    FavoritesBloc>()
                                                                .add(
                                                                  DeleteFavorites(
                                                                    userId: saveState
                                                                        .userId,
                                                                    malId: id,
                                                                  ),
                                                                );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration:
                                                                    Duration(
                                                                  seconds: 1,
                                                                ),
                                                                content: Text(
                                                                  "Success delete from my favorite comics!",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            context
                                                                .read<
                                                                    FavoritesBloc>()
                                                                .add(
                                                                  AddFavorites(
                                                                    userId: saveState
                                                                        .userId,
                                                                    malId: id,
                                                                    title: state
                                                                        .detailComic
                                                                        .englishTitle,
                                                                    images: state
                                                                        .detailComic
                                                                        .images,
                                                                    type: state
                                                                        .detailComic
                                                                        .type,
                                                                    publishedWhen: state
                                                                        .detailComic
                                                                        .publishedWhen,
                                                                  ),
                                                                );
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration:
                                                                    Duration(
                                                                  seconds: 1,
                                                                ),
                                                                content: Text(
                                                                  "Success add to my favorite comics!",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child:
                                                            FavoriteContainer(
                                                          color: (isFavorite)
                                                              ? Colors.green
                                                              : Colors.blue,
                                                          text: (isFavorite)
                                                              ? "Delete Favorite"
                                                              : "Add Favorite",
                                                        ),
                                                      );
                                                    }
                                                    return GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                FavoritesBloc>()
                                                            .add(AddFavorites(
                                                              userId: saveState
                                                                  .userId,
                                                              malId: id,
                                                              title: state
                                                                  .detailComic
                                                                  .englishTitle,
                                                              images: state
                                                                  .detailComic
                                                                  .images,
                                                              type: state
                                                                  .detailComic
                                                                  .type,
                                                              publishedWhen: state
                                                                  .detailComic
                                                                  .publishedWhen,
                                                            ));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            duration: Duration(
                                                              seconds: 1,
                                                            ),
                                                            content: Text(
                                                              "Success add to my favorite comics!",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child:
                                                          const FavoriteContainer(
                                                              text:
                                                                  "Add Favorite",
                                                              color:
                                                                  Colors.blue),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                            return GestureDetector(
                                              onTap: () => showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  content: const Text(
                                                    "You must Login!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              child: const FavoriteContainer(
                                                color: Colors.blue,
                                                text: "Add Favorite",
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          bottom: const TabBar(
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            indicatorColor: Colors.blue,
                            overlayColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            tabs: [
                              Tab(
                                text: "Details",
                              ),
                              Tab(
                                text: "Reviews",
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: TabBarView(children: [
                        ListView(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ContainerDetail(
                                  iconData: Icons.leaderboard,
                                  title: "Rank",
                                  deskripsi: state.detailComic.rank.toString(),
                                  color: Colors.blue,
                                ),
                                ContainerDetail(
                                  iconData: Icons.star,
                                  title: "Score",
                                  deskripsi: "${state.detailComic.score}/10",
                                  color: (themeState.isDark)
                                      ? Colors.grey[600]!
                                      : Colors.grey,
                                ),
                                ContainerDetail(
                                  iconData: Icons.whatshot,
                                  title: "Popularity",
                                  deskripsi:
                                      state.detailComic.popularity.toString(),
                                  color: Colors.green,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              "Details",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(13),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: (themeState.isDark)
                                      ? Colors.grey[800]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RowDetail(
                                      title: "Title English • ",
                                      value: state.detailComic.englishTitle,
                                    ),
                                    RowDetail(
                                      title: "Title Japanase • ",
                                      value: state.detailComic.japanTitle,
                                    ),
                                    RowDetail(
                                      title: "Type • ",
                                      value: state.detailComic.type,
                                    ),
                                    RowDetail(
                                      title: "Chapters • ",
                                      value:
                                          state.detailComic.chapters.toString(),
                                    ),
                                    RowDetail(
                                      title: "Volumes • ",
                                      value:
                                          state.detailComic.volumes.toString(),
                                    ),
                                    RowDetail(
                                      title: "Status • ",
                                      value: state.detailComic.status,
                                    ),
                                    RowDetail(
                                      title: "Publish Date • ",
                                      value: formatDate(
                                          state.detailComic.publishedWhen),
                                    ),
                                    RowDetail(
                                      title: "Publish Date Completed • ",
                                      value: (state.detailComic.publishedUntil
                                              .isEmpty)
                                          ? "?"
                                          : formatDate(
                                              state.detailComic.publishedUntil),
                                    ),
                                    RowDetail(
                                      title: "Authors • ",
                                      value: state.detailComic.authors[0]
                                          ["name"],
                                    ),
                                    RowDetail(
                                      title: "Genres • ",
                                      value: state.detailComic.genres
                                          .map((genre) => genre.name)
                                          .join(', '),
                                    ),
                                    RowDetail(
                                      title: "Favorites • ",
                                      value:
                                          "${state.detailComic.favorites} Person",
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ReadMoreText(
                                      state.detailComic.synopsis,
                                      style: const TextStyle(fontSize: 15),
                                      trimMode: TrimMode.Line,
                                      trimLines: 8,
                                      colorClickableText: Colors.blue,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: 'Show less',
                                      lessStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      moreStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              "Characters",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            BlocBuilder<CharaBloc, CharaState>(
                              builder: (context, state) {
                                if (state is CharaLoading) {
                                  return const CharaShimmerLoading();
                                } else if (state is CharaLoaded) {
                                  if (state.characters.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        "No Character data for this comic",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  }
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 170,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const ScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final characters =
                                            state.characters[index];
                                        return Card(
                                          child: Container(
                                            margin: const EdgeInsets.all(0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                    characters.images,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        characters.name,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.characters.length,
                                    ),
                                  );
                                } else {
                                  return const CharaShimmerLoading();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              "Recommendations",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            BlocBuilder<RecomBloc, RecomState>(
                              builder: (context, state) {
                                if (state is RecomLoading) {
                                  return const RecomShimmerLoading();
                                } else if (state is RecomLoaded) {
                                  if (state.recommendations.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        "No Recommendations data for this comic",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  }
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 255,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final recom =
                                            state.recommendations[index];
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(id: recom.malId),
                                          )),
                                          child: Card(
                                            child: Container(
                                              margin: const EdgeInsets.all(0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: Stack(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      recom.images,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 255,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          recom.title,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.recommendations.length,
                                    ),
                                  );
                                }
                                return const RecomShimmerLoading();
                              },
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              BlocBuilder<ReviewBloc, ReviewState>(
                                builder: (context, reviewState) {
                                  if (reviewState is ReviewLoaded) {
                                    if (reviewState.reviews.isEmpty) {
                                      return Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "no reviews, make the first review for this comic",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final review =
                                                reviewState.reviews[index];
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(review
                                                              .profilePicture),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            review.username,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          (review.star == 0)
                                                              ? Container()
                                                              : SizedBox(
                                                                  height: 20,
                                                                  child: Row(
                                                                    children: List
                                                                        .generate(
                                                                      review
                                                                          .star,
                                                                      (index) {
                                                                        return const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.yellow,
                                                                          size:
                                                                              15,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                          Text(
                                                            review.review,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      review.createdAt,
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                          itemCount: reviewState.reviews.length,
                                        ),
                                      ),
                                    );
                                  }
                                  return Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  );
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: MediaQuery.of(context).size.width,
                                      height: 45,
                                      child: Row(
                                        children: List.generate(
                                          5,
                                          (index) =>
                                              BlocBuilder<StarBloc, StarState>(
                                            builder: (context, state) {
                                              if (state is StarLoaded) {
                                                return IconButton(
                                                  onPressed: () => context
                                                      .read<StarBloc>()
                                                      .add(AddStar(
                                                          index: index)),
                                                  icon: Icon(
                                                    Icons.star,
                                                    size: 30,
                                                    color:
                                                        (state.index >= index)
                                                            ? Colors.yellow
                                                            : null,
                                                  ),
                                                );
                                              }
                                              return IconButton(
                                                onPressed: () => context
                                                    .read<StarBloc>()
                                                    .add(AddStar(index: index)),
                                                icon: const Icon(
                                                  Icons.star_border_outlined,
                                                  size: 30,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (themeState.isDark)
                                                  ? Colors.grey[600]
                                                  : Colors.grey,
                                            ),
                                            child: TextField(
                                              controller: inputReview,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                hintText:
                                                    "Leave a review about this comic",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:
                                              BlocBuilder<UserBloc, UserState>(
                                            builder: (context, userState) {
                                              if (userState is UserLoaded) {
                                                return BlocBuilder<StarBloc,
                                                    StarState>(
                                                  builder:
                                                      (context, starState) {
                                                    if (starState
                                                        is StarLoaded) {
                                                      return BlocListener<
                                                          ReviewBloc,
                                                          ReviewState>(
                                                        listener: (context,
                                                            reviewState) {
                                                          if (reviewState
                                                              is ReviewAddSuccess) {
                                                            context
                                                                .read<
                                                                    ReviewBloc>()
                                                                .add(GetReview(
                                                                    title: reviewState
                                                                        .title));
                                                          }
                                                        },
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (inputReview
                                                                .text.isEmpty) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  duration:
                                                                      Duration(
                                                                    seconds: 1,
                                                                  ),
                                                                  content: Text(
                                                                    "review must be filled!",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              context
                                                                  .read<
                                                                      ReviewBloc>()
                                                                  .add(
                                                                      AddReview(
                                                                    title: state
                                                                        .detailComic
                                                                        .englishTitle,
                                                                    userId:
                                                                        userState
                                                                            .user
                                                                            .uid,
                                                                    username:
                                                                        userState
                                                                            .user
                                                                            .username,
                                                                    profilePicture:
                                                                        userState
                                                                            .user
                                                                            .photo,
                                                                    review:
                                                                        inputReview
                                                                            .text,
                                                                    star: (starState
                                                                            .index +
                                                                        1),
                                                                  ));
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              inputReview
                                                                  .clear();
                                                              context
                                                                  .read<
                                                                      StarBloc>()
                                                                  .add(
                                                                      ResetStar());
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  duration:
                                                                      Duration(
                                                                    seconds: 1,
                                                                  ),
                                                                  content: Text(
                                                                    "add review success",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.send,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    return BlocListener<
                                                        ReviewBloc,
                                                        ReviewState>(
                                                      listener: (context,
                                                          reviewState) {
                                                        if (reviewState
                                                            is ReviewAddSuccess) {
                                                          context
                                                              .read<
                                                                  ReviewBloc>()
                                                              .add(GetReview(
                                                                  title: reviewState
                                                                      .title));
                                                        }
                                                      },
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (inputReview
                                                              .text.isEmpty) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration:
                                                                    Duration(
                                                                  seconds: 1,
                                                                ),
                                                                content: Text(
                                                                  "review must be filled!",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            context
                                                                .read<
                                                                    ReviewBloc>()
                                                                .add(AddReview(
                                                                  title: state
                                                                      .detailComic
                                                                      .englishTitle,
                                                                  userId:
                                                                      userState
                                                                          .user
                                                                          .uid,
                                                                  username:
                                                                      userState
                                                                          .user
                                                                          .username,
                                                                  profilePicture:
                                                                      userState
                                                                          .user
                                                                          .photo,
                                                                  review:
                                                                      inputReview
                                                                          .text,
                                                                  star: 0,
                                                                ));
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                            inputReview.clear();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration:
                                                                    Duration(
                                                                  seconds: 1,
                                                                ),
                                                                content: Text(
                                                                  "add review success",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.blue,
                                                          ),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.send,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                              return GestureDetector(
                                                onTap: () {
                                                  inputReview.clear();
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      content: const Text(
                                                        "You must Login!",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.blue,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.send,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
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
                      ]),
                    ),
                  );
                },
              );
            }
            return const ScaffoldShimmerLoading();
          },
        ),
      ),
    );
  }
}

class FavoriteContainer extends StatelessWidget {
  final String text;
  final Color color;
  const FavoriteContainer({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecomShimmerLoading extends StatelessWidget {
  const RecomShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CharaShimmerLoading extends StatelessWidget {
  const CharaShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScaffoldShimmerLoading extends StatelessWidget {
  const ScaffoldShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(270),
        child: AppBar(
          title: const Text(
            "Community",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                height:
                                    MediaQuery.of(context).size.height * 0.025,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.29,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  final String title, value;
  const RowDetail({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class ContainerDetail extends StatelessWidget {
  final String title, deskripsi;
  final IconData iconData;
  final Color color;
  const ContainerDetail({
    super.key,
    required this.iconData,
    required this.title,
    required this.deskripsi,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: MediaQuery.of(context).size.width * 0.29,
      height: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              deskripsi,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

String formatDate(String dateString) {
  final DateTime dateTime = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('dd MMMM yyyy');
  return formatter.format(dateTime);
}

String formatMonth(String dateString) {
  final DateTime dateTime = DateTime.parse(dateString);
  final DateFormat formatter = DateFormat('MMMM yyyy');
  return formatter.format(dateTime);
}

String cutString(String inputString) {
  int index = inputString.indexOf('-');
  if (index != -1) {
    return inputString.substring(0, index).trim();
  } else {
    return inputString;
  }
}

double convertScoreToRating(double score) {
  // Menggunakan pembulatan ke bawah untuk mendapatkan peringkat 1-5
  double rating = (score / 2).clamp(1.0, 5.0);
  return double.parse(rating.toStringAsFixed(1));
}
