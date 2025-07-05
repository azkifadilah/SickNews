import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/my_article_provider.dart';

class ArticleFormScreen extends StatefulWidget {
  final Map<String, String>? article;
  final int? index;
  
  const ArticleFormScreen({super.key, this.article, this.index});

  @override
  State<ArticleFormScreen> createState() => _ArticleFormScreenState();
}

class _ArticleFormScreenState extends State<ArticleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  
  late String _category;
  bool _isLoading = false;
  
  final List<String> _categories = [
    'Kesehatan', 'Teknologi', 'Pendidikan', 'Entertainment', 'Politik', 'Saham', 'Olahraga', 'Ekonomi'
  ];

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.article?['title'] ?? '';
    _category = widget.article?['category'] ?? _categories.first;
    _contentController.text = widget.article?['content'] ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveArticle() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final newArticle = {
        'title': _titleController.text.trim(),
        'category': _category,
        'content': _contentController.text.trim(),
      };

      final provider = Provider.of<MyArticleProvider>(context, listen: false);
      
      try {
        if (widget.index != null) {
          provider.editArticle(widget.index!, newArticle);
        } else {
          provider.addArticle(newArticle);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.index != null 
                    ? 'Artikel berhasil diperbarui!' 
                    : 'Artikel berhasil dipublish!',
              ),
              backgroundColor: const Color(0xFF4ECCA3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );

          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context, 
                '/home', 
                (route) => false
              );
            }
          });
        }
      } catch (e) {
        print("Error saving article: $e"); // Debug
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Gagal menyimpan artikel: $e'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Batalkan Penulisan?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Artikel yang sedang ditulis akan hilang. Apakah kamu yakin ingin membatalkan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Lanjut Menulis',
                style: TextStyle(color: Color(0xFF4ECCA3)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ya, Batalkan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCAFDE8),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section - konsisten dengan screen lain
            _buildHeader(),
            
            // Add Article Section Header
            _buildAddArticleHeader(),
            
            // Form Content
            Expanded(
              child: _buildForm(),
            ),
            
            // Action Buttons
            _buildActionButtons(),
          ],
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

  Widget _buildAddArticleHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF4ECCA3),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Menu Icon
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit,
              color: Color(0xFF4ECCA3),
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Title
          Text(
            widget.index != null ? 'Edit Article' : 'Add Article',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Artikel
            const Text(
              'Judul Artikel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4ECCA3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan judul artikel yang menarik...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul artikel tidak boleh kosong';
                  }
                  if (value.trim().length < 10) {
                    return 'Judul artikel minimal 10 karakter';
                  }
                  return null;
                },
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Kategori
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4ECCA3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                dropdownColor: Colors.white,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF4ECCA3),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Konten
            const Text(
              'Konten',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4ECCA3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _contentController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'Tulis konten artikel di sini...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Konten artikel tidak boleh kosong';
                  }
                  if (value.trim().length < 50) {
                    return 'Konten artikel minimal 50 karakter';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Publish Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _saveArticle,
              icon: _isLoading 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.publish),
              label: Text(_isLoading ? 'Publishing...' : 'Publish'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ECCA3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Batal Button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _showCancelDialog,
              icon: const Icon(Icons.close),
              label: const Text('Batal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}