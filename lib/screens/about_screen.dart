import 'package:flutter/material.dart';

import '../widgets/adaptive_nav.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _selectedIndex = 1;

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
        title: const Text('Sobre Nosotros'),
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
              children: const [
                Text(
                  'Bienvenido a Restaurante Ejemplo',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 24),
                Text(
                  'Somos un restaurante dedicado a ofrecer la mejor experiencia gastronómica, combinando ingredientes frescos, recetas tradicionales y un ambiente acogedor. ¡Visítanos y descubre por qué somos la mejor opción para ti y tu familia!',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Divider(),
                SizedBox(height: 24),
                Text(
                  'Contacto:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Teléfono: (555) 123-4567',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Correo: contacto@restauranteejemplo.com',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Dirección: Calle Principal 123, Ciudad, País',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 32),
                Divider(),
                SizedBox(height: 24),
                Text(
                  'Horario:',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Lunes a Domingo: 12:00 pm - 11:00 pm',
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
