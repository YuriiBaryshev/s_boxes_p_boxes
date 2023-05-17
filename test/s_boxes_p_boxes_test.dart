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


  group('P-box tests', () {
    PBox directPBox = PBox([0, 1, 2, 3, 4, 5, 6, 7]);
    PBox shiftLeft = PBox([1, 2, 3, 4, 5, 6, 7, 0]);
    PBox mirrorPermutation = PBox([7, 6, 5, 4, 3, 2, 1, 0]);
    PBox switchNeighbors = PBox([1, 0, 3, 2, 5, 4, 7, 6]);

    test('fails to create P box with number of elements that differs from 8', () {
      expect(() => PBox([1, 2, 3, 4, 5, 6, 7]), throwsArgumentError);
      expect(() => PBox([1, 2, 3, 4, 5, 6, 7, 7, 7]), throwsArgumentError);
    });


    test('fails to create P box with negative values within rule', () {
      expect(() => PBox([1, 2, 3, 4, 5, 6, 7, -1]), throwsArgumentError);
      expect(() => PBox([-1, 2, 3, 4, 5, 6, 7, 0]), throwsArgumentError);
    });


    test('fails to create P box with rule values larger than 7', () {
      expect(() => PBox([1, 2, 3, 4, 5, 6, 7, 8]), throwsArgumentError);
      expect(() => PBox([42, 2, 3, 4, 5, 6, 7, 1]), throwsArgumentError);
    });


    test('fails to create P box without unique values', () {
      expect(() => PBox([1, 2, 3, 4, 5, 6, 7, 7]), throwsArgumentError);
      expect(() => PBox([1, 1, 1, 1, 1, 1, 1, 1]), throwsArgumentError);
    });


    test('manage to create P box with proper rules', () {
      expect(() => PBox([1, 2, 3, 4, 5, 6, 7, 0]), returnsNormally);
      expect(() => PBox([7, 6, 5, 4, 3, 2, 1, 0]), returnsNormally);
    });


    test('encrypt using different P-boxes', () {
      expect(directPBox.encryptByte(0x55), 0x55);
      expect(directPBox.encryptByte(0xa5), 0xa5);
      expect(directPBox.encryptByte(0xc3), 0xc3);

      expect(shiftLeft.encryptByte(0x55), 0xaa);
      expect(shiftLeft.encryptByte(0xa5), 0xd2);
      expect(shiftLeft.encryptByte(0xc3), 0xe1);

      expect(mirrorPermutation.encryptByte(0xf0), 0x0f);
      expect(mirrorPermutation.encryptByte(0xac), 0x35);
      expect(mirrorPermutation.encryptByte(0x42), 0x42);

      expect(switchNeighbors.encryptByte(0xf0), 0xf0);
      expect(switchNeighbors.encryptByte(0xac), 0x5c);
      expect(switchNeighbors.encryptByte(0x42), 0x81);
    });


    test('decrypt using different P-boxes', () {
      expect(directPBox.decryptByte(0x55), 0x55);
      expect(directPBox.decryptByte(0xa5), 0xa5);
      expect(directPBox.decryptByte(0xc3), 0xc3);

      expect(shiftLeft.decryptByte(0x55), 0xaa);
      expect(shiftLeft.decryptByte(0xd2), 0xa5);
      expect(shiftLeft.decryptByte(0xe1), 0xc3);

      expect(mirrorPermutation.decryptByte(0x0f), 0xf0);
      expect(mirrorPermutation.decryptByte(0x35), 0xac);
      expect(mirrorPermutation.decryptByte(0x42), 0x42);

      expect(switchNeighbors.decryptByte(0xf0), 0xf0);
      expect(switchNeighbors.decryptByte(0x5c), 0xac);
      expect(switchNeighbors.decryptByte(0x81), 0x42);
    });
  });
}
