import 'package:anime_facts/entities/anime.dart';
import 'package:anime_facts/ui/anime_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Cette classe represente une page d'un animé
class AnimeView extends StatelessWidget {
  final Anime anime;
  final bool loadFacts;

  const AnimeView(this.anime, this.loadFacts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(anime.img),
              child: Text(
                  "${anime.name.capitalize!.characters.isNotEmpty ? anime.name.capitalize?.characters.first : ''}"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(anime.name.replaceAll("_", " ").capitalizeFirst!),
            )
          ],
        ),
      ),
      body: AnimeWidget(anime, loadFacts),
    );
  }
}
