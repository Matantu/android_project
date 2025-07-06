import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/age_selector_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ooflivuzekvgzznqaotu.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vZmxpdnV6ZWt2Z3p6bnFhb3R1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkzODk1NzksImV4cCI6MjA2NDk2NTU3OX0.fFD-Z_TtbPMez7pB7rUYgzv0Mgck-H0SIkkWMYLrr5M',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Child Files',
      home: AgeSelectorScreen(),
    );
  }
}
