//
//  Constants.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 04/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

let API_KEY = valueForAPIKey(named: "API_KEY_GOOGLE")

struct GoogleBooksAPIConstants {


    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: API_KEY)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))

        return components.url!
    }

    static func urlForBook(withId bookId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes/\(bookId)"
        components.queryItems = [URLQueryItem(name: "key", value: API_KEY)]

        return components.url!
    }

}

struct ItunesMoviesAPIConstants {
    
    private static let media = "movie"
    private static let attribute = "movieTerm"
    private static let country = "es"
 
    static func getAbsoluteURL(withParams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [URLQueryItem(name: "media", value: media)]
        components.queryItems?.append(URLQueryItem(name: "attribute", value: attribute))
        components.queryItems?.append(URLQueryItem(name: "country", value: country))
        components.queryItems?.append(URLQueryItem(name: "term", value: queryParams.joined(separator: " ")))
        
        return components.url!
    }
    
    static func urlForMovie(withId movieId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        components.queryItems = [URLQueryItem(name: "id", value: movieId)]
        components.queryItems?.append(URLQueryItem(name: "country", value: country))
        
        
        return components.url!
    }
}


