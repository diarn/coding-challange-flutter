import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/watchlist/presentation/view/watchlist.dart';

final currentIndexProv = StateProvider.autoDispose<int>((ref) => 0);
final pageConProv = StateProvider.autoDispose<PageController>((ref) => PageController());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageConProv);
    final currentIndex = ref.watch(currentIndexProv);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Scaffold(
            body: Center(
              child: Text(
                "Home",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
          const WatchlistPage(),
          Scaffold(
            body: Center(
              child: Text(
                "Others",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.tertiaryContainer
            : Theme.of(context).colorScheme.primaryContainer,
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(currentIndexProv.notifier).state = value;
          ref.read(pageConProv.notifier).state.jumpToPage(
                value,
              );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_rounded),
            label: "Watchlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// var cunguk = DateTime.now();
// x(){
//   cunguk.
// }
