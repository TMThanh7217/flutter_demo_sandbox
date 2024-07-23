import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollviewPageState extends ChangeNotifier {
  bool isFavorited = true;
  int favoriteCount = 41;

  void toggleLikeFavorite() {
    if (isFavorited) {
      favoriteCount -= 1;
      isFavorited = false;
    } else {
      favoriteCount += 1;
      isFavorited = true;
    }
    notifyListeners();
  }
}
class PageScrollView extends StatelessWidget {
  const PageScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'Oeschinen Lake Campground';
    const location = 'Kandersteg, Switzerland';
    const description =
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the '
        'Bernese Alps. Situated 1,578 meters above sea level, it '
        'is one of the larger Alpine Lakes. A gondola ride from '
        'Kandersteg, followed by a half-hour walk through pastures '
        'and pine forest, leads you to the lake, which warms to 20 '
        'degrees Celsius in the summer. Activities enjoyed here '
        'include rowing, and riding the summer toboggan run.';
    return const SingleChildScrollView(
      child: Column(
        children: [
          Placeholder(),
          TitleSection(
            name: name,
            location: location,
          ),
          ButtonSection(),
          TextSection(
            description: description,
          )
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const FavoriteWidget(),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: 'CALL',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: 'ROUTE',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ScrollviewPageState>();
    bool isFavorited = appState.isFavorited;
    int favoriteCount = appState.favoriteCount;

    return Builder(
      builder: (context) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.center,
                icon: (isFavorited
                    ? const Icon(Icons.star)
                    : const Icon(Icons.star_border)),
                color: Colors.red[500],
                onPressed: () {
                  appState.toggleLikeFavorite();
                },
              ),
            ),
            SizedBox(
              width: 18,
              child: SizedBox(
                child: Text('$favoriteCount'),
              ),
            ),
          ],
        );
      }
    );
  }
}
