import 'package:flutter/material.dart';

class AndroidStyleComparisonScreen extends StatelessWidget {
  const AndroidStyleComparisonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final legacyTokens = _PreviewTokens(
      label: 'Legacy Android',
      titleColor: const Color.fromRGBO(11, 87, 208, 1),
      listBackground: const Color.fromRGBO(240, 240, 240, 1),
      cardBackground: Colors.white,
      tileTextColor: const Color.fromARGB(255, 27, 27, 27),
      descriptionColor: const Color.fromARGB(255, 70, 70, 70),
      iconColor: const Color.fromARGB(255, 70, 70, 70),
      tileHorizontalPadding: 24,
      tileVerticalPadding: 19,
      titleFontSize: 18,
      titleFontWeight: FontWeight.w400,
      badgeColor: const Color.fromRGBO(11, 87, 208, 0.14),
    );

    final refreshedTokens = _PreviewTokens(
      label: 'Android SDK 36+ Refreshed',
      titleColor: colorScheme.primary,
      listBackground: Color.alphaBlend(
        colorScheme.primary.withValues(alpha: 0.04),
        colorScheme.surface,
      ),
      cardBackground: Color.alphaBlend(
        colorScheme.primary.withValues(alpha: 0.05),
        colorScheme.surface,
      ),
      tileTextColor: colorScheme.onSurface,
      descriptionColor: colorScheme.onSurface.withValues(alpha: 0.78),
      iconColor: colorScheme.onSurface.withValues(alpha: 0.72),
      tileHorizontalPadding: 20,
      tileVerticalPadding: 14,
      titleFontSize: 17,
      titleFontWeight: FontWeight.w500,
      badgeColor: colorScheme.primary.withValues(alpha: 0.14),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Android Style Comparison')),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            final children = [
              Expanded(child: _StyleCard(tokens: legacyTokens)),
              const SizedBox(width: 16, height: 16),
              Expanded(child: _StyleCard(tokens: refreshedTokens)),
            ];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: children,
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _StyleCard extends StatelessWidget {
  const _StyleCard({required this.tokens});

  final _PreviewTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tokens.listBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(
                  tokens.label,
                  style: TextStyle(
                    color: tokens.titleColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: tokens.badgeColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'pad ${tokens.tileHorizontalPadding}/${tokens.tileVerticalPadding} - ${tokens.titleFontSize.toStringAsFixed(0)}pt',
                    style: TextStyle(
                      color: tokens.titleColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              color: tokens.cardBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                _PreviewTile(
                  icon: Icons.wifi,
                  title: 'Network & internet',
                  description: 'Mobile, Wi-Fi, hotspot',
                  tokens: tokens,
                ),
                Divider(height: 1, color: Colors.black.withValues(alpha: 0.06)),
                _PreviewTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  description: 'History, conversations',
                  tokens: tokens,
                ),
                Divider(height: 1, color: Colors.black.withValues(alpha: 0.06)),
                _PreviewTile(
                  icon: Icons.palette_outlined,
                  title: 'Wallpaper & style',
                  description: 'Colors, themed icons',
                  tokens: tokens,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewTile extends StatelessWidget {
  const _PreviewTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.tokens,
  });

  final IconData icon;
  final String title;
  final String description;
  final _PreviewTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: tokens.tileHorizontalPadding,
        vertical: tokens.tileVerticalPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tokens.iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: tokens.tileTextColor,
                    fontSize: tokens.titleFontSize,
                    fontWeight: tokens.titleFontWeight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: tokens.descriptionColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewTokens {
  const _PreviewTokens({
    required this.label,
    required this.titleColor,
    required this.listBackground,
    required this.cardBackground,
    required this.tileTextColor,
    required this.descriptionColor,
    required this.iconColor,
    required this.tileHorizontalPadding,
    required this.tileVerticalPadding,
    required this.titleFontSize,
    required this.titleFontWeight,
    required this.badgeColor,
  });

  final String label;
  final Color titleColor;
  final Color listBackground;
  final Color cardBackground;
  final Color tileTextColor;
  final Color descriptionColor;
  final Color iconColor;
  final double tileHorizontalPadding;
  final double tileVerticalPadding;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final Color badgeColor;
}
