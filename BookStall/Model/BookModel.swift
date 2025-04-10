//
//  BookModel.swift
//  BookStall
//
//  Created by Aiysha on 09/04/25.
//

import Foundation

// MARK: - BookListModel
struct BookListModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [BookList]
}

// MARK: - Result
struct BookList: Codable, Identifiable {
    let id: Int
    let title: String
    let authors,translators: [Author]
    let subjects, bookshelves, languages,summaries: [String]
    let copyright: Bool
    let mediaType: String
    let downloadCount: Int
    let formats: Formats

    enum CodingKeys: String, CodingKey {
        case id, title, authors, summaries, translators, subjects, bookshelves, languages, copyright
        case mediaType = "media_type"
        case downloadCount = "download_count"
        case formats
    }
}

// MARK: - Author
struct Author: Codable {
    let name: String
    let birthYear, deathYear: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}



// MARK: - Formats
struct Formats: Codable {
    let imageJPEG: String
    let downloadPDF : String
    let openPage : String


    enum CodingKeys: String, CodingKey {
        case imageJPEG = "image/jpeg"
        case downloadPDF = "application/epub+zip"
        case openPage = "text/html"
    }
}
