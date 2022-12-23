# Technical Assignment

## Description   

The test project will be a native iOS application that should be created as an Xcode project (version 12.3 or higher) and should also support both landscape and portrait device  orientations. The result of your work should be a buildable application able to run on an iOS  device (iPad or iPhone) with iOS 13.0 or higher.  

Create an iOS application for browsing the Jumbo list of available products. To achieve this you are going to use a provided local JSON list with 10 products.


### Usage example
`ProductsRepository().fetchRawProducts()`

## Requirements

- The first screen of your application should display a start button that should navigate to list of products

- The Products List screen should contain a table view displaying the following fields for each product
  - Image
  - Name
  - Price
  - Quantity added to Cart
  - Add to Cart button

- When Add to Cart button is tapped, the product should be added to a local list of products with quantities (Cart).

- _OPTIONAL_: Save Cart locally on the device
- _OPTIONAL_: Load Cart back from the device when entering the product list screen
- _OPTIONAL_: Cart list accessible on the application level

## Hints 

- Attached designs could be a style guide, feel free to innovate. 
- Write your code in production quality, in a reusable way

![Simulator Screen Shot - iPhone 8 - 2021-09-28 at 16 19 08](https://user-images.githubusercontent.com/55485534/135105894-52b5d465-eec1-4a40-80ee-8f63eed45915.png)


# Technical Implementation 

<h2>Software requirement and Dependency</h2>

<ul>
  <li>Xcode 14.2 </li>
  <li>iOS Deployment target 13 </li>
   <li>Cocoapods </li>
</ul>

  Table of Contents
=================

<!--ts-->
   * [App Feature Overview](#app-feature-overview)
      * [Landing page](#landing-page)
      * [Store list](#store-list)
      * [Cart list](#cart-list)
   * [App Architecture](#app-architecture)
      * [UI Layer](#ui-layer)
      * [Networking Layer](#networking-layer)
      * [Storage Layer](#storage-layer)
      * [Business Logic Layer](#business-logic-layer)
      * [Domain models](#domain-models)
   * [Dependencies](#dependencies)
   * [Tests](#tests)
 

<!--te-->


App Feature Overview
============
Here are 5 features you'll love to see:
<ul>
 <li>Landing page to navigate to store list </li>
 <li>List store items in the TableView</li>
 <li>List selected products in the cart list </li>
 <li>Badge count is updated on every new product added to cart </li>
 <li>Functionality to add and remove items from the cart</li>
</ul>

Landing page
============
Click on the Start Shopping button below to bring up the product listing page, and click Add button to add the item to cart.

[<img src="https://user-images.githubusercontent.com/9070304/209376317-a396da29-af53-40f2-8f37-507fee65a459.png" width="200"/>](image.png)

Store list
============
You will see a page that displays a list of store items in a visually appealing and organized way, making it easy for your users to search and browse. Click on "Add" button and it will be successfully added to cart. You can increase / decrease the number of items added to the cart. Clicking on "Cart" icon will navigate you to "My Cart" page.

[<img src="https://user-images.githubusercontent.com/9070304/209376517-b553ac19-843c-4ea7-b677-cb42858944e1.png" width="200"/>](image.png)

Cart list
============
You will see all the product items added to the cart listed here.

[<img src="https://user-images.githubusercontent.com/9070304/209376668-9ef397c2-230c-4d90-9498-6f75035d901b.png" width="200"/>](image.png)


App Architecture
============
My primary architectural approach for this assignment is MVVM (Model-View-ViewMode); I chose this technique to keep things simple. We can use a fully fledged architectural such as VIPER for complex applications.

UI Layer
============
The UI layer is made up of all of the view controllers, their UI elements, their hierarchy, and all of the auxiliary objects linked to the UI, which can include base classes, extensions, and other things.

![UI Layer](https://user-images.githubusercontent.com/9070304/209379608-db2ee79f-ce24-457d-acb2-93f40302ddd7.png)

Networking Layer
============
Networking/Service layer consists of all the objects that do external communication in app. You have an HTTP client and service objects that inject the client to communicate with the backend API. Services also compose new request objects (create HTTP headers and params, sign and encrypt them, and so on), receive JSON/XML responses, and parse and map them to domain model objects. I'm currently using the mock data from the repository in this application

![Screenshot 2022-12-23 at 5 45 48 PM](https://user-images.githubusercontent.com/9070304/209377333-3bf485cb-3ae2-4b47-9ae3-6e945c82abd1.png)


Storage Layer
============
Storage layer consists of all the objects responsible for storing data. Typically, this layer would contain Core Data/Realm/SQL/File Manager/UserDefaults/etc. and wrappers around them. In our scenario, however, we use File Manager to preserve the cart locally on the device and make the cart list accessible at the application level.

![Screenshot 2022-12-23 at 5 19 55 PM](https://user-images.githubusercontent.com/9070304/209377359-e40b7204-6139-4d44-9b6f-3a8c75ac3e25.png)

Business Logic Layer
============
All of the items that make the app valuable to the user are found in the business logic layer. These are ViewModels in the app that use objects from the other three layers to perform useful tasks for the user, such as displaying data, adding items to the cart, showing the item count, and so on. Because it orchestrates objects from other levels and establishes what makes the app functional, this layer is the most significant portion of the programme. Every other layer is really a technical detail that can be replaced.

![Screenshot 2022-12-23 at 5 17 32 PM](https://user-images.githubusercontent.com/9070304/209377404-eb8c0b02-a2db-4f19-affb-91091db09a10.png)


Domain models
============
**ProductRaw** represents a single product that appears in product lists. It contains information such as the product name, image URL, product price/unit pricing, and so on.

**CartDetails** represents an individual item in the cart which has reference to the product and number of quantities.

Dependencies
============
App dependencies required by an application's business logic layer include:

![Untitled design-3](https://user-images.githubusercontent.com/9070304/209377549-8a942d59-82f8-4352-9f62-9caad8862c03.png)

Tests
============
The Model-View-View-Model design pattern greatly simplifies testing of business logic. Unit testing is currently only implemented for the key business logics.

| Unit test class               | Code coverage |
|-------------------------------|---------------|
| ProductsListTableViewModel    | 99.2%         |
| ProductTableViewCellViewModel | 63.7%         |
| ProductsListVCViewModel       | 76%           |
| ProductsListVCViewModel       | 76%           |
| DiskCacheCartManager          | 93.3%         |
| CartManager                   | 100%          |





# Technical Assignment

## Description   

The test project will be a native iOS application that should be created as an Xcode project (version 12.3 or higher) and should also support both landscape and portrait device  orientations. The result of your work should be a buildable application able to run on an iOS  device (iPad or iPhone) with iOS 13.0 or higher.  

Create an iOS application for browsing the Jumbo list of available products. To achieve this you are going to use a provided local JSON list with 10 products.


### Usage example
`ProductsRepository().fetchRawProducts()`

## Requirements

- The first screen of your application should display a start button that should navigate to list of products

- The Products List screen should contain a table view displaying the following fields for each product
  - Image
  - Name
  - Price
  - Quantity added to Cart
  - Add to Cart button

- When Add to Cart button is tapped, the product should be added to a local list of products with quantities (Cart).

- _OPTIONAL_: Save Cart locally on the device
- _OPTIONAL_: Load Cart back from the device when entering the product list screen
- _OPTIONAL_: Cart list accessible on the application level

## Hints 

- Attached designs could be a style guide, feel free to innovate. 
- Write your code in production quality, in a reusable way




