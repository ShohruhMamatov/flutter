import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Task 1: Initialize Firebase
  await Firebase.initializeApp();
  
  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Advanced App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FirebaseHomePage(),
    );
  }
}

class FirebaseHomePage extends StatefulWidget {
  const FirebaseHomePage({super.key});

  @override
  State<FirebaseHomePage> createState() => _FirebaseHomePageState();
}

class _FirebaseHomePageState extends State<FirebaseHomePage> {
  // Task 2: Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  
  // Task 9: Firebase Messaging
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  // Task 10: Local notifications
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  
  String _fcmToken = 'Loading...';

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _getFCMToken();
    _setupForegroundNotifications();
  }

  // Task 9: Get FCM Token
  Future<void> _getFCMToken() async {
    try {
      // Request permission
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
        
        // Get token
        String? token = await _messaging.getToken();
        if (token != null) {
          setState(() {
            _fcmToken = token;
          });
          print('FCM Token: $token');
          print('========================================');
          print('COPY THIS TOKEN FOR TESTING:');
          print(token);
          print('========================================');
        }
      } else {
        print('User declined or has not accepted permission');
      }
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }

  // Task 10: Initialize local notifications
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings = 
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notification clicked: ${response.payload}');
      },
    );

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Task 10: Setup foreground notification listener
  void _setupForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        
        // Show local notification
        _showLocalNotification(
          message.notification!.title ?? 'New Message',
          message.notification!.body ?? 'You have a new message',
        );
      }
    });
  }

  // Task 10: Show local notification
  Future<void> _showLocalNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = 
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      notificationDetails,
    );
  }

  // Task 3: Add message to Firestore
  Future<void> _addMessage() async {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a message')),
      );
      return;
    }

    try {
      await _firestore.collection('messages').add({
        'text': _messageController.text.trim(),
        'createdAt': Timestamp.now(),
      });
      
      _messageController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Task 5: Update message
  Future<void> _updateMessage(String docId, String currentText) async {
    TextEditingController editController = 
        TextEditingController(text: currentText);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Message'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            labelText: 'Message',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (editController.text.trim().isNotEmpty) {
                try {
                  await _firestore.collection('messages').doc(docId).update({
                    'text': editController.text.trim(),
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message updated!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // Task 6: Delete message
  Future<void> _deleteMessage(String docId) async {
    try {
      await _firestore.collection('messages').doc(docId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message deleted!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Advanced Integration'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // FCM Token Display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FCM Token (Task 9):',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  _fcmToken,
                  style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                const Text(
                  '📱 Check console for full token to test push notifications!',
                  style: TextStyle(fontSize: 11, color: Colors.green),
                ),
              ],
            ),
          ),
          
          // Task 3: Add message form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Enter message',
                      border: OutlineInputBorder(),
                      hintText: 'Type your message here...',
                    ),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addMessage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Task 4: Real-time message list using StreamBuilder
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No messages yet.\nAdd your first message above!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    Map<String, dynamic> data = 
                        doc.data() as Map<String, dynamic>;
                    
                    String text = data['text'] ?? '';
                    Timestamp? timestamp = data['createdAt'];
                    DateTime? dateTime = timestamp?.toDate();
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(text),
                        subtitle: Text(
                          dateTime != null
                              ? '${dateTime.day}/${dateTime.month}/${dateTime.year} '
                                '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}'
                              : 'No date',
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Task 5: Edit button
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _updateMessage(doc.id, text),
                            ),
                            // Task 6: Delete button
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteMessage(doc.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}