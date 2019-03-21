//
//  FavoritesViewController.swift
//  Midia
//
//  Created by Jose Francisco Fornieles on 11/03/2019.
//  Copyright © 2019 Jose Francisco Fornieles. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let favoriteCellReuseIdentifier = "favoriteCellReuseIdentifier"

    var favorites: [MediaItemDetailedProvidable] = []
    var mediaItemProvider: MediaItemProvider!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let storageManager = StorageManager(mediaItemKind: mediaItemProvider.mediaItemKind)
        if let storedFavorites = storageManager.shared.getFavorites() {
            favorites = storedFavorites
            tableView.reloadData()
        }
    }

}

extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }

        let mediaItem = favorites[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider
        present(detailViewController, animated: true, completion: nil)
    }
}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellReuseIdentifier) as? FavoriteTableViewCell else {
            fatalError()
        }
        cell.mediaItem = favorites[indexPath.row]
        return cell
    }

}
