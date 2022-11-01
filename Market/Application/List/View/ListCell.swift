//
//  ListCell.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import UIKit
import Kingfisher

final class ListCell: UITableViewCell {
    
    typealias ModelType = Model.Service.Item
    
    private lazy var previewImageView: UIImageView = createImageView()
    private lazy var titleLabel: UILabel = createTitleLabel()
    private lazy var priceLabel: UILabel = createPriceLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(previewImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        
        previewImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        previewImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        previewImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ModelType) {
        titleLabel.text = model.title
        priceLabel.text = model.priceString
        previewImageView.kf.setImage(with: model.imageURL)
    }
    
}

//MARK: - set List Cell Components
extension ListCell {
    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createPriceLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
