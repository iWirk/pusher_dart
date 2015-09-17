// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library pusher.validate.test;

import 'package:pusher/src/pusher.dart' show validateSocketId,validateChannelName,validateListOfChannelNames,CHANNEL_NAME_MAX_LENGTH;
import 'package:test/test.dart';

String str_repeat(String piece, int multiplier){
  return new List<String>.filled(multiplier, 'a').join('');
}

void main() {


  group('validateSocketId()', () {

    test('SocketId cannot contain colon prefix', () {
      expect(() => validateSocketId(':444.444'),throwsFormatException);
    });

    test('SocketId cannot contain colon sufix', () {
      expect(() => validateSocketId('444.444:'),throwsFormatException);
    });

    test('socket_id_cannot_contain_letters_suffix', () {
      expect(() => validateSocketId('444.444a'),throwsFormatException);
    });

    test('socket_id_must_contain_a_period_point', () {
      expect(() => validateSocketId('444'),throwsFormatException);
    });

    test('socket_id_must_not_contain_newline_prefix', () {
      expect(() => validateSocketId('\n444.444'),throwsFormatException);
    });

    test('socket_id_must_not_contain_newline_suffix', () {
      expect(() => validateSocketId('444.444\n'),throwsFormatException);
    });

    test('socket_id_must_not_be_empty_string', () {
      expect(() => validateSocketId(''),throwsFormatException);
    });

    test('Should not throw a exception',(){
      expect(() => validateSocketId('444.444'), returnsNormally);
    });

    test('It can be null',(){
      expect(() => validateSocketId(null), returnsNormally);
    });

  });

  group('validateChannelName()', ()
  {

    test('channel_must_not_have_trailing_colon', () {
      expect(() => validateChannelName('private-channel:'), throwsFormatException);
    });

    test('channel_name_must_not_have_leading_colon', () {
      expect(() => validateChannelName(':private-channel'), throwsFormatException);
    });

    test('channel_name_must_not_have_leading_colon_newline', () {
      expect(() => validateChannelName(":\nprivate-channel"), throwsFormatException);
    });

    test('channel_name_must_not_have_trailing_colon_newline', () {
      expect(() => validateChannelName('private-channel\n:'), throwsFormatException);
    });

    test('channel_names_must_not_exceed_allowed_length', () {
      expect(() => validateChannelName(str_repeat('.',CHANNEL_NAME_MAX_LENGTH + 1)), throwsArgumentError);
    });

    test('Should not throw a exception',(){
      expect(() => validateChannelName('my-channel'), returnsNormally);
    });
  });


  group('validateListOfChannelName()', ()
  {
    test('Should not throw a exception', () {
      expect(() => validateListOfChannelNames(['private-channel','private-message']), returnsNormally);
    });

    test('Should throw a FormatException', () {
      expect(() => validateListOfChannelNames(['private-channel',':private-message']), throwsFormatException);
    });
  });

}