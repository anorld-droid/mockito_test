import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito_test/models/album.dart';

import 'album_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  late http.Client client;

  setUp(() {
    client = MockClient();
  });

  group('fetchAlbum', () {
    test('returns an [Album] if the fetch completes succeddfully', () async {
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.

      ///Arrange
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      //Act
      final actual = await fetchAlbum(client);

      //Assert
      expect(actual, isA<Album>());
      // verifyNoMoreInteractions(client);
    });
    test('throws an exception if the http call completes with an error', () {
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      //Arrange
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
