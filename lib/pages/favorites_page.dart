import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_komik/bloc/favorites/favorites_bloc.dart';
import 'package:flutter_komik/pages/detail_page.dart';
import 'package:shimmer/shimmer.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "My Favorite Comics",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final favorites = state.favorites[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(id: favorites.malId),
                          )),
                          child: Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      favorites.images,
                                      width: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          favorites.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: (favorites.type ==
                                                        "Manga")
                                                    ? Colors.blue
                                                    : (favorites.type ==
                                                            "Manhwa")
                                                        ? Colors.red[700]
                                                        : (favorites.type ==
                                                                "Manhua")
                                                            ? Colors.orange[700]
                                                            : (favorites.type ==
                                                                    "Novel")
                                                                ? Colors
                                                                    .green[700]
                                                                : Colors.purple[
                                                                    700],
                                              ),
                                              child: Text(
                                                favorites.type,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "  • ${formatMonth(favorites.publishedWhen)}",
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
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red[600],
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Flexible(
                                              child: Text(
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                favorites.favoriteDate,
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
                          ),
                        ),
                      );
                    },
                    itemCount: state.favorites.length,
                  ),
                ),
              ],
            ),
          );
        } else if (state is FavoritesLoading) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Favorite Comics",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: List.generate(
                4,
                (index) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "My Favorite Comics",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: const Center(
            child: Text(
              "No favorite comics here!\nAdd your favorite comics",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
