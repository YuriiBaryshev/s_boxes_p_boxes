import 'package:s_boxes_p_boxes/s_boxes_p_boxes.dart';
import 'package:test/test.dart';

void main() {
  group('AES S-box tests', () {
    final AESSBox sBox = AESSBox();

    setUp(() {
      // Additional setup goes here.
    });

    test('encrypts byte of data', () {
      expect(sBox.encryptByte(0), 0x63);
      expect(sBox.encryptByte(255), 0x16);
      expect(sBox.encryptByte(0x77), 0xf5);
    });


    test('decrypts byte of data', () {
      expect(sBox.decryptByte(0), 0x52);
      expect(sBox.decryptByte(255), 0x7d);
      expect(sBox.decryptByte(0x77), 2);
    });
  });
}
