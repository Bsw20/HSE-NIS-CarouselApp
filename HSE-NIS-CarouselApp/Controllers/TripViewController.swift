//
//  TripViewController.swift
//  HSE-NIS-CarouselApp
//
//  Created by Ярослав Карпунькин on 01.02.2021.
//

import UIKit
import SnapKit

class TripViewController: UIViewController {
    
    private var trips =
        [
            Trip(tripId: "Paris001", city: "Paris", country: "France",
    featuredImage: UIImage(named: "paris-2017-home"), price: 2000, totalDays: 5, isLiked:
    false),
            Trip(tripId: "Rome001", city: "Rome", country: "Italy", featuredImage:UIImage(named: "italy"), price: 800, totalDays: 3, isLiked: false),
            Trip(tripId: "Istanbul001", city: "Istanbul", country: "Turkey",
    featuredImage: UIImage(named: "stambul-dostoprimechatelnosti"), price: 2200, totalDays: 10, isLiked:true),
        ]
    //MARK: - Controls
    private var collectionView: UICollectionView!
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Most Popular \nDestinations"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "APPCODA"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupCollection()
        setupConstraints()
    }
    
    //MARK: - funcs
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

//MARK: - TripCollectionCellDelegate
extension TripViewController: TripCollectionCellDelegate {
    func didLikeButtonPressed(cell: UICollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            trips[indexPath.row].isLiked = !trips[indexPath.row].isLiked
            collectionView.reloadData()
        }
    }
    
    
}

//MARK: - CollectionView
extension TripViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseId, for: indexPath) as! CustomCell
        cell.set(trip: trips[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        return  CGSize(width: screenSize.width * 0.6, height: screenSize.height * 0.5)
    }
    
    
}

//MARK: - Constraints
extension TripViewController {
    private func setupConstraints() {
        view.addSubview(collectionView)
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.centerY.equalToSuperview()
        }
        
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().offset(20)
        }
    }
}

// MARK: - SwiftUI
import SwiftUI

struct VCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let feedVC = TripViewController()

        func makeUIViewController(context: Context) -> some TripViewController {
            return feedVC
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    }
}
