import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/adaptive_nav.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final String _googleMapsUrl =
      'https://www.google.com/maps/place/Calle+Principal+123,+Ciudad,+Pa%C3%ADs';

  int _selectedIndex = 2;

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

  void _launchMaps() async {
    final Uri url = Uri.parse(_googleMapsUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contáctenos'),
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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '¿Tienes alguna pregunta o comentario?',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Teléfono: (555) 123-4567',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'Correo: contacto@restauranteejemplo.com',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 24),
                const Text(
                  '¡Visítanos!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _launchMaps,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepOrange, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://maps.googleapis.com/maps/api/staticmap?center=Calle+Principal+123,Ciudad,Pa%C3%ADs&zoom=15&size=700x300&maptype=roadmap&markers=color:red%7Clabel:R%7CCalle+Principal+123,Ciudad,Pa%C3%ADs&key=YOUR_API_KEY',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Ver en Google Maps',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black54,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Dirección: Calle Principal 123, Ciudad, País',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
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
