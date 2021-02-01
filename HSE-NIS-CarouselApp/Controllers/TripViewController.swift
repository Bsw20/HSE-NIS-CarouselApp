//
//  TripViewController.swift
//  HSE-NIS-CarouselApp
//
//  Created by Ярослав Карпунькин on 01.02.2021.
//

import UIKit
import SnapKit

class TripViewController: UIViewController {

    //MARK: - Controls
    private var collectionView: UICollectionView!
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Most Popular Destinations"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollection()
    }
    
    //MARK: - funcs
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
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
