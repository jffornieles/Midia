//
//  MediaItemDetailedProvidable.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 05/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

protocol MediaItemDetailedProvidable {

    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }
    var creatorName: String? { get }
    var rating: Float? { get }
    var numberOfReviews: Int? { get }
    var creationDate: Date? { get }
    var price: Float? { get }
    var description: String? { get }

}
