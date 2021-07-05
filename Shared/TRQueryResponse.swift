//
//  TRQueryResponse.swift
//  TRTakeHome
//
//  Created by אהרן שלמה אדלמן on 05/07/2021.
//

import Foundation

// MARK: - TRQueryResponse
struct TRQueryResponse: Codable {
    var data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    var id: Int
    var title, slug, date, datumDescription: String
    var seo: SEO
    var image: Image
    var thumbnail: Thumbnail
    var link: String
    var author: Author
    var sticky: Bool
    var category: Category
    var topics: [Category]
    var stocks: [Stock]

    enum CodingKeys: String, CodingKey {
        case id, title, slug, date
        case datumDescription = "description"
        case seo, image, thumbnail, link, author, sticky, category, topics, stocks
    }
}

// MARK: - Author
struct Author: Codable {
    var name: String
    var slug: String
    var type: String
    var bio: String
    var image: Image
    var created: JSONNull?
}

// MARK: - Image
struct Image: Codable {
    var src: String?
    var width, height: Int
}

// MARK: - Category
struct Category: Codable {
    var id: Int
    var slug, title: String
}

// MARK: - SEO
struct SEO: Codable {
    var title, seoDescription: JSONNull?

    enum CodingKeys: String, CodingKey {
        case title
        case seoDescription = "description"
    }
}

// MARK: - Stock
struct Stock: Codable {
    var ticker: String
    var market: JSONNull?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var src: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
