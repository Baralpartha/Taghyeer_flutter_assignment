import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../cubits/posts/posts_cubit.dart';
import '../cubits/products/products_cubit.dart';
import 'posts_page.dart';
import 'products_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  late final pages = [
    BlocProvider(
      create: (_) => sl<ProductsCubit>()..fetchInitial(),
      child: const ProductsPage(),
    ),
    BlocProvider(
      create: (_) => sl<PostsCubit>()..fetchInitial(),
      child: const PostsPage(),
    ),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => setState(() => currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Products'),
          NavigationDestination(icon: Icon(Icons.article_outlined), label: 'Posts'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}