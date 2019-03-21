//
//  UserDefaultStorageManager.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 11/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

class UserDefaultStorageManagerBook: FavoritesProvidable {

    let userDefaults = UserDefaults.standard
    let favoritesKey: String = "favoritebook"

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()


    func getFavorites() -> [MediaItemDetailedProvidable]? {
        if let favoritesData = userDefaults.data(forKey: favoritesKey) {
            return try? decoder.decode([Book].self, from: favoritesData)
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
            userDefaults.set(try encoder.encode(favorites as! [Book]), forKey: favoritesKey)
            userDefaults.synchronize()
        } catch {
            fatalError("error enconding favorites")
        }
    }
}
