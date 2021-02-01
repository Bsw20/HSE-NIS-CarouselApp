//
//  CustomCell.swift
//  HSE-NIS-CarouselApp
//
//  Created by Ярослав Карпунькин on 01.02.2021.
//

import Foundation
import UIKit
import SnapKit

protocol TripCollectionCellDelegate: NSObjectProtocol {
    func didLikeButtonPressed(cell: UICollectionViewCell)
}

class CustomCell: UICollectionViewCell {
    //MARK: - Variables
    public static var reuseId = "CustomCell"
    var isLiked: Bool = false {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    weak var delegate: TripCollectionCellDelegate?
    
    //MARK: - Controls
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "City"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "country"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var daysLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "5 days"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "2000$"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
    }
    
    @objc private func likeButtonTapped() {
        delegate?.didLikeButtonPressed(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        likeButton.imageView?.contentMode = .scaleAspectFill
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    public func set(trip: Trip) {
        cityLabel.text = trip.city
        countryLabel.text = trip.country
        imageView.image = trip.featuredImage
        priceLabel.text = "\(String(trip.price))$"
        daysLabel.text = "\(String(trip.totalDays))days"
        isLiked = trip.isLiked
    }
}

//MARK: - Constraints
extension CustomCell {
    private func setupConstraints(){
        addSubview(containerView)
        containerView.addSubview(bottomView)
        containerView.addSubview(imageView)
        
        containerView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.19)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        let stackView = UIStackView(arrangedSubviews: [cityLabel, countryLabel, daysLabel, priceLabel], axis: .vertical, spacing: 10)
        
        imageView.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        bottomView.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(likeButton.snp.height)
        }
        
        likeButton.imageView?.snp.makeConstraints({ (make) in
            make.width.height.equalToSuperview()
        })
    }
}
