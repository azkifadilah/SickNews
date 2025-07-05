import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_article_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Keluar dari Akun',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '/login', 
                  (route) => false
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Pengaturan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.notifications, color: Color(0xFF4ECCA3)),
                title: Text('Notifikasi'),
                trailing: Switch(
                  value: true,
                  onChanged: null,
                  activeColor: Color(0xFF4ECCA3),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dark_mode, color: Color(0xFF4ECCA3)),
                title: Text('Mode Gelap'),
                trailing: Switch(
                  value: false,
                  onChanged: null,
                ),
              ),
              ListTile(
                leading: Icon(Icons.language, color: Color(0xFF4ECCA3)),
                title: Text('Bahasa'),
                trailing: Text('Indonesia'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Tutup',
                style: TextStyle(color: Color(0xFF4ECCA3)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final myArticles = Provider.of<MyArticleProvider>(context).myArticles;
    
    return Scaffold(
      backgroundColor: const Color(0xFFCAFDE8),
      body: SafeArea(
        child: SingleChildScrollView( // FIX: Tambah scroll
          child: Column(
            children: [
              // Header Section - konsisten dengan screen lain
              _buildHeader(),
              
              // Profile Info Section
              _buildProfileInfo(),
              
              // Menu Items - Remove Expanded, langsung padding
              _buildMenuItems(context, myArticles.length),
              
              // Bottom padding supaya tidak terlalu mepet
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Logo
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, size: 20),
                  Text(
                    'SICKNEWS',
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Title
          const Expanded(
            child: Text(
              'News That Hits\nDifferent',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24), // Kurangi padding
      child: const Column(
        children: [
          // Avatar - sesuai design Figma
          CircleAvatar(
            radius: 50, // Kurangi sedikit size
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Name - update sesuai kode asli
          Text(
            'Kelompok 4',
            style: TextStyle(
              fontSize: 24, // Kurangi sedikit
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 6),
          
          // Email - update sesuai kode asli
          Text(
            'kelompok4@sicknews.org',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, int articleCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Artikel Anda
          _buildMenuItem(
            icon: Icons.article,
            title: 'Artikel Anda',
            subtitle: '$articleCount artikel',
            onTap: () {
              Navigator.pushNamed(context, '/my-articles');
            },
          ),
          
          const SizedBox(height: 10), // Kurangi spacing
          
          // Berita Tersimpan
          _buildMenuItem(
            icon: Icons.bookmark,
            title: 'Berita Tersimpan',
            subtitle: 'Bookmark kamu',
            onTap: () {
              Navigator.pushNamed(context, '/bookmarks');
            },
          ),
          
          const SizedBox(height: 10),
          
          // Setting
          _buildMenuItem(
            icon: Icons.settings,
            title: 'Setting',
            subtitle: 'Pengaturan aplikasi',
            onTap: () => _showSettingsDialog(context),
          ),
          
          const SizedBox(height: 10),
          
          // Keluar
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Keluar',
            subtitle: 'Logout dari akun',
            onTap: () => _showLogoutDialog(context),
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isLogout ? Colors.red.withOpacity(0.1) : const Color(0xFF4ECCA3),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14), // Kurangi padding sedikit
            child: Row(
              children: [
                // Icon
                Container(
                  width: 44, // Kurangi size
                  height: 44,
                  decoration: BoxDecoration(
                    color: isLogout 
                        ? Colors.red.withOpacity(0.2)
                        : Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isLogout ? Colors.red : Colors.white,
                    size: 22,
                  ),
                ),
                
                const SizedBox(width: 14),
                
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16, // Kurangi font size
                          fontWeight: FontWeight.bold,
                          color: isLogout ? Colors.red : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12, // Kurangi font size
                          color: isLogout 
                              ? Colors.red.withOpacity(0.7)
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: isLogout 
                      ? Colors.red.withOpacity(0.7)
                      : Colors.white.withOpacity(0.7),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}