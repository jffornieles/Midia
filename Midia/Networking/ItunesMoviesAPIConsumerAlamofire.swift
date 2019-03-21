//
//  ItunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 18/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit
import Alamofire

class ItunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        Alamofire.request(ItunesMoviesAPIConstants.getAbsoluteURL(withParams: ["top"])).responseData { (response) in
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error)
                }
            }
        }
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        Alamofire.request(ItunesMoviesAPIConstants.getAbsoluteURL(withParams: queryParams.components(separatedBy: " "))).responseData { (response) in
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error)
                }
            }
        }
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        Alamofire.request(ItunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)).responseData { (response) in
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    if let movie = movieCollection.results?.first {
                        success(movie)
                    }
                } catch {
                    failure(error)
                }
            }
        }
    }
    
    
}
