import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sicknews/provider/my_article_provider.dart';
import 'provider/bookmark_provider.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/bookmark_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/article_form_screen.dart';
import 'screens/my_articles_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
        ChangeNotifierProvider(create: (_) => MyArticleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SickNews',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4ECCA3),
          primary: const Color(0xFF4ECCA3),
          secondary: const Color(0xFF2C3E50),
        ),
        scaffoldBackgroundColor: const Color(0xFFCAFDE8),
        useMaterial3: true,
        fontFamily: 'Roboto',
        
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.2,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            height: 1.4,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4ECCA3),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const MainWrapper(),
        '/add-article': (context) => const ArticleFormScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/bookmarks': (context) => const BookmarkScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/my-articles': (context) => const MyArticlesScreen(),
      },
    );
  }
}

// Wrapper class untuk handle bottom navigation
class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(), // Home
    const CategoriesScreen(), // Kategori
    const ArticleFormScreen(), // Add Artikel (Center button)
    const BookmarkScreen(), // Bookmark
    const ProfileScreen(), // Profile
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildCustomBottomNavigation(),
    );
  }

  // Custom Bottom Navigation - dengan Add Artikel di tengah
  Widget _buildCustomBottomNavigation() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home Tab
          _buildNavItem(
            index: 0,
            icon: Icons.home,
            label: 'Home',
            isActive: _currentIndex == 0,
          ),
          
          // Kategori Tab
          _buildNavItem(
            index: 1,
            icon: Icons.category,
            label: 'Kategori',
            isActive: _currentIndex == 1,
          ),
          
          // Center Add Article Button (Larger)
          _buildCenterAddButton(),
          
          // Bookmark Tab
          _buildNavItem(
            index: 3,
            icon: Icons.bookmark,
            label: 'Bookmark',
            isActive: _currentIndex == 3,
          ),
          
          // Profile Tab
          _buildNavItem(
            index: 4,
            icon: Icons.person,
            label: 'Profile',
            isActive: _currentIndex == 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive 
                  ? const Color(0xFF4ECCA3) 
                  : Colors.white.withOpacity(0.6),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive 
                    ? const Color(0xFF4ECCA3) 
                    : Colors.white.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterAddButton() {
    return GestureDetector(
      onTap: () => _onTabTapped(2),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: _currentIndex == 2 
              ? const Color(0xFF4ECCA3) 
              : const Color(0xFF4A5568),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}