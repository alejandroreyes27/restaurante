import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../widgets/product_card.dart';
import '../widgets/adaptive_nav.dart';
import 'package:url_launcher/url_launcher.dart'; // Cambiado a url_launcher.dart
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        title: const Text('Restaurante San Angel'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        actions: isMobile
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
      drawer: isMobile
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 163, 9, 9),
                    ),
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
                          'Restaurante',
                          style: TextStyle(
                            color: Color.fromARGB(255, 254, 254, 254),
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
          double childAspectRatio = 0.85;
          if (constraints.maxWidth >= 1300) {
            crossAxisCount = 5;
            childAspectRatio = 0.78;
          } else if (constraints.maxWidth >= 1100) {
            crossAxisCount = 4;
            childAspectRatio = 0.80;
          } else if (constraints.maxWidth >= 900) {
            crossAxisCount = 3;
            childAspectRatio = 0.82;
          } else if (constraints.maxWidth >= 600) {
            crossAxisCount = 2;
            childAspectRatio = 0.85;
          } else {
            crossAxisCount = 2;
            childAspectRatio = 0.90;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF25D366),
        onPressed: () async {
          final whatsappUrl = Uri.parse(
            "https://wa.me/3126566205?text=${Uri.encodeComponent("Hola, me gustaría hacer una reserva.")}",
          );
          if (await canLaunchUrl(whatsappUrl)) {
            await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No se pudo abrir WhatsApp")),
            );
          }
        },
        tooltip: 'Reserva por WhatsApp',
        child: const FaIcon(
          FontAwesomeIcons.whatsapp,
          color: Colors.white,
          size: 32,
        ),
      ),
      bottomNavigationBar: isMobile
          ? AdaptiveNavigation(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onNavTap,
              isMobile: true,
            )
          : null,
    );
  }
}
