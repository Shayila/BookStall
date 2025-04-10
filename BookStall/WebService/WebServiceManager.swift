//
//  WebServiceManager.swift
//  BookStall
//
//  Created by Aiysha on 09/04/25.
//

import Foundation

enum WebRequestMode : Int {
    
    case FetchBookList
    case SearchBookForID
}

class WebServiceManager : NSObject {
    
    static let shared : WebServiceManager = {WebServiceManager()}()
    
    
    func postDataToURL(input : [String : String], mode : WebRequestMode, completionHandler: @escaping(_ jsonString : Any) -> Void) {
        
        var endpoint: String = ""
        
        switch mode {
            
        case .FetchBookList:
            endpoint = "https://gutendex.com/books/"
            break
        default:
            break
            
        }
        
        
        let url = URL(string: endpoint)!
        let session = URLSession.shared
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = "GET"
        
        
        session.dataTask(with: httpRequest) { data, response, error in
            
            if error != nil {
                completionHandler("Error")
                return
            }
            
            
            if let _ = try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])
            {
                completionHandler(data!)
                return
            }
            
        }.resume()
        
    }
}
