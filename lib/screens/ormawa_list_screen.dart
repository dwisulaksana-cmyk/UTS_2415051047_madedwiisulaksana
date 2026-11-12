import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ormawa_model.dart';
import '../providers/ormawa_provider.dart';
import '../providers/saved_ormawa_provider.dart';
import '../widgets/category_filter_chip.dart';
import '../widgets/ormawa_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/state_view_widget.dart';

class OrmawaListScreen extends StatefulWidget {
  final void Function(OrmawaModel)? onSelectOrmawa;

  const OrmawaListScreen({super.key, this.onSelectOrmawa});

  @override
  State<OrmawaListScreen> createState() => _OrmawaListScreenState();
}

class _OrmawaListScreenState extends State<OrmawaListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ormawaProvider = context.watch<OrmawaProvider>();
    final savedProvider = context.watch<SavedOrmawaProvider>();
    final filteredList = ormawaProvider.filteredOrmawa;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Ormawa Undiksha'),
        actions: [
          IconButton(
            tooltip: 'Muat Ulang Katalog',
            icon: const Icon(Icons.refresh),
            onPressed: () => ormawaProvider.loadOrmawaCatalog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
                ormawaProvider.setSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Cari nama, singkatan, atau fakultas Ormawa...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                          ormawaProvider.setSearchQuery('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: ormawaProvider.categories.length,
              itemBuilder: (context, index) {
                final category = ormawaProvider.categories[index];
                return CategoryFilterChip(
                  label: category,
                  isSelected: ormawaProvider.selectedCategory == category,
                  onSelected: () => ormawaProvider.setCategory(category),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: _buildBody(ormawaProvider, savedProvider, filteredList),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    OrmawaProvider ormawaProvider,
    SavedOrmawaProvider savedProvider,
    List<OrmawaModel> filteredList,
  ) {
    if (ormawaProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ormawaProvider.errorMessage != null) {
      return StateViewWidget(
        icon: Icons.cloud_off_rounded,
        iconColor: Colors.red.shade700,
        title: 'Gagal Memuat Katalog',
        subtitle: ormawaProvider.errorMessage!,
        actionLabel: 'Coba Lagi',
        onAction: () => ormawaProvider.loadOrmawaCatalog(),
      );
    }

    if (filteredList.isEmpty) {
      return StateViewWidget(
        icon: Icons.search_off_rounded,
        title: 'Ormawa Tidak Ditemukan',
        subtitle: 'Tidak ada organisasi mahasiswa yang cocok dengan kata kunci atau kategori yang dipilih.',
        actionLabel: 'Reset Filter',
        onAction: () {
          _searchController.clear();
          setState(() {});
          ormawaProvider.resetFilters();
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount =
            ResponsiveLayout.getGridCrossAxisCount(constraints.maxWidth);

        return RefreshIndicator(
          onRefresh: () => ormawaProvider.loadOrmawaCatalog(),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 195,
            ),
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final item = filteredList[index];
              final isSaved = savedProvider.isOrmawaSaved(item.id);
              return OrmawaCard(
                ormawa: item,
                isSaved: isSaved,
                onTap: () => widget.onSelectOrmawa?.call(item),
              );
            },
          ),
        );
      },
    );
  }
}