import 'dart:developer';

import 'package:anime_facts/entities/anime.dart';
import 'package:anime_facts/entities/fact.dart';
import 'package:anime_facts/service/anime_service.dart';
import 'package:anime_facts/ui/anime_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// This class represents a component of an anime
/// it takes the anime as a parameter to its constructor.
/// the variable [loadFacts] in constructor parameter determines whether to load and display the linked facts or not
class AnimeWidget extends StatefulWidget {
  final Anime anime;

  /// load and display or not the linked facts
  final bool loadFacts;

  const AnimeWidget(this.anime, this.loadFacts, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimeWidgetState();
}

class _AnimeWidgetState extends State<AnimeWidget> {
  Future<List<Fact>>? data;

  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 500,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child:
            /* condition to display the facts or just the coverage */
            !widget.loadFacts
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.network(
                        widget.anime.img,
                        width: 400,
                        height: 400,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            // null means the image was loaded or failed
                            return child;
                          } else {
                            double? progress;

                            /* calculates the progress if all the elements are present */
                            if (loadingProgress.expectedTotalBytes != null) {
                              progress = loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!;
                            }
                            return CircularProgressIndicator(
                              value: progress,
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          log(error.toString(),
                              error: error, stackTrace: stackTrace);

                          return const Icon(Icons.error);
                        },
                      ),
                      Text(
                        widget.anime.name
                            .replaceAll("_", " "), //avoid snake_case
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 32),
                      ),

                      /* condition to display the "see the facts" link otherwise nothing */
                      !widget.loadFacts
                          ? TextButton(
                              onPressed: () {
                                Get.to(() => AnimeView(widget.anime, true));
                              },
                              child: Text("seeFacts".tr.capitalizeFirst!))
                          : const SizedBox.shrink()
                    ],
                  )
                : FutureBuilder<List<Fact>>(
                    future: data,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Center(
                              child: TextButton.icon(
                                  onPressed: () {
                                    refreshData();
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: Text(
                                      "noDataRefresh".tr.capitalizeFirst!)));
                        } else {
                          return ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              var fact = snapshot.data![i];
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  fact.fact,
                                  style: const TextStyle(fontSize: 22),
                                ),
                              );
                            },
                            separatorBuilder: (context, i) {
                              return const Divider(
                                color: Colors.grey,
                              );
                            },
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                            child: TextButton.icon(
                                onPressed: () {
                                  refreshData();
                                },
                                icon: const Icon(Icons.refresh),
                                label: Text(
                                    "errorDataRefresh".tr.capitalizeFirst!)));
                      }
                    })),
      ),
    );
  }

  void refreshData() {
    setState(() {
      initData();
    });
  }

  void initData() {
    if (widget.loadFacts) {
      data = AnimeService().loadFactsByAnime(widget.anime);

      data?.then((_) {
        setState(() {});
      }).catchError((error, stackTrace) {
        log(error, stackTrace: stackTrace, time: DateTime.now());
      });
    }
  }
}
