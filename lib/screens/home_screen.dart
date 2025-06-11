import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../widgets/product_card.dart';
import '../widgets/adaptive_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/about');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/contact');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurante'),
        centerTitle: true,
        actions:
            isMobile
                ? null
                : [
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Center(
                      child: SizedBox(
                        height: 48,
                        child: AdaptiveNavigation(
                          selectedIndex: _selectedIndex,
                          onDestinationSelected: _onNavTap,
                          isMobile: false,
                        ),
                      ),
                    ),
                  ),
                ],
      ),
      drawer:
          isMobile
              ? Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(color: Colors.deepOrange),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/70497/pexels-photo-70497.jpeg',
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Restaurante Ejemplo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: const Text('Menú'),
                      onTap: () {
                        Navigator.pop(context);
                        _onNavTap(0);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('Sobre Nosotros'),
                      onTap: () {
                        Navigator.pop(context);
                        _onNavTap(1);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.contact_mail),
                      title: const Text('Contáctenos'),
                      onTap: () {
                        Navigator.pop(context);
                        _onNavTap(2);
                      },
                    ),
                  ],
                ),
              )
              : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          double horizontalPadding = 8;
          if (constraints.maxWidth >= 1100) {
            crossAxisCount = 4;
            horizontalPadding = 48;
          } else if (constraints.maxWidth >= 900) {
            crossAxisCount = 3;
            horizontalPadding = 32;
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 2;
            horizontalPadding = 16;
          } else {
            crossAxisCount = 2;
            horizontalPadding = 8;
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16,
            ),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          );
        },
      ),
      bottomNavigationBar:
          isMobile
              ? AdaptiveNavigation(
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onNavTap,
                isMobile: true,
              )
              : null,
    );
  }
}
