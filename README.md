# assessment

Task Managment Application

## Overview
The App is a Task Management Application which allows user to 
 - Add new tasks
 - Edit existing tasks
 - Delete existing tasks
 - Mark tasks as complete or incomplete.

The Structure of the app is ass follows:

Assessment
    - ...
    - lib
        - bloc  
        - data
        - repository
        - resources
        - routes
        - ui
        main.dart
    - test

## State Management
Bloc is used for the app's state management. 
This allows to separate the business logic of the application from the UI.

## How To Run The App
To run the app:
- Run the following to download all necessary depencies.
```sh
    flutter pub get
```
- Run the following to run the app on your emulator or a physical device connected to the system.
```sh
    flutter run lib/main.dart
```

## How To Run Test
- To run the unit test, run the following command:
```sh
    flutter test test/task_test.dart
```

- To run the widget test, run the following command:
```sh
    flutter test test/widget_test.dart
```



