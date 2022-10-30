//
//  ListCell.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import UIKit

import Strongify

//import RxSwift
//import RxCocoa

import Kingfisher
//import RxKingfisher

final class ListCell: UITableViewCell {
    
    typealias ModelType = Model.Service.Item
    
    private lazy var previewImageView: UIImageView = self.createImageView()
    private lazy var titleLabel: UILabel = self.createTitleLabel()
    private lazy var descriptionLabel: UILabel = self.createDescriptionLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.previewImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        
        previewImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        previewImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        previewImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 0).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ModelType) {
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.description
        self.previewImageView.kf.setImage(with: model.imageURL)
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}
