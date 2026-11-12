import 'package:flutter/material.dart';
import '../models/ormawa_model.dart';
import '../widgets/ormawa_card.dart';
import '../widgets/responsive_layout.dart';
import '../widgets/state_view_widget.dart';

class OrmawaListScreen extends StatelessWidget {
  final List<OrmawaModel> ormawaList;
  final void Function(OrmawaModel)? onSelectOrmawa;

  const OrmawaListScreen({
    super.key,
    this.ormawaList = const [],
    this.onSelectOrmawa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Ormawa Undiksha'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount =
              ResponsiveLayout.getGridCrossAxisCount(constraints.maxWidth);

          if (ormawaList.isEmpty) {
            return const StateViewWidget(
              icon: Icons.search_off_rounded,
              title: 'Belum Ada Data Ormawa',
              subtitle: 'Data organisasi mahasiswa akan tampil di sini setelah terhubung ke API.',
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 195,
            ),
            itemCount: ormawaList.length,
            itemBuilder: (context, index) {
              final item = ormawaList[index];
              return OrmawaCard(
                ormawa: item,
                onTap: () => onSelectOrmawa?.call(item),
              );
            },
          );
        },
      ),
    );
  }
}