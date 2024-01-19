class NavItems {
  final int index;
  final String icon;
  final String title;

  const NavItems({
    required this.index,
    required this.icon,
    required this.title,
  }) : assert(index >= 0, 'index cannot be nagative');
}