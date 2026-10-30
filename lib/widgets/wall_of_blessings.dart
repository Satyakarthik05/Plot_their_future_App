import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/formatters.dart';
import '../models/gift_contribution.dart';
import '../state/flat_registry_provider.dart';
import 'deed_certificate_modal.dart';
import 'luxury_card.dart';

class WallOfBlessingsWidget extends ConsumerStatefulWidget {
  const WallOfBlessingsWidget({super.key});

  @override
  ConsumerState<WallOfBlessingsWidget> createState() => _WallOfBlessingsWidgetState();
}

class _WallOfBlessingsWidgetState extends ConsumerState<WallOfBlessingsWidget> {
  String _filterRoom = 'all';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final registry = ref.watch(flatRegistryProvider);

    final filteredList = registry.contributions.where((c) {
      final matchesRoom = _filterRoom == 'all' || c.roomId == _filterRoom;
      final matchesQuery = _searchQuery.isEmpty ||
          c.donorName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.blessingMessage.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesRoom && matchesQuery;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WALL OF BLESSINGS & FOUNDATIONS',
                  style: GoogleFonts.cinzel(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.lightGold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  '${registry.totalContributors} loved ones have laid foundation stones',
                  style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.textMuted),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryGold.withOpacity(0.5)),
              ),
              child: Text(
                '${registry.totalGiftedSqFt} sq.ft. gifted',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightGold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Search Bar
        TextField(
          onChanged: (val) => setState(() => _searchQuery = val),
          decoration: InputDecoration(
            hintText: 'Search blessings or guest name...',
            prefixIcon: const Icon(Icons.search, color: AppTheme.primaryGold, size: 20),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: AppTheme.surfaceCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.goldBorder),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Room filter chips
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: registry.rooms.length + 1,
            separatorBuilder: (_, _) => const SizedBox(width: 6),
            itemBuilder: (context, index) {
              if (index == 0) {
                final isSelected = _filterRoom == 'all';
                return _buildFilterPill('All Spaces', isSelected, () => setState(() => _filterRoom = 'all'));
              }
              final r = registry.rooms[index - 1];
              final isSelected = _filterRoom == r.id;
              return _buildFilterPill(r.name.split('&').first.trim(), isSelected, () => setState(() => _filterRoom = r.id));
            },
          ),
        ),
        const SizedBox(height: 16),

        // Contributions list
        if (filteredList.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Column(
                children: [
                  const Icon(Icons.favorite_border, color: AppTheme.textMuted, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'No blessings found matching your search.',
                    style: GoogleFonts.outfit(color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
          )
        else
          ...filteredList.map((contrib) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildContributionCard(context, contrib, registry),
              )),
      ],
    );
  }

  Widget _buildFilterPill(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGold : AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGold : Colors.white12,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContributionCard(BuildContext context, GiftContribution contrib, FlatRegistryState registry) {
    return LuxuryCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contrib.donorName,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contrib.relationship,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: AppTheme.lightGold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.primaryGold.withOpacity(0.4)),
                ),
                child: Column(
                  children: [
                    Text(
                      '${contrib.sqFt} SQ.FT.',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightGold,
                      ),
                    ),
                    Text(
                      Formatters.formatCurrency(contrib.amount, inINR: registry.useINR),
                      style: GoogleFonts.outfit(
                        fontSize: 10,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Room dedicated badge
          Row(
            children: [
              const Icon(Icons.home, color: AppTheme.primaryGold, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Dedicated to: ${contrib.roomName}',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Blessing note
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote, color: AppTheme.primaryGold, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"${contrib.blessingMessage}"',
                    style: GoogleFonts.outfit(
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.85),
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Footer with token and view certificate button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deed: ${contrib.deedToken} • ${Formatters.formatDateShort(contrib.timestamp)}',
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: AppTheme.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeedCertificateModal(contribution: contrib),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium_outlined, color: AppTheme.lightGold, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'View Deed',
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.lightGold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
