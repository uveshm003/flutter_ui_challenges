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
    const doneCount = 0;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // ── App bar ──────────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xFF111827),
            foregroundColor: Colors.white,
            expandedHeight: 88,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'UI Challenges',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      Text('${registry.length} challenges', style: const TextStyle(fontSize: 11, color: Colors.white38)),
                    ],
                  ),
                  const Spacer(),
                  // "Done" pill badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.15), width: 0.5),
                    ),
                    child: Text('$doneCount done', style: const TextStyle(fontSize: 11, color: Colors.white60)),
                  ),
                ],
              ),
            ),
          ),

          // ── Search ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
              child: SearchBar(
                hintText: 'Search challenges...',
                leading: const Icon(Icons.search_rounded, size: 16),
                onChanged: (v) => setState(() => _query = v),
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surfaceContainerHighest),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.5), width: 0.5),
                  ),
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
                constraints: const BoxConstraints(minHeight: 40),
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
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((ctx, index) {
                  int cursor = 0;
                  for (int ci = 0; ci < categories.length; ci++) {
                    final cat = categories[ci];
                    final items = grouped[cat]!;
                    final dotColor = _categoryColors[allCategories.indexOf(cat) % _categoryColors.length];

                    if (index == cursor) {
                      return _CategoryHeader(label: cat, count: items.length, accentColor: dotColor);
                    }
                    cursor++;

                    if (index == cursor) {
                      // Render the whole category group as a single card
                      return _CategoryGroup(
                        challenges: items,
                        dotColor: dotColor,
                        onTap: (c) => Navigator.push(ctx, MaterialPageRoute(builder: c.builder)),
                      );
                    }
                    cursor++;
                  }
                  return null;
                }, childCount: categories.fold<int>(0, (sum, _) => sum + 2)),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Category header ───────────────────────────────────────────────────────────

class _CategoryHeader extends StatelessWidget {
  final String label;
  final int count;
  final Color accentColor;

  const _CategoryHeader({required this.label, required this.count, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 6),
      child: Row(
        children: [
          // Thin colored left accent bar
          Container(
            width: 3,
            height: 14,
            decoration: BoxDecoration(color: accentColor, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(width: 8),
          Text(
            label.toUpperCase(),
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.7, color: Theme.of(context).colorScheme.onSurfaceVariant),
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

// ── Category group (outlined card wrapping all tiles) ─────────────────────────

class _CategoryGroup extends StatelessWidget {
  final List<Challenge> challenges;
  final Color dotColor;
  final void Function(Challenge) onTap;

  const _CategoryGroup({required this.challenges, required this.dotColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < challenges.length; i++) ...[
                _ChallengeTile(challenge: challenges[i], dotColor: dotColor, onTap: () => onTap(challenges[i])),
                if (i < challenges.length - 1) Divider(height: 1, indent: 36, endIndent: 14, color: Theme.of(context).dividerColor.withOpacity(0.5)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Challenge tile ────────────────────────────────────────────────────────────

class _ChallengeTile extends StatelessWidget {
  final Challenge challenge;
  final Color dotColor;
  final VoidCallback onTap;

  const _ChallengeTile({required this.challenge, required this.dotColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(challenge.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 1),
                  Text(
                    challenge.description,
                    style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right_rounded, size: 16, color: Theme.of(context).dividerColor),
          ],
        ),
      ),
    );
  }
}
