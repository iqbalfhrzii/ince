// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:chefgenius_final/main.dart'; // NAMA PROYEK DIPERBAIKI DI SINI

void main() {
  // Isi tes yang lama kita hapus karena tidak relevan dengan aplikasi kita.
  // Anda bisa menulis tes yang sesungguhnya di sini nanti untuk fase UAS.
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Membangun aplikasi kita dan memicu sebuah frame.
    await tester.pumpWidget(const MyApp());

    // Contoh tes sederhana: Pastikan judul "Selamat Datang" ada di halaman login.
    expect(find.text('Selamat Datang di Chef Genius'), findsOneWidget);
  });
}