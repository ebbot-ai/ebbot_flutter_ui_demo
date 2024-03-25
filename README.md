# ebbot_flutter_ui_demo

## This is the Ebbot Chatbot Demo page

The purpose of this repository, is to provide examples of how to implement the Ebbot Chatbot into your Flutter application.


## Getting started
Before you can run this project, you need to create a `.env` file in the project root with your bot id:
```
BOT_ID=my-bot-id
```

Then, to run the app, you simply run:
```
flutter run
```
from the command line and follow the instructions.

For more in depth instructions on how to use the `ebbot flutter ui` widgets, consult this repository: https://github.com/ebbot-ai/ebbot_flutter_ui


There are currently two different examples (that you can find in the `lib/examples` folder):
- **Ebbot Demo App with pages**. A stateful app that presents a bottom menu with some pages, where the last page is a stateful representation of the chat. 
- Ebbot Demo App with popup which provides a stateless representation of the chat which opens in full screen and is cleared on dismiss.
  
 To toggle between them, change the `runApp` call in `lib/main.dart`.