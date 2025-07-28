import 'package:flutter/material.dart';
import 'package:flutter_hentai_viewer/generated/l10n.dart';
import 'package:flutter_hentai_viewer/ehentai/components/gallery_card.dart';
import 'package:flutter_hentai_viewer/ehentai/stores/favorite_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context).favorite),
      ),
      body: Observer(
        builder: (context) => WaterfallFlow.builder(
            gridDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
            itemBuilder: (context, index) =>
                GalleryCard(favoriteStore.favoriteGalleries[index]),
            itemCount: favoriteStore.favoriteGalleries.length),
      ),
    );
  }
}
