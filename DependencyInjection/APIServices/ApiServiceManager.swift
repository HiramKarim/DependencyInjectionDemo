//
//  ApiServiceManager.swift
//  APIServices
//
//  Created by Hiram Castro on 23/01/22.
//

import Foundation


struct Receipt:Decodable {
    let offset:Int
    let number:Int
    let results:[Results]
}

struct Results:Decodable {
    let id:Int
    let title:String
    let calories:Int
    let carbs:String
    let fat:String
    let image:String
    let imageType:String
    let protein:String
}

public class ApiServiceManager {
    
    public static let shared = ApiServiceManager()
    
    private init() {}
    
    public func fetchCourseNames(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&maxFat=25&number=2")
        else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            // Decode
            
            print(data)
            
            do {
                let result = try JSONDecoder().decode(Receipt.self, from: data)
                completion([])
            } catch {
                completion([
                    "1", "2", "3", "4", "5"
                ])
            }
        }
        task.resume()
    }
    
}
