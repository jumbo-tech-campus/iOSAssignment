# iProduct

## Description
This project will show a list of products to add in the cart to by in the future.

## Topics
* [Architecture](#architecture)
* [Concepts covered](#concepts_covered)
* [In this version](#in_this_version)
* [Future items](#future_items)
* [Dependencies](#dependencies)
* [Requirements](#requirements)
* [Installation](#installation)

## Architecture
For this application was used **MVVM-C** where C is Coordinator to manage all the presentations for each flow.
Using this pattern also allow us to manage all the business logic inside the ViewModels, given a good point when we're looking at an application with Scalability, Readability and Maintainability.
Following the same concept we created a components that could be used everywhere inside.

## Concepts covered
* SOLID.
* Inheritance.
* Encapsulation.
* Maintainability.
* Scalability.
* Readability.
* Testability.
* Components.

### In this version
* Unit tests.
* Internationalization.
* TODO search: *every build the project will show a warnning on each TODO tag we keeped.*

## Future items
* Add .frameworks: *Create custom frameworks  to allow to grow scalable in a different teams*
* UI tests, tesing screens and the elements in itself.
* Handle erros with a custom alert component.
* Support both Dark and Light mode.
* Add Crashlytics framework to traking all issues.
* Create NO DATA component to improve the user experience.
* Create helper functions to work around constraint avoiding boilerplates.

## Dependencies
* [Cocoapods](https://guides.cocoapods.org/using/getting-started.html) 1.10.2.
* [R.swift](https://github.com/mac-cain13/R.swift) (5.4.0): It makes the code that uses resources:
    * **Fully typed**, less casting and guessing what a method will return.
    * **Compile time checked**, no more incorrect strings that make the app crash at runtime.
    * **Autocompleted**, help us to don't guess that image name again.
* [Alamofire](https://github.com/Alamofire/Alamofire) (5.4.x): *We choose it because a bunch of developers are working around this every day and following that is easiest to find a issue if it's come up. On this library they've frequency of updates, solve bugs very fast. But for sure there's no a silver bullet, if we already have in our compay a network library used for long time it also could be a good choise.*

## Requirements
* iOS 13.0+.
* Xcode 12.x.
* Swift 5.0.

## Installation
* Make sure we've been installed [Cocoapods](https://guides.cocoapods.org/using/getting-started.html) 1.10.2.
* Open the *Terminal*.
* Go to the project's root folder where sould've the **Podfile**.
* Run this command: ```pod install```.


## Screenshots
------------

### iPhone

| Home  | Search |
| ------------- | ------------- |
| ![iPhone1](/screenshots/iphone/img1.png?raw=true) | ![iPhone2](/screenshots/iphone/img2.png?raw=true) |


| Cart  | Video |
| ------------- | ------------- | 
| ![iPhone3](/screenshots/iphone/img3.png?raw=true) | ![iPhone5](/screenshots/iphone/movie.gif?raw=true) |

| Cart landscape |
| ------------- |
| ![iPhone4](/screenshots/iphone/img4.png?raw=true) |

### iPad

| Search | Cart |
| ------------- | ------------- |
| ![iPad1](/screenshots/ipad/img1.png?raw=true) | ![iPad2](/screenshots/ipad/img1.png?raw=true) |
