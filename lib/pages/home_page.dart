import 'package:flutter/material.dart';
import 'package:flutter_komik/bloc/top_comic/top_comic_bloc.dart';
import 'package:flutter_komik/data/model/comic_model.dart';
import 'package:flutter_komik/pages/detail_page.dart';
import 'package:flutter_komik/pages/filter_page.dart';
import 'package:flutter_komik/repository/comic_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopComicBloc(ComicRepo())
        ..add(GetTopManga(query: "manga"))
        ..add(GetTopManhwa(query: "manhwa"))
        ..add(GetTopManhua(query: "manhua"))
        ..add(GetTopNovel(query: "novel"))
        ..add(GetTopLightNovel(query: "lightnovel")),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Necomic"),
          centerTitle: true,
        ),
        body: BlocBuilder<TopComicBloc, TopComicState>(
          builder: (context, state) {
            if (state is TopComicLoading) {
              return const HomeShimmerLoading();
            } else if (state is TopComicLoaded) {
              return RefreshIndicator(
                backgroundColor: Colors.black,
                color: Colors.blue,
                displacement: 50,
                onRefresh: () async {
                  context.read<TopComicBloc>().add(GetTopManga(query: "manga"));
                  context
                      .read<TopComicBloc>()
                      .add(GetTopManhwa(query: "manhwa"));
                  context
                      .read<TopComicBloc>()
                      .add(GetTopManhua(query: "manhua"));
                  context.read<TopComicBloc>().add(GetTopNovel(query: "novel"));
                  context
                      .read<TopComicBloc>()
                      .add(GetTopLightNovel(query: "lightnovel"));
                },
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TitleAndSeeMore(
                        titleText: "Top Manga",
                        titleFilterPage: "Manga",
                      ),
                    ),
                    (state.manga.isEmpty)
                        ? const CardShimmerLoading()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 255,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final manga = state.manga[index];
                                return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(id: manga.malId),
                                        )),
                                    child: ComicCard(comic: manga));
                              },
                              itemCount: state.manga.length,
                            ),
                          ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TitleAndSeeMore(
                        titleText: "Top Manhwa",
                        titleFilterPage: "Manhwa",
                      ),
                    ),
                    (state.manhwa.isEmpty)
                        ? const CardShimmerLoading()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 255,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final manhwa = state.manhwa[index];
                                return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(id: manhwa.malId),
                                        )),
                                    child: ComicCard(comic: manhwa));
                              },
                              itemCount: state.manhwa.length,
                            ),
                          ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TitleAndSeeMore(
                        titleText: "Top Manhua",
                        titleFilterPage: "Manhua",
                      ),
                    ),
                    (state.manhua.isEmpty)
                        ? const CardShimmerLoading()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 255,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final manhua = state.manhua[index];
                                return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(id: manhua.malId),
                                        )),
                                    child: ComicCard(comic: manhua));
                              },
                              itemCount: state.manhua.length,
                            ),
                          ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TitleAndSeeMore(
                        titleText: "Top Novel",
                        titleFilterPage: "Novel",
                      ),
                    ),
                    (state.novel.isEmpty)
                        ? const CardShimmerLoading()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 255,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final novel = state.novel[index];
                                return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(id: novel.malId),
                                        )),
                                    child: ComicCard(comic: novel));
                              },
                              itemCount: state.novel.length,
                            ),
                          ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TitleAndSeeMore(
                        titleText: "Top LightNovel",
                        titleFilterPage: "LightNovel",
                      ),
                    ),
                    (state.lightNovel.isEmpty)
                        ? const CardShimmerLoading()
                        : Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 255,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final lightNovel = state.lightNovel[index];
                                return InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(id: lightNovel.malId),
                                        )),
                                    child: ComicCard(comic: lightNovel));
                              },
                              itemCount: state.lightNovel.length,
                            ),
                          ),
                  ],
                ),
              );
            }
            return const HomeShimmerLoading();
          },
        ),
      ),
    );
  }
}

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(
          height: 10,
        ),
        RowTitleShimmerLoading(),
        CardShimmerLoading(),
        SizedBox(
          height: 10,
        ),
        RowTitleShimmerLoading(),
        CardShimmerLoading(),
        SizedBox(
          height: 10,
        ),
        RowTitleShimmerLoading(),
        CardShimmerLoading(),
      ],
    );
  }
}

class RowTitleShimmerLoading extends StatelessWidget {
  const RowTitleShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 27,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 27,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          )
        ],
      ),
    );
  }
}

class CardShimmerLoading extends StatelessWidget {
  const CardShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 255,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Card(
                child: Container(
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          itemCount: 3,
        ));
  }
}

class TitleAndSeeMore extends StatelessWidget {
  final String titleText, titleFilterPage;
  const TitleAndSeeMore({
    super.key,
    required this.titleText,
    required this.titleFilterPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titleText,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FilterPage(title: titleFilterPage),
          )),
          child: const Text(
            "See More",
            style: TextStyle(fontSize: 15, color: Colors.blue),
          ),
        )
      ],
    );
  }
}

class ComicCard extends StatelessWidget {
  const ComicCard({
    super.key,
    required this.comic,
  });

  final ComicModel comic;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black,
      child: SizedBox(
        width: 160,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  comic.images,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          comic.englishTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
