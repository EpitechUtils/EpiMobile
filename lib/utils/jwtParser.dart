import 'dart:convert';

class JwtParser {

    /// Parse jwt token and return all fields
    static Map<String, dynamic> parse(String token) {
        final parts = token.split('.');
        if (parts.length != 3) {
            throw Exception('invalid token');
        }

        // Decode base64
        final payload = (String str) {
            String output = str.replaceAll('-', '+').replaceAll('_', '/');

            switch (output.length % 4) {
                case 0:
                    break;
                case 2:
                    output += '==';
                    break;
                case 3:
                    output += '=';
                    break;
                default:
                    throw Exception('Illegal base64url string!"');
            }

            return utf8.decode(base64Url.decode(output));
        }(parts[1]);

        // Get and parse payload
        final payloadMap = json.decode(payload);
        if (payloadMap is! Map<String, dynamic>) {
            throw Exception('invalid payload');
        }

        return payloadMap;
    }
}