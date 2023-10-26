// navbar.dart

class Navbar {
  String content;
  String route;

  Navbar({
    required this.content,
    required this.route,
  });
}

List<Navbar> sampleNavbar = [
  Navbar(
    content: 'All',
    route: '/all',
  ),
  Navbar(
    content: 'Favorite',
    route: '/favorite',
  ),
  Navbar(
    content: 'Recent',
    route: '/recent',
  ),
  Navbar(
    content: 'Latest',
    route: '/latest',
  ),
  Navbar(
    content: 'Important',
    route: '/important',
  ),
  Navbar(
    content: 'Accounts',
    route: '/accounts',
  ),
];
