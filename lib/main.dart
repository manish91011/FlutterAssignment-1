import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D9D8D)),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController msgController = TextEditingController();
  final ScrollController scrollCtrl = ScrollController();
  
  // Messages matching the screenshot
  List<ChatMessage> msgs = [
    ChatMessage(text: "Hello! Jhon abraham", isMe: true, timestamp: "09:25 AM"),
    ChatMessage(text: "Hello! Nirajit How are you?", isMe: false, timestamp: "09:25 AM"),
    ChatMessage(text: "You did your job well!", isMe: true, timestamp: "09:26 AM"),
    ChatMessage(text: "Have a great working week!!", isMe: false, timestamp: "09:26 AM"),
    ChatMessage(text: "Hope you like it", isMe: false, timestamp: "09:26 AM"),
    ChatMessage(text: "", isMe: true, timestamp: "09:26 AM", isAudio: true, audioDuration: "00:16"),
  ];

  Widget buildAvatar({required double size, required double fontSize}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/avatar.jpg',
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Fallback to gradient avatar if image fails to load
            return Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1D9D8D), Color(0xFF2DB5A5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'JA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollCtrl,
              padding: const EdgeInsets.all(16),
              itemCount: msgs.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return buildDateChip();
                }
                return buildMsgBubble(msgs[index - 1]);
              },
            ),
          ),
          buildInputSection(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      title: Row(
        children: [
          // User avatar with actual image
          buildAvatar(size: 45, fontSize: 18),
          const SizedBox(width: 12),
          // User info
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Jhon Abraham',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Active now',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_outlined, color: Colors.black, size: 24),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Call feature coming soon!')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.videocam_outlined, color: Colors.black, size: 26),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Video call feature coming soon!')),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget buildDateChip() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 24),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Today',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMsgBubble(ChatMessage msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isMe) ...[
            // Avatar for incoming messages
            Container(
              margin: const EdgeInsets.only(right: 8, top: 4),
              child: buildAvatar(size: 35, fontSize: 14),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jhon Abraham',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      msg.text,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      msg.timestamp,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ] else ...[
            const Spacer(),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1D9D8D),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      ),
                    ),
                    child: msg.isAudio ? buildAudioWidget(msg) : Text(
                      msg.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      msg.timestamp,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildAudioWidget(ChatMessage msg) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              debugPrint('Play audio: ${msg.audioDuration}');
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Color(0xFF1D9D8D),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 25; i++)
                      Container(
                        width: 2,
                        height: i < 8 ? 8.0 : (i < 15 ? 12.0 : 6.0),
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  msg.audioDuration,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            offset: const Offset(0, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.grey, size: 24),
              onPressed: () => _showAttachmentOptions(),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: msgController,
                  decoration: const InputDecoration(
                    hintText: 'Write your message',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  style: const TextStyle(fontSize: 15),
                  maxLines: null,
                  onSubmitted: (text) {
                    if (text.trim().isNotEmpty) {
                      _sendMessage(text);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              icon: const Icon(Icons.photo_camera_outlined, color: Colors.grey, size: 24),
              onPressed: () => _pickImage(),
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 24),
              onPressed: () => _openCamera(),
            ),
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.grey, size: 24),
              onPressed: () => _recordAudio(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for input actions
  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    setState(() {
      msgs.add(
        ChatMessage(text: text, isMe: true, timestamp: _getCurrentTime()),
      );
    });
    msgController.clear();
    
    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollCtrl.hasClients) {
        scrollCtrl.animateTo(
          scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: Icon(Icons.photo), title: Text('Photo')),
            ListTile(leading: Icon(Icons.video_file), title: Text('Video')),
            ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text('Document'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker not implemented yet')),
    );
  }

  void _openCamera() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Camera not implemented yet')),
    );
  }

  void _recordAudio() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Audio recording not implemented yet')),
    );
  }

  @override
  void dispose() {
    msgController.dispose();
    scrollCtrl.dispose();
    super.dispose();
  }
}

// Message model - keeping it simple
class ChatMessage {
  final String text;
  final bool isMe;
  final String timestamp;
  final bool isAudio;
  final String audioDuration;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.isAudio = false,
    this.audioDuration = '',
  });
}