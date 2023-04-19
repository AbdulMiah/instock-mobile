# InStock Mobile Application

Welcome to the repository for the InStock Flutter application! This powerful app is designed to help users keep track of their inventory by providing a simple and intuitive interface that enables users to effortlessly manage inventory and track sales while on the go.

In this repository, you'll find the codebase for the InStock mobile application, which uses several third-party Flutter packages for key functionalities such as http, image_picker, flutter_secure_storage, and firebase_messaging for notifications.

Please note that this version of the app relies on the backend, and if you plan to use it with your own hosted version of the backend, you'll need to update the code to change the config URL to point to your domain.

## Getting Started
If you haven't already, ensure that you have the latest version of Flutter installed. Please navigate to our [Flutter Set Up](https://git.cardiff.ac.uk/groups/cm6331-2022-23-1/-/wikis/Flutter%20Set-Up) guide to set up Flutter on your system.

To get started with the InStock mobile app, please clone this repository:
```
https://git.cardiff.ac.uk/cm6331-2022-23-1/instock-mobile-application.git
```

Then, navigate to the root directory of the project and run the following command in your terminal to install the required dependencies:
```
flutter pub get
```

## Running the App
To run the app on your device or emulator, run the following command:
```
flutter run
```

## Project Structure
The project has been organised into different directories for better management of the codebase. The `lib` directory contains the main codebase of the app, which has been divided into different subdirectories based on their functionalities. We adopted the `Feature First` approach for our project structure. The `assets` directory contains the images, animations, and other assets used in the app. To learn more about the architectural decisions we made for the project, please click [here](https://git.cardiff.ac.uk/groups/cm6331-2022-23-1/-/wikis/Architecture-Decisions).

## Dependencies
The project uses several third-party packages to provide functionalities such as HTTP requests, image picking and cropping, notifications, and more. The list of dependencies can be found in the `pubspec.yaml` file.

## App Deployment
We have a GitLab Runner set up that builds, tests, and deploys the app to the Google Playstore. To deploy the app successfully, please increment the version number in the `pubspec.yaml` file before pushing to the repository. Please feel free to contact any of the contributers, for access to our internal testing release of the app on the playstore (which we hope to make publiclly available soon).

## Disclaimer
The development of this app was done on an Android device, so there may be some compatibility issues if you try to migrate it to iOS devices, even though the code will compile to iOS (we didn't have access to a MacBook required for Apple development).

