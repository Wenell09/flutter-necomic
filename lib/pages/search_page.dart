import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/search_comic/search_comic_bloc.dart';
import 'package:flutter_komik/bloc/validation_input/input_bloc.dart';
import 'package:flutter_komik/pages/detail_page.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inputSearch = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: inputSearch,
                onChanged: (value) {
                  context
                      .read<SearchComicBloc>()
                      .add(GetSearchComic(search: value));
                  if (value.isNotEmpty) {
                    context.read<InputBloc>().add(
                        ValidationInput(showClearInput: true, value: value));
                  } else {
                    context.read<InputBloc>().add(
                        ValidationInput(showClearInput: false, value: value));
                  }
                },
                onSubmitted: (value) {
                  context
                      .read<SearchComicBloc>()
                      .add(GetSearchComic(search: value));
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  suffixIcon: BlocBuilder<InputBloc, InputState>(
                    builder: (context, state) {
                      if (state.showClearInput) {
                        return IconButton(
                          onPressed: () {
                            inputSearch.clear();
                            context.read<InputBloc>().add(ValidationInput(
                                showClearInput: false, value: ""));
                            context
                                .read<SearchComicBloc>()
                                .add(GetSearchComic(search: ""));
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 25,
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                  hintText: "Find your favorite comics here...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<InputBloc, InputState>(
            builder: (context, state) {
              if (state.showClearInput) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Search result:${state.value}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<SearchComicBloc, SearchComicState>(
            builder: (context, state) {
              if (state is SearchComicLoading) {
                return const ShimmerComicLoading();
              } else if (state is SearchComicLoaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
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
              return const ShimmerComicLoading();
            },
          ),
        ],
      ),
    );
  }
}

class ShimmerComicLoading extends StatelessWidget {
  const ShimmerComicLoading({
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
