//
//  FileDownloadManager.swift
//  BookStall
//
//  Created by Aiysha on 10/04/25.
//

import Foundation
import Combine
import SwiftUI



class FileDownloadManager {
    
    
    
    static func downloadFile(bookID : String) async  {
        
        if let url = URL(string: "https://www.gutenberg.org/cache/epub/\(bookID)/pg\(bookID)-images.epub") {
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                
                if let reponse = response as? HTTPURLResponse {
                    
                    if reponse.statusCode == 200 {
                        
                        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        let destinationURL = documentURL.appending(path: url.lastPathComponent)
                        print(destinationURL)
                        if !FileManager().fileExists(atPath: destinationURL.path) {
                            try! data.write(to: destinationURL)
                            print("Successfully saved!!!!")
                        }else{
                            print("Already Exist!!!!!")
                        }
                        
                        
                    }
                    
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
    
}
