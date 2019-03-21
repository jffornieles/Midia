//
//  ItunesMoviesAPIConsumerURLSession.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 18/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

class ItunesMoviesAPIConsumerURLSession: MediaItemAPIConsumable {
    
    let session = URLSession.shared
    
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let url = ItunesMoviesAPIConstants.getAbsoluteURL(withParams: ["top"])
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                    return
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async {
                        success(movieCollection.results ?? [])
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    success([])
                }                
            }
        }
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let params = queryParams.components(separatedBy: " ")
        let url = ItunesMoviesAPIConstants.getAbsoluteURL(withParams: params)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async {
                        success(movieCollection.results ?? [])
                    }
                } catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    success([])
                }
            }
        }
        task.resume()
        
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        let url = ItunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        success(movie)
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("failure")
                        failure(error)
                    }
                }
            }
        }
        task.resume()
    }

    
}
