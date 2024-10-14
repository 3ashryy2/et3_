import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/api_service.dart';
import '../widgets/footer.dart';

class ApiTestPage extends StatefulWidget {
  @override
  _ApiTestPageState createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  late Future<Map<String, dynamic>> futureData;

  @override
  void initState() {
    super.initState();
    // Fetch the data when the page initializes
    futureData = ApiService().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test'),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading spinner while waiting for response
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Show error message if API call fails
            } else if (snapshot.hasData) {
              // Convert the raw JSON into a pretty-printed string
              String prettyJson = snapshot.data!.entries
                  .map((e) => '${e.key}: ${e.value}')
                  .join('\n');

              // Display the formatted JSON on the screen
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(prettyJson, style: TextStyle(fontSize: 16)),
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
