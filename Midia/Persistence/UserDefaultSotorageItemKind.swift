//
//  UserDefaultSotorageItemKind.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 23/03/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

let userDefaults = UserDefaults.standard
let mediaItemKey = "mediaItemKey"

func getItemKind() -> Int {
    return userDefaults.integer(forKey: mediaItemKey)
}

func saveItemKind(itemKind: Int) {
    userDefaults.set(itemKind, forKey: mediaItemKey)
    userDefaults.synchronize()
}


