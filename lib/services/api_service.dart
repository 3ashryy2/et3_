import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl =
      'http://127.0.0.1:8000'; // Replace with your actual API base URL

  // Login API with error handling
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/accounts/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(
            response.body); // Return the response data if successful
      } else if (response.statusCode == 400) {
        throw Exception('Invalid credentials');
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Registration API with error handling
  static Future<Map<String, dynamic>> register(String username, String email,
      String phoneNumber, String password, String pin) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/accounts/register/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
          'pin': pin,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(
            response.body); // Return the response data if successful
      } else if (response.statusCode == 400) {
        throw Exception('Invalid registration data');
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Fetch user transactions API with error handling
  static Future<Map<String, dynamic>> fetchTransactions(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/home/'),
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return the transactions and balance
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Deposit funds API with error handling
  static Future<void> depositFunds(double amount, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/deposit/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({
          'amount': amount,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to deposit funds');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Withdraw funds API with error handling
  static Future<void> withdrawFunds(double amount, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/withdraw/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({
          'amount': amount,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to withdraw funds');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Send money API with error handling
  static Future<void> sendMoney(
      String recipient, double amount, String pin, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/send-money/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
        body: jsonEncode({
          'recipient': recipient,
          'amount': amount,
          'pin': pin,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send money');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static const String apiUrl =
      'http://api.weatherapi.com/v1/current.json'; // Replace with your API

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decode and return the JSON response
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
