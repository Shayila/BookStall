//
//  BookDetailScreen.swift
//  BookStall
//
//  Created by Aiysha on 09/04/25.
//
//Detail screen - Contains Images, Title, Author, Description, publishing year and download count

import SwiftUI

struct BookDetailScreen: View {
    var bookDetail : BookList
    
    @Environment (\.openURL) var openURL
    
    var body: some View {
        
        List {
        VStack(alignment: .center) {
            
            
                Text(bookDetail.title)
                    .font(.title)
                    .bold()
                    .frame(alignment: .center)
                    .padding()
                
               
            ImageLoader(imgName: "\(bookDetail.id)")
                
                
                HStack{
                    Text("By:")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .italic()
                        .foregroundStyle(Color.black)
                    
                    Text(bookDetail.authors.reduce(""){ partial, res in
                        
                        "\(partial) \(res.name)"
                        
                    }).font(.subheadline)
                        .fontWeight(.semibold)
                        .italic()
                        .foregroundStyle(Color.gray)
                    
                }
                
            Text("Downloads: \(bookDetail.downloadCount)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
                
                Text(bookDetail.summaries[0]).font(.body).padding(2).frame(alignment: .leading)
                
                bottomView()
            
            
            
                
                
            }
            
        .lineSpacing(0)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        }
        
        .navigationTitle("Detail Screen").navigationBarTitleDisplayMode(.inline)
        
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: /*@START_MENU_TOKEN@*/{
                    
                    Task {
                        await FileDownloadManager.downloadFile(bookID: "\(bookDetail.id)")
                    }
                    
                }/*@END_MENU_TOKEN@*/){
                    Label("", systemImage: "square.and.arrow.down.fill")
                }
            }
        }
    }
    
    @ViewBuilder
    func bottomView() -> some View{
        HStack {
            
            
            Button(action: /*@START_MENU_TOKEN@*/{
                if let url = URL(string: bookDetail.formats.openPage) {
                    openURL(url)
                }
            }/*@END_MENU_TOKEN@*/){
                HStack {
                    /*@START_MENU_TOKEN@*/Image(systemName: "book.fill")/*@END_MENU_TOKEN@*/
                    /*@START_MENU_TOKEN@*/Text("Open Book").padding(4)/*@END_MENU_TOKEN@*/
                }
                .background(.blue.opacity(0.7)).foregroundColor(.white)
                
            }.cornerRadius(4)
            
            
        }
        .padding(2)
    }
    
}


struct ImageLoader : View {
    
    let imgName : String
    var body: some View {
        // //https://www.gutenberg.org/cache/epub/75827/pg75827.cover.medium.jpg
        if let url = URL(string: "https://www.gutenberg.org/cache/epub/\(imgName)/pg\(imgName).cover.medium.jpg") {
            AsyncImage(url: url) {
                image in
                
                image
                    .resizable()
                
            } placeholder: {
                Image("bookCover").resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 80,height: 120)
            .cornerRadius(5)
            
        }
    }
}

struct libraryContent : LibraryContentProvider {
    
    @LibraryContentBuilder
    var views: [LibraryItem]{
        LibraryItem(
            Button(action: {
            }){
                HStack {
                    Image(systemName: "book.fill")
                    Text("Open Book").padding(4)
                }
                .background(.blue.opacity(0.7)).foregroundColor(.white)
            }.cornerRadius(4)
        )
        
    }
    
}



#Preview {
    BookDetailScreen(bookDetail: BookList(id: 0, title: "abc", authors: [Author(name: "", birthYear: 0, deathYear: 0)], translators: [Author(name: "", birthYear: 0, deathYear: 0)], subjects: [""], bookshelves: [""], languages: [""], summaries: [""], copyright: true, mediaType: "", downloadCount: 0, formats: Formats(imageJPEG: "", downloadPDF: "", openPage: "")))
}
