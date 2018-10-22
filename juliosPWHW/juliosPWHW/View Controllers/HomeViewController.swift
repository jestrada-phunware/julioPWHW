//
//  ViewController.swift
//  juliosPWHW
//
//  Created by Julio Estrada on 6/15/18.
//  Copyright © 2018 Julio Estrada. All rights reserved.
//

import UIKit
import RealmSwift
import Reachability


class HomeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties
    var events: [Event] = []
    let reachability = Reachability()!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        loadData()
    }

    // MARK: - Functions
    fileprivate func setupViews() {
        setupNavbar()
        setupCollectionView()
    }

    fileprivate func setupNavbar() {
        self.navigationItem.title = "Phun App"
        self.navigationItem.rightBarButtonItem = nil
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    fileprivate func loadData() {
        reachability.whenReachable = { _ in
            APIService.shared.fetchEvents { (events) in
                self.events = events
                DispatchQueue.main.async {
                    RealmManager.shared.saveData(events)
                    self.collectionView.reloadData()
                }
            }
        }
        
        reachability.whenUnreachable = { _ in
            self.navigationItem.title = "Phun App (⛔️Offline)"
            let realm = RealmManager.shared.realm
            let objects = RealmManager.shared.loadSavedData(from: realm)

            // TODO:
            self.events.append(contentsOf: objects)
            self.collectionView.reloadData()
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

        reachability.stopNotifier()
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDetail" {
            guard let detailVC = segue.destination as? DetailViewController, let indexPath = sender as? IndexPath else {
                return
            }
            let event = self.events[indexPath.row]
            detailVC.event = event

        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCell.defaultIdentifier, for: indexPath) as? EventCell else {
            return EventCell()
        }

        cell.event = self.events[indexPath.row]

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeToDetail", sender: indexPath)
    }

}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemSize = CGSize(width: view.frame.width/2, height: view.frame.height/3)
        let deviceSize = UI_USER_INTERFACE_IDIOM() == .pad ? itemSize : CGSize(width: view.frame.width, height: view.frame.height/3)

        return deviceSize
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }

        layout.itemSize = (size.width < size.height) ? CGSize(width: width/2, height: height/3) : CGSize(width: width, height: height/3 - 22.33)
        layout.invalidateLayout()
        collectionView.reloadData()
    }
}







