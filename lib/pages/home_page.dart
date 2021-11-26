import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final client = SupabaseClient('https://aegmcvrcadywcpgbpznv.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoic2VydmljZV9yb2xlIiwiaWF0IjoxNjM3ODkyMzA0LCJleHAiOjE5NTM0NjgzMDR9.xMfpxTP7aIvArKlBe4zwTXra3KWDUqR4RA6JxBKVayM');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) =>
                    Center(child: Text(snapshot.data![i]['name'])),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        addData();
      }),
    );
  }

  addData() async {
    final response = await client.from('countries').insert(
      {'name': 'zian', 'country_id': 434},
    ).execute();

    return response.data;
  }

  Future<List<dynamic>> getData() async {
    final response = await client.from('countries').select().execute();

    return response.data;
  }
}
