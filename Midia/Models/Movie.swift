//
//  Movie.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 18/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

struct Movie {
    
    let trackId: String
    let authors: [String]?
    let title: String
    let coverURL: URL?
    let description: String?
    let price: Float?
    let releaseDate: Date?
    let rating: Float?
    let numberOfReviews: Int?
    
    
    init(trackId: String, title: String, authors: [String]? = nil, releaseDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, rating: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.trackId = trackId
        self.title = title
        self.authors = authors
        self.releaseDate = releaseDate
        self.description = description
        self.coverURL = coverURL
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
    
}

extension Movie: MediaItemProvidable {
    var mediaItemId: String {
        return trackId
    }

    var imageURL: URL? {
        return coverURL
    }
}

extension Movie: MediaItemDetailedProvidable {
    var creatorName: String? {
        return authors?.joined(separator: ", ")
    }
    
    var creationDate: Date? {
        return releaseDate
    }
    
    
}

extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case authors = "artistName"
        case title = "trackName"
        case coverURL = "artworkUrl100"
        case description = "longDescription"
        case price = "trackPrice"
        case releaseDate
        case rating
        case numberOfReviews
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let trackIdInt = try container.decode(Int.self, forKey: .trackId)
        trackId = "\(trackIdInt)"
        
        if let authorsList = try container.decodeIfPresent(String.self, forKey: .authors)?.components(separatedBy: ", ") {
            authors = authorsList
        } else {
            authors = nil
        }
        
        title = try container.decode(String.self, forKey: .title)
        coverURL = try container.decodeIfPresent(URL.self, forKey: .coverURL)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        price = try container.decodeIfPresent(Float.self, forKey: .price)
        if let relaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.moviesAPIDateFormatter.date(from: relaseDateString)
        } else {
            releaseDate = nil
        }
        rating = nil
        numberOfReviews = nil
        
        
    }
    
    func encode (to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Int(trackId), forKey: .trackId)
        try container.encodeIfPresent(authors?.joined(separator: ", "), forKey: .authors)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(coverURL, forKey: .coverURL)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(price, forKey: .price)
        if let date = releaseDate {
            try container.encode(DateFormatter.moviesAPIDateFormatter.string(from: date), forKey: .releaseDate)
        }
        try container.encodeIfPresent(rating, forKey: .rating)
        try container.encodeIfPresent(numberOfReviews, forKey: .numberOfReviews)
        
    }
    
}




