import 'package:flutter/material.dart';

import '../countries.dart';
import '../theme.dart';

/// A form field that opens a searchable country list showing each flag,
/// name and calling code.
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
           return InkWell(
             borderRadius: BorderRadius.circular(13),
             onTap: () async {
               final picked = await showCountryPicker(state.context);
               if (picked == null) return;
               state.didChange(picked);
               onChanged?.call(picked);
             },
             child: InputDecorator(
               decoration: InputDecoration(
                 labelText: label,
                 errorText: state.errorText,
                 suffixIcon: const Icon(Icons.expand_more),
               ),
               isEmpty: country == null,
               child: country == null
                   ? null
                   : Text(
                       '${country.flag}  ${country.name}  +${country.dialCode}',
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
    backgroundColor: TonitsColors.panel,
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

  List<Country> get _visible {
    final q = _query.trim().toLowerCase().replaceFirst('+', '');
    if (q.isEmpty) {
      final featured = Country.featuredCodes
          .map(Country.byCode)
          .whereType<Country>();
      return [
        ...featured,
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
    final countries = _visible;
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search country or code',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            Expanded(
              child: countries.isEmpty
                  ? const Center(child: Text('No country matches that search'))
                  : ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, i) {
                        final c = countries[i];
                        return ListTile(
                          leading: Text(
                            c.flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text(c.name),
                          trailing: Text(
                            '+${c.dialCode}',
                            style: const TextStyle(color: TonitsColors.muted),
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
