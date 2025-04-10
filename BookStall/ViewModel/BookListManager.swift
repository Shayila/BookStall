//
//  BookListManager.swift
//  BookStall
//
//  Created by Aiysha on 09/04/25.
//

import Foundation
import Combine

class BookListManager : ObservableObject {
    
    @Published var searchText = ""
    @Published var results : [BookList] = [BookList]()
    
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        $searchText.sink { [weak self] text in
            if let self = self {
                self.fetchBookList()
            }
        }.store(in: &cancellables)
    }
    
    
    func fetchBookList(){
        WebServiceManager.shared.postDataToURL(input: ["" : ""], mode: .FetchBookList) { jsonString in
            
            if jsonString is Data {
                if let decodedResponse = try? JSONDecoder().decode(BookListModel.self, from: jsonString as! Data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    
                }
            }
        }
    }
    
}
