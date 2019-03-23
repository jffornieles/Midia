//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 28/02/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

class MediaItemProvider {

    let mediaItemKind: MediaItemKind
    let apiConsumer: MediaItemAPIConsumable

    init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }

    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
        switch mediaItemKind {
        case .book:
             self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerAlamofire())
            //self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerURLSession())
        case .movie:
             self.init(withMediaItemKind: mediaItemKind, apiConsumer: ItunesMoviesAPIConsumerURLSession())
            //self.init(withMediaItemKind: mediaItemKind, apiConsumer: ItunesMoviesAPIConsumerAlamofire())
        case .game:
            fatalError("MediaItemKind not supported yet :( coming soon")
//            let alertController = UIAlertController(title: nil, message: "MediaItemKind not supported yet :( coming soon.", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        case .series:
            fatalError("MediaItemKind not supported yet :( coming soon")
        }
    }

    func getHomeMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // guardar en cache
        apiConsumer.getLatestMediaItems(onSuccess: { (mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }

    func getSearchMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        apiConsumer.getMediaItems(withQueryParams: queryParams, success: { (mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        }
    }


    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        apiConsumer.getMediaItem(byId: mediaItemId, success: { (mediaItem) in
            assert(Thread.current == Thread.main)
            success(mediaItem)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        }
    }

}
