//
//  ViewController.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    var events: [Event] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    let realmManager = RealmManager()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCode()

        APIService.shared.fetchEvents { (events) in
            self.events = events
            DispatchQueue.main.async {
                self.realmManager.saveData(objects: events)
            }
        }
    }

    // MARK: - Functions
    func setupCode() {
        setupNavbar()
        setupCollectionView()
    }
    func setupNavbar() {
        navigationItem.title = "Phun App"
        self.navigationItem.rightBarButtonItem = nil
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetail" {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            let event = self.events[indexPath.row]
            detailVC.event = event
            detailVC.indexPath = indexPath
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.defaultIdentifier, for: indexPath) as! EventCell
        let event = self.events[indexPath.row]
        cell.event = event

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeToDetail", sender: indexPath)
    }

}

// MARK:
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 250)
    }
}







