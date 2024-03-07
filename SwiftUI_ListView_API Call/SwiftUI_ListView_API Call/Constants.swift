
import Foundation
import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}


struct API{
    static let Meal_API = "https://www.themealdb.com/api/json/v1/1/categories.php";
}
