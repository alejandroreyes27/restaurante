import 'package:flutter/material.dart';

class AdaptiveNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isMobile;

  const AdaptiveNavigation({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final destinations = const [
      NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menú'),
      NavigationDestination(
        icon: Icon(Icons.info_outline),
        label: 'Sobre Nosotros',
      ),
      NavigationDestination(
        icon: Icon(Icons.contact_mail),
        label: 'Contáctenos',
      ),
    ];

    if (isMobile) {
      return NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(destinations.length, (index) {
          final dest = destinations[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton.icon(
              icon: dest.icon,
              label: Text(dest.label),
              style: TextButton.styleFrom(
                foregroundColor:
                    selectedIndex == index ? Colors.deepOrange : Colors.black87,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => onDestinationSelected(index),
            ),
          );
        }),
      );
    }
  }
}
