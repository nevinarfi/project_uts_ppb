import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CatalogApp(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final int price;
  final String image;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  });
}

class CatalogApp extends StatefulWidget {
  const CatalogApp({super.key});

  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  int _currentPage = 0;
  final List<int> _favorites = [];

  final List<Product> products = [
    Product(id: 1, name: 'Sepatu Sneakers', price: 450000, image: '👟', category: 'Fashion'),
    Product(id: 2, name: 'Tas Ransel', price: 280000, image: '🎒', category: 'Aksesoris'),
    Product(id: 3, name: 'Jam Tangan', price: 650000, image: '⌚', category: 'Aksesoris'),
    Product(id: 4, name: 'Kacamata', price: 320000, image: '🕶️', category: 'Fashion'),
    Product(id: 5, name: 'Jaket Denim', price: 380000, image: '🧥', category: 'Fashion'),
    Product(id: 6, name: 'Topi Baseball', price: 125000, image: '🧢', category: 'Aksesoris'),
  ];

  void _toggleFavorite(int id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Icon(Icons.shopping_bag, color: Colors.blue[700]),
            const SizedBox(width: 8),
            const Text(
              'My Catalog',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentPage,
        children: [
          _buildHomePage(),
          _buildGridPage(),
          _buildFavoritePage(),
          _buildProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Banner
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.purple[600]!],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Temukan produk favoritmu di sini',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[400]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Cari produk...',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Feature Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 32)),
                      const SizedBox(height: 8),
                      Text(
                        'Hot Deals',
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text('✨', style: TextStyle(fontSize: 32)),
                      const SizedBox(height: 8),
                      Text(
                        'New Arrival',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Featured Products
          const Text(
            'Produk Pilihan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          ...products.take(3).map((product) => _buildProductCard(product)),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final isFavorite = _favorites.contains(product.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(product.image, style: const TextStyle(fontSize: 40)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () => _toggleFavorite(product.id),
          ),
        ],
      ),
    );
  }

  Widget _buildGridPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Semua Produk',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isFavorite = _favorites.contains(product.id);

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          product.image,
                          style: const TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rp ${(product.price / 1000).toStringAsFixed(0)}k',
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _toggleFavorite(product.id),
                                child: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritePage() {
    final favoriteProducts = products.where((p) => _favorites.contains(p.id)).toList();

    return favoriteProducts.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'Belum ada produk favorit',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Favorit Saya',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...favoriteProducts.map((product) => _buildProductCard(product)),
            ],
          );
  }

  Widget _buildProfilePage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Mahasiswa IF-23',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'user@student.univ.ac.id',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Favorit',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${_favorites.length} produk',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pengaturan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              _buildSettingItem('Notifikasi'),
              const Divider(height: 1),
              _buildSettingItem('Bahasa'),
              const Divider(height: 1),
              _buildSettingItem('Tentang Aplikasi', showDivider: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, {bool showDivider = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}