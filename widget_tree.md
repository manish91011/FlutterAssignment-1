MaterialApp
└── ChatScreen (Scaffold)
    ├── AppBar
    │   ├── Leading: IconButton (Back)
    │   ├── Title: Row
    │   │   ├── Avatar (buildAvatar)
    │   │   ├── SizedBox
    │   │   └── Expanded
    │   │       └── Column
    │   │           ├── Text (Name)
    │   │           └── Text (Status)
    │   └── Actions
    │       ├── IconButton (Call)
    │       ├── IconButton (Video Call)
    │       └── SizedBox
    ├── Body: Column
    │   ├── Expanded
    │   │   └── ListView.builder
    │   │       ├── First Item: buildDateChip
    │   │       └── Chat Bubbles: buildMsgBubble
    │   │           ├── Row
    │   │           │   ├── Avatar (if isMe = false)
    │   │           │   ├── Flexible (Message Content)
    │   │           │   │   ├── Text (Sender Name)
    │   │           │   │   ├── Container (Message Bubble)
    │   │           │   │   │   ├── Text or buildAudioWidget
    │   │           │   │   └── Padding (Timestamp)
    │   │           │   └── Spacer
    │   └── buildInputSection
    │       ├── Row
    │       │   ├── IconButton (Attachment)
    │       │   ├── Expanded
    │       │   │   └── Container (TextField)
    │       │   ├── IconButton (Gallery)
    │       │   ├── IconButton (Camera)
    │       │   └── IconButton (Mic)
