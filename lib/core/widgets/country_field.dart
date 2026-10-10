import 'package:flutter/material.dart';

import '../countries.dart';
import '../theme.dart';
import 'labeled_field.dart';
import 'section_header.dart';

/// A labelled form field that opens a searchable country list showing each
/// flag, name and calling code.
class CountryField extends FormField<Country> {
  CountryField({
    super.key,
    super.initialValue,
    super.validator,
    ValueChanged<Country>? onChanged,
    String label = 'Country',
  }) : super(
         builder: (state) {
           final country = state.value;
           final palette = state.context.palette;
           return LabeledField(
             label: label,
             child: InkWell(
               borderRadius: BorderRadius.circular(TonitsRadius.control),
               onTap: () async {
                 final picked = await showCountryPicker(state.context);
                 if (picked == null) return;
                 state.didChange(picked);
                 onChanged?.call(picked);
               },
               child: InputDecorator(
                 decoration: InputDecoration(
                   hintText: 'Choose your country',
                   errorText: state.errorText,
                   prefixIcon: country == null
                       ? null
                       : Padding(
                           padding: const EdgeInsets.only(left: 16, right: 10),
                           child: Text(
                             country.flag,
                             style: const TextStyle(fontSize: 20),
                           ),
                         ),
                   prefixIconConstraints: const BoxConstraints(minWidth: 40),
                   suffixIcon: const Icon(Icons.expand_more),
                 ),
                 isEmpty: country == null,
                 child: country == null
                     ? null
                     : Row(
                         children: [
                           Expanded(
                             child: Text(
                               country.name,
                               overflow: TextOverflow.ellipsis,
                             ),
                           ),
                           Text(
                             '+${country.dialCode}',
                             style: monoFont.copyWith(
                               color: palette.mutedForeground,
                             ),
                           ),
                         ],
                       ),
               ),
             ),
           );
         },
       );
}

Future<Country?> showCountryPicker(BuildContext context) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    builder: (_) => const _CountryPickerSheet(),
  );
}

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet();

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  String _query = '';

  /// Rows to show: section headings as strings, countries as [Country].
  List<Object> get _rows {
    final q = _query.trim().toLowerCase().replaceFirst('+', '');
    if (q.isEmpty) {
      return [
        'Suggested',
        ...Country.featuredCodes.map(Country.byCode).whereType<Country>(),
        'All countries',
        ...Country.all.where((c) => !Country.featuredCodes.contains(c.code)),
      ];
    }
    return Country.all
        .where(
          (c) =>
              c.name.toLowerCase().contains(q) ||
              c.code.toLowerCase() == q ||
              c.dialCode.startsWith(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final rows = _rows;
    final palette = context.palette;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TonitsSpace.lg),
              child: Text(
                'Choose your country',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                TonitsSpace.lg,
                TonitsSpace.md,
                TonitsSpace.lg,
                TonitsSpace.sm,
              ),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search country or code',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  fillColor: palette.muted,
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            Expanded(
              child: rows.isEmpty
                  ? Center(
                      child: Text(
                        'No country matches that search',
                        style: TextStyle(color: palette.subtleForeground),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TonitsSpace.sm,
                      ),
                      itemCount: rows.length,
                      itemBuilder: (context, i) {
                        final row = rows[i];
                        if (row is String) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
                            child: SectionLabel(row),
                          );
                        }
                        final c = row as Country;
                        return ListTile(
                          leading: Text(
                            c.flag,
                            style: const TextStyle(fontSize: 22),
                          ),
                          title: Text(c.name),
                          trailing: Text(
                            '+${c.dialCode}',
                            style: monoFont.copyWith(
                              fontSize: 13,
                              color: palette.mutedForeground,
                            ),
                          ),
                          onTap: () => Navigator.pop(context, c),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
