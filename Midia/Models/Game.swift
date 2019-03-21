//
//  Game.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 28/02/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

struct Game: MediaItemProvidable, MediaItemDetailedProvidable {

    let mediaItemId: String = "1245"
    let title: String = "A game"
    let imageURL: URL? = nil
    let creatorName: String? = nil
    let rating: Float? = nil
    let numberOfReviews: Int? = nil
    let creationDate: Date? = nil
    let price: Float? = nil
    let description: String? = nil

}
