import 'dart:typed_data';

import 'package:s_boxes_p_boxes/s_boxes_p_boxes.dart';
import 'package:test/test.dart';

void main() {
  group('AES S-box tests', () {
    final AESSBox sBox = AESSBox();

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


    test('encrypting and decrypting are compatible', () {
      Uint8List plaintext = Uint8List.fromList([0, 1, 2, 3, 42, 123, 200, 255]);
      for(int plaintextByte in plaintext) {
        int ciphertextByte = sBox.encryptByte(plaintextByte);
        expect(sBox.decryptByte(ciphertextByte), plaintextByte);
      }
    });


    test('encrypts byte array', () {
      Uint8List plaintext = Uint8List.fromList([0, 255, 0x77]);
      Uint8List ciphertext = Uint8List.fromList([0x63, 22, 0xf5]);
      expect(sBox.encryptByteArray(plaintext), ciphertext);
    });


    test('decrypts byte array', () {
      Uint8List ciphertext = Uint8List.fromList([0, 255, 0x77]);
      Uint8List plaintext = Uint8List.fromList([0x52, 0x7d, 2]);
      expect(sBox.decryptByteArray(ciphertext), plaintext);
    });


    test('encryptByte validates data', () {
      expect(() => sBox.encryptByte(256), throwsArgumentError);
      expect(() => sBox.encryptByte(-1), throwsArgumentError);
    });


    test('decryptByte validates data', () {
      expect(() => sBox.decryptByte(256), throwsArgumentError);
      expect(() => sBox.decryptByte(-1), throwsArgumentError);
    });
  });
}
