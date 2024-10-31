import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/filter_comic/filter_comic_bloc.dart';
import 'package:flutter_komik/bloc/select_filter/select_filter_bloc.dart';
import 'package:flutter_komik/bloc/theme/theme_bloc.dart';
import 'package:flutter_komik/pages/detail_page.dart';
import 'package:flutter_komik/repository/comic_repo.dart';
import 'package:shimmer/shimmer.dart';

class FilterPage extends StatelessWidget {
  final String title;
  const FilterPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FilterComicBloc(ComicRepo())
            ..add(GetFilterComic(query: title, filter: "", page: 1)),
        ),
        BlocProvider(
          create: (context) => SelectFilterBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Top $title"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.045,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: BlocBuilder<SelectFilterBloc, SelectFilterState>(
                    builder: (context, state) {
                      return BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, themeState) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              context.read<SelectFilterBloc>().add(CallSelect(
                                    currentPage: index,
                                    filterSelect: (index == 0)
                                        ? ""
                                        : (index == 1)
                                            ? "bypopularity"
                                            : (index == 2)
                                                ? "favorite"
                                                : (index == 3)
                                                    ? "upcoming"
                                                    : "publishing",
                                  ));
                              context.read<FilterComicBloc>().add(
                                    GetFilterComic(
                                      query: title,
                                      filter: (index == 0)
                                          ? ""
                                          : (index == 1)
                                              ? "bypopularity"
                                              : (index == 2)
                                                  ? "favorite"
                                                  : (index == 3)
                                                      ? "upcoming"
                                                      : "publishing",
                                      page: 1,
                                    ),
                                  );
                            },
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: (state.currentPage == index)
                                    ? (themeState.isDark)
                                        ? Colors.black
                                        : Colors.white
                                    : (themeState.isDark)
                                        ? Colors.white
                                        : Colors.black,
                                border: Border.all(
                                    color: (themeState.isDark)
                                        ? Colors.white
                                        : Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  (index == 0)
                                      ? "All"
                                      : (index == 1)
                                          ? "Popular"
                                          : (index == 2)
                                              ? "favorite"
                                              : (index == 3)
                                                  ? "Upcoming"
                                                  : "Publishing",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: (state.currentPage == index)
                                        ? (themeState.isDark)
                                            ? Colors.white
                                            : Colors.black
                                        : (themeState.isDark)
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                itemCount: 5,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FilterComicBloc, FilterComicState>(
                  builder: (context, state) {
                    if (state is FilterComicLoaded) {
                      if (state.paginationcomic.currentPage == 1) {
                        return Container();
                      }
                    }
                    return BlocBuilder<SelectFilterBloc, SelectFilterState>(
                      builder: (context, selectFilterState) {
                        return BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeState) {
                            return InkWell(
                              onTap: () {
                                int currentPage = (state as FilterComicLoaded)
                                    .paginationcomic
                                    .currentPage;
                                context.read<FilterComicBloc>().add(
                                      GetFilterComic(
                                        query: title,
                                        filter: selectFilterState.filterSelect,
                                        page: currentPage - 1,
                                      ),
                                    );
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: (themeState.isDark)
                                      ? Colors.white
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: (themeState.isDark)
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                BlocBuilder<FilterComicBloc, FilterComicState>(
                  builder: (context, state) {
                    if (state is FilterComicLoaded) {
                      return Text(
                        state.paginationcomic.currentPage.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  "Of",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
                BlocBuilder<FilterComicBloc, FilterComicState>(
                  builder: (context, state) {
                    if (state is FilterComicLoaded) {
                      return Text(
                        state.paginationcomic.totalPage.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      );
                    }
                    return const Text(
                      "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                BlocBuilder<FilterComicBloc, FilterComicState>(
                  builder: (context, state) {
                    if (state is FilterComicLoaded) {
                      if (state.paginationcomic.currentPage ==
                          state.paginationcomic.totalPage) {
                        return Container();
                      }
                    }
                    return BlocBuilder<SelectFilterBloc, SelectFilterState>(
                      builder: (context, selectFilterState) {
                        return BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, themeState) {
                            return InkWell(
                              onTap: () {
                                int currentPage = (state as FilterComicLoaded)
                                    .paginationcomic
                                    .currentPage;
                                context.read<FilterComicBloc>().add(
                                      GetFilterComic(
                                        query: title,
                                        filter: selectFilterState.filterSelect,
                                        page: currentPage + 1,
                                      ),
                                    );
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: (themeState.isDark)
                                      ? Colors.white
                                      : Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: (themeState.isDark)
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<FilterComicBloc, FilterComicState>(
              builder: (context, state) {
                if (state is FilterComicLoading) {
                  return const ShimmerLoading();
                } else if (state is FilterComicLoaded) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.5 / 2,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      var comic = state.comic[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(id: comic.malId),
                        )),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    comic.images,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
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
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: state.comic.length,
                  );
                }
                return const ShimmerLoading();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1.5 / 2,
        ),
        padding: const EdgeInsets.all(8.0),
        children: List.generate(
          6,
          (index) => const Card(),
        ),
      ),
    );
  }
}
