# Teko_Dev-Test

About my application

* Library: 
I using following library in my application
+ Alamofire: To perform networking task to work with API
+ RxAlamofire: Wrapping RxSwift to make working with network requests
+ SwiftyJSON: is JSON parsing library 
+ SVProgressHUD: To show loading indicator
+ RxSwift: In this app, I using for observer requested API
+ AlamofireImage: To show online image
+ FSPagerView: To make page view

*  Screen
- SearchVC : 
I using a Tableview to show all product get from api search
I using textFieldShouldReturn from UITextFieldDelegate to detect when user tap to search button in keyboard to make request api to get data and show result to screen
- DetailVC:
I using "sku" string that is id of selected product to make request to server and get all info of selected product
I divided detail screen to 3 components: 
 + Info Cell: Show slider image and basic info of selected product
 + CategoryCell: Show detail info of selected product with: description, attribution and comparation
 + SameTypeCell: To show the same type of selected product
 
* Usage
- In search screen: Tap to text field in top of screen and type some keyword that you want to search and tap to "search" button in keyboard
     -> App will show all product appropiate with your keyword you typed
- Tap to specific product in list to show detail screen of this product

Thank for review my app!


    

