import 'package:flutter/material.dart';
import 'package:flutter_ui_challenges/registry/challenge_model.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'UI Challenges', debugShowCheckedModeBanner: false, home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _query = '';

  // Assign a consistent color per category
  static const _categoryColors = [Color(0xFF378ADD), Color(0xFF1D9E75), Color(0xFF7F77DD), Color(0xFFD85A30), Color(0xFFBA7517), Color(0xFFD4537E)];

  List<Challenge> get _filtered => _query.isEmpty
      ? registry
      : registry
            .where(
              (c) =>
                  c.title.toLowerCase().contains(_query.toLowerCase()) ||
                  c.category.toLowerCase().contains(_query.toLowerCase()) ||
                  c.description.toLowerCase().contains(_query.toLowerCase()),
            )
            .toList();

  Map<String, List<Challenge>> get _grouped {
    final map = <String, List<Challenge>>{};
    for (final c in _filtered) {
      map.putIfAbsent(c.category, () => []).add(c);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _grouped;
    final categories = grouped.keys.toList();
    final allCategories = registry.map((c) => c.category).toSet().toList();
    final doneCount = 0; // hook up persistence later if needed

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App bar ──────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF111827),
            foregroundColor: Colors.white,
            expandedHeight: 96,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'UI Challenges',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  Text('${registry.length} challenges · $doneCount done', style: const TextStyle(fontSize: 11, color: Colors.white54)),
                ],
              ),
            ),
          ),

          // ── Search ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: SearchBar(
                hintText: 'Search challenges...',
                leading: const Icon(Icons.search_rounded, size: 18),
                onChanged: (v) => setState(() => _query = v),
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surfaceContainerHighest),
                padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
                constraints: const BoxConstraints(minHeight: 42),
              ),
            ),
          ),

          // ── List ─────────────────────────────────────────────────
          if (_filtered.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text('No challenges found', style: TextStyle(color: Colors.grey)),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                int cursor = 0;
                for (int ci = 0; ci < categories.length; ci++) {
                  final cat = categories[ci];
                  final items = grouped[cat]!;
                  final dotColor = _categoryColors[allCategories.indexOf(cat) % _categoryColors.length];

                  if (index == cursor) {
                    // Category header
                    return _CategoryHeader(label: cat, count: items.length);
                  }
                  cursor++;

                  if (index < cursor + items.length) {
                    final challenge = items[index - cursor];
                    final isLast = index == cursor + items.length - 1;
                    return _ChallengeTile(
                      challenge: challenge,
                      dotColor: dotColor,
                      showDivider: !isLast,
                      onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: challenge.builder)),
                    );
                  }
                  cursor += items.length;
                }
                return null;
              }, childCount: categories.fold<int>(0, (sum, cat) => sum + 1 + grouped[cat]!.length)),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// ── Category header ───────────────────────────────────────────────────────────

class _CategoryHeader extends StatelessWidget {
  final String label;
  final int count;

  const _CategoryHeader({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.9, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).dividerColor, width: 0.5),
            ),
            child: Text('$count', style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}

// ── Challenge tile ────────────────────────────────────────────────────────────

class _ChallengeTile extends StatelessWidget {
  final Challenge challenge;
  final Color dotColor;
  final bool showDivider;
  final VoidCallback onTap;

  const _ChallengeTile({required this.challenge, required this.dotColor, required this.showDivider, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          leading: Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          leadingAndTrailingTextStyle: const TextStyle(),
          title: Text(challenge.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          subtitle: Text(challenge.description, style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.chevron_right_rounded, size: 18),
        ),
        if (showDivider) const Divider(height: 1, indent: 40, endIndent: 16),
      ],
    );
  }
}
