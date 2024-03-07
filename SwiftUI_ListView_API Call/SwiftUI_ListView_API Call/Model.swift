
import Foundation
import SwiftUI


struct meal: Codable, Hashable{
    var categories: [categories]
}

struct categories: Codable, Hashable,Identifiable{
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
    let id = UUID()
}
