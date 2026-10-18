import 'package:flutter_test/flutter_test.dart';
import 'package:tonits/core/countries.dart';
import 'package:tonits/features/account/ui/phone_number.dart';

void main() {
  final kenya = Country.byCode('KE')!;
  final india = Country.byCode('IN')!;
  final us = Country.byCode('US')!;

  test('Kenyan numbers must be mobile numbers', () {
    expect(PhoneNumber.normalize('0712 345 678', kenya), '+254712345678');
    expect(PhoneNumber.normalize('020 123 4567', kenya), isNull);
  });

  test('other countries take the calling code and drop the trunk zero', () {
    expect(PhoneNumber.normalize('098123 45678', india), '+919812345678');
    expect(PhoneNumber.normalize('(512) 555-0134', us), '+15125550134');
    expect(PhoneNumber.normalize('12345', us), isNull);
  });

  test('an international number is kept as typed', () {
    expect(PhoneNumber.normalize('+44 7700 900123', us), '+447700900123');
    expect(PhoneNumber.normalize('0044 7700 900123', us), '+447700900123');
  });

  test('a saved number is shown the local way', () {
    expect(PhoneNumber.local('+254712345678', kenya), '0712345678');
    expect(PhoneNumber.local('+15125550134', us), '5125550134');
  });
}
