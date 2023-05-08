import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class ScrollScreen extends StatefulWidget {
  const ScrollScreen({super.key});

  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('SliverAppBar'),
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  // push route to scroll_screen
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ScrollScreen()));
                },
              ),
            ],
            //flexibleSpace: Placeholder(),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('FlexibleSpaceBar'),
              background: Image.asset(
                'images/forest.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // collapsedHeight: 150,
            // toolbarHeight: 10,
            expandedHeight: 150,
          ),

          // silver grid
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              //childAspectRatio: 1
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.primaries[index % Colors.primaries.length],
              ),
              childCount: 20,
            ),
          ),
          // create silver persisent header
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 150 + kToolbarHeight,
              maxHeight: 200 + kToolbarHeight,
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text('SliverPersistentHeader'),
                ),
              ),
            ),
          ),

          // silver divider
          const SliverToBoxAdapter(
            child: Divider(
              color: Colors.grey,
              height: 50,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
          ),
          // silver fixed extent list item
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Item #$index'),
              ),
              childCount: 20,
            ),
          ),

          // item
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text('Item #$index'),
              ),
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  double get minExtent => minHeight;

  double get maxExtent => maxHeight;

  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
