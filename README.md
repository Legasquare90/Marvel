# Marvel

This project contains the development of an app to list the Marvel universe characters. When the user open the app, this loads the characters, and then, the user can search some of them to see the full details of it accord to the [public Marvel API](http://developer.marvel.com/).

## Features

* All project is coded with **Swift 5**
* UI is built using only **Autolayout**. SwiftUI is not used in the project.
* The app can be used both **iPhone and iPad**, with at least iOS 13.0, and both **portrait and landscape orientations**.
* Available in **Dark Mode**.
* API requests include a **retry policy** to avoid errors and improve user experience. Also, all requests include **pagination**.
* App include a **logger** to print (only in debug level) the API requests. 
* The opening of the app includes **animations** to improve user experience while is loading the data of the first API request.
* App includes several **tests**, with unit tests and UI tests, among others.
* App is **localized** and it's available both English and Spanish.
* Third party libraries **acknowledgements** can be seen in iOS settings.

***

### Architecture

The code is mainly structured in two sections: *Core*, where network layer and application model are located, and *Modules*, where all the code necessary to create the views and handle their corresponding actions.

#### *Core*

The network layer has two base classes: *APIManager*, which is responsible for encapsulating the network library, as well as the retry policy and the logger, and *BaseRouter*, which sets the variables necessary to create the request. From there, different modules can be created according to the requests they make. Each module has a service manager, inheritor of the *APIManager*, that will apply for the creation of the request to its corresponding router, and that will finally return the response received to the view module that called it.

On the other hand, there is the application model, based on the documentation of the Marvel API, structured in different objects according to its characteristics. To create this model, Swift's ***Codable*** protocol is used.

#### *Modules*

Each module is divided into three parts: *View*, *Presenter* and *Interactor*, and each of them is linked to the next with an input and output delegate. *View* is responsible for relating to the storyboard and managing all its elements to display the data correctly. *Presenter* is responsible for transforming the data received by the interactor to facilitate the work of the view when it comes to displaying it. *Interactor* is in charge of relating to the core and obtaining the necessary data from any site.

Also, each module has a class *Navigator* that allows the navigation management of the module to any other controller.

***

### Third party libraries

The external libraries are included in this project using CocoaPods. In the next list, explain the pods integrated in the development:

* [**Alamofire**](https://github.com/Alamofire/Alamofire). Networking library used to make requests to Marvel API.
* [**DZNEmptyDataSet**](https://github.com/dzenbot/DZNEmptyDataSet). Library used to avoid empty screens in content lists.
* [**iOSSnapshotTestCase**](https://github.com/uber/ios-snapshot-test-case). Library used to do snapshot testing.
* [**Kingfisher**](https://github.com/onevcat/Kingfisher). Library used to download images.
* [**Nimble**](https://github.com/Quick/Nimble). Library used in testing to ease the expressions used in tests.
* [**SwiftMessageBar**](https://github.com/JanGorman/SwiftMessageBar). Library used to show message bar.

***

### Demo

If you can't/don't want to run the code, can test the app in [Appetize](https://appetize.io/app/9k5mka22tp06qv1nj99haf1tac)
