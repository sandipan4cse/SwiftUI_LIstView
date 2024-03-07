
import Foundation
import SwiftUI

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class Connection {
    @Published var image: UIImage = UIImage()
    
    func loadData(urlValue:String,completionHandler:@escaping(meal?)->Void) {
        guard let url = URL(string: urlValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    //Parse JSON
                    let decodedData = try JSONDecoder().decode(meal.self, from: data)
                    completionHandler(decodedData)
                } catch {
                    //Print JSON decoding error
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            } else if let error = error {
                //Print API call error
                print("Error fetching data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getData<DataKind:Codable>(_ url: String,_ dataKind: DataKind.Type, _ completion: @escaping (_ data:DataKind)->Void) {
        print(url)
        let url = URL(string: url)
        if let tempURL = url{
            URLSession.shared.dataTask(with: tempURL) { data, response, error in
                if let data = data {
                    do {
                        //Parse JSON
                        let convertedData = try JSONDecoder().decode(dataKind, from: data)
//                        print(convertedData)
                        completion(convertedData)
                    } catch {
                        //Print JSON decoding error
                        print("Error decoding JSON: \(error.localizedDescription)")
                    }
                } else if let error = error {
                    //Print API call error
                    print("Error fetching data: \(error.localizedDescription)")
                }
            }.resume()
        }
        }
    
}

class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()
    }
}


