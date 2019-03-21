//
//  MovieTest.swift
//  MidiaTests
//
//  Created by Jose Francisco Fornieles on 18/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import XCTest

@testable import Midia

class MovieTest: XCTestCase {

    var movie: Movie!
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
      let coverURL = URL(string: "http://books.google.com/books/content?id=qUW5js7ZD7UC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api")
    
    override func setUp() {
        super.setUp()
        movie = Movie(trackId: "12345", title: "title", authors: ["authors"], releaseDate: Date(timeIntervalSinceNow: 13213), description: "description", coverURL: coverURL, price: 5.5)
    }

    override func tearDown() {
        
    }
    
    func testMovieExistence() {
        
        
        XCTAssertNotNil(movie)
        
        XCTAssertNotNil(movie.trackId)
        
    }
    
    func testDecodeMovie() {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "movie-search-response", ofType: "json") else {
            XCTFail()
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let movieCollection = try decoder.decode(MovieCollection.self, from: data)
            XCTAssertNotNil(movieCollection)
            let movie = movieCollection.results?.first!
            XCTAssertNotNil(movie?.trackId)
            XCTAssertNotNil(movie?.title)
        } catch {
            XCTFail()
        }
        
        
    }
    
    func testEncondeMovie() {

        do {
            let myMovie = try encoder.encode(movie)
            XCTAssertNotNil(myMovie)
        } catch {
            XCTFail()
        }

    }
    
    func testEncodeDecodeMovie() {
        
        do {
            // encoder.outputFormatting = .prettyPrinted
            let myMovie = try encoder.encode(movie)
            XCTAssertNotNil(myMovie)
            
            // print(String(data: myMovie, encoding: .utf8)!)
            
            let myMovieDecode = try decoder.decode(Movie.self, from: myMovie)
            XCTAssertNotNil(myMovieDecode)
            XCTAssertNotNil(myMovieDecode.trackId)
            XCTAssertNotNil(myMovieDecode.title)
            XCTAssertNotNil(myMovieDecode.authors)
            XCTAssertNotNil(myMovieDecode.coverURL)
            XCTAssertNotNil(myMovieDecode.description)
            XCTAssertNotNil(myMovieDecode.releaseDate)
            XCTAssertNotNil(myMovieDecode.price)
            
        } catch {
            XCTFail()
        }
    }


}
