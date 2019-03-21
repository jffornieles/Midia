//
//  UIImageView+Networking.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 04/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(fromURL url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }

}
