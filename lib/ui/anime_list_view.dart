import 'dart:developer';

import 'package:anime_facts/entities/anime.dart';
import 'package:anime_facts/service/anime_service.dart';
import 'package:anime_facts/ui/anime_widget.dart';
import 'package:anime_facts/utilities/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Cette classe charge et affiche la liste des animés
class AnimeListView extends StatefulWidget {
  const AnimeListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimeListViewState();
}

class _AnimeListViewState extends State<AnimeListView> {
  Future<List<Anime>>? data;

  _AnimeListViewState();

  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Utility.appTitle),
      ),
      body: FutureBuilder<List<Anime>>(
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
                        label: Text("noDataRefresh".tr.capitalizeFirst!)));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return AnimeWidget(snapshot.data![i], false);
                    });
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                  child: TextButton.icon(
                      onPressed: () {
                        refreshData();
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text("errorDataRefresh".tr.capitalizeFirst!)));
            }
          })),
    );
  }

  void refreshData() {
    setState(() {
      initData();
    });
  }

  void initData() {
    data = AnimeService().loadAllAnime();

    data?.then((_) {
      setState(() {});
    }).catchError((error, stackTrace) {
      log(error, stackTrace: stackTrace, time: DateTime.now());
    });
  }
}
