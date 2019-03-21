//
//  MediaItemProvidable.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 28/02/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import Foundation

protocol MediaItemProvidable {

    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }

}
