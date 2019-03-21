//
//  UserDefaultStorageManagerMovie.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 21/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//


import Foundation

class UserDefaultStorageManagerMovie: FavoritesProvidable {
    
    let userDefaults = UserDefaults.standard
    let favoritesKey = "favoritemovie"
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        if let favoritesData = userDefaults.data(forKey: favoritesKey) {
            return try? decoder.decode([Movie].self, from: favoritesData)
        }
        return nil
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        var retrieved: MediaItemDetailedProvidable? = nil
        if let favorites = getFavorites() {
            retrieved = favorites.filter({ $0.mediaItemId == favoriteId }).first
        }
        return retrieved
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        guard getFavorite(byId: favorite.mediaItemId) == nil else {
            return
        }
        if var favorites = getFavorites() {
            favorites.append(favorite)
            save(favorites)
        } else {
            save([favorite])
        }
    }
    
    func remove(favoriteWithId favoriteId: String) {
        if var favorites = getFavorites() {
            for (index, favorite) in favorites.enumerated() {
                if favoriteId == favorite.mediaItemId {
                    favorites.remove(at: index)
                    save(favorites)
                }
            }
        }
    }
    
    private func save(_ favorites: [MediaItemDetailedProvidable]) {
        do {
            if let movies = favorites as? [Movie] {
                userDefaults.set(try encoder.encode(movies), forKey: favoritesKey)
            }
            userDefaults.synchronize()
        } catch {
            fatalError("error enconding favorites")
        }
    }
}

