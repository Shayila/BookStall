//
//  ContentView.swift
//  BookStall
//
//  Created by Aiysha on 09/04/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var bookList = BookListManager()
    
    var body: some View {
        
        NavigationStack() {
        
            VStack {
                List(bookList.results) {book in
                    
                    HStack (spacing: 10) {
                        
                        ImageLoader(imgName: "\(book.id)")

                        VStack(alignment: .leading,spacing: 3) {
                            Text(book.title).font(.title3).fontWeight(.heavy)
                            Text(book.authors.reduce(""){ partial, res in
                                
                                "\(partial) \(res.name)"
                                
                            })
                            
                            NavigationLink("", value: book.id)
                            
                        }
                    }
                    
                }
                
            }
            
            .navigationTitle("Book List")
            .navigationDestination(for: Int.self) { itemID in
                
                if let bookD = bookList.results.first(where: {$0.id == itemID}) {
                    BookDetailScreen(bookDetail: bookD)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
