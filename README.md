
# Weather App

This the Flutter implementation of a demo app using the Weather API.
It uses the Bloc lib for state management and dependency injection.

Try it -> https://weather-app-antoci.web.app

## Getting Started

Clone the repo locally and run:

```
flutter pub get
```
Then navigate to 'packages/data_repository' and run:
```
flutter pub get
```
And finally:
```
flutter run -d chrome
```
That's it!

### Folder Structure
Here is an overview of the folder structure of the project
**The main app**
```
lib/
|- screens     -> all app screens
|- shared      -> shared widgets and constants
|- style       -> app styles 
|- app.dart    -> main app styling and main widget
|- main.dart   -> the entry point, injection of dependencies
```

**The data_repo**
```
src/
|- api                   -> the API implementation code
|- business              -> the business logic
|- models                -> the business models
|- data_repository.dart  -> the ONLY interface to be imported by the app
```

**The Unit Tests**
```
test/
|- home_page.dart        -> the home page bloc unit tests
```

Run the tests
```
flutter test
```

## For questions please message Adrian A.
adrian@atomsoftworks.com

### Future work
- Allow the user to select a city
- Implement Data Repo API calls caching for (e.g) offline support
- Implement more unit tests and functional tests 
- Implement lazy loading of results 
- Implement a tablet UX
- Improve the UI based on a UX design (exact values from a Figma/Invision/Zeplin design)
- Use use translation strings
- Check all the //TODO in the code