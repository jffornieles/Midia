//
//  StorageManager.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 11/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

class StorageManager {
    
    let mediaItemKind: MediaItemKind
    let shared: FavoritesProvidable
    
    private init(mediaItemKind: MediaItemKind, shared: FavoritesProvidable) {
        self.mediaItemKind = mediaItemKind
        self.shared = shared
    }
    
    convenience init(mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
            self.init(mediaItemKind: mediaItemKind, shared: CoreDataStorageManagerBook())
            // self.init(mediaItemKind: mediaItemKind, shared: UserDefaultStorageManagerBook())
        case .movie:
            self.init(mediaItemKind: mediaItemKind, shared: CoreDataStorageManagerMovie())
            //self.init(mediaItemKind: mediaItemKind, shared: UserDefaultStorageManagerMovie())
        default:
            fatalError("There is not this mediaItemKind yet!!")
        }
    }
    
    //static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .book)
    // static let shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .book)
}
