//
//  ProductDetailsViewController.swift
//  Market
//
//  Created by Mina Malak on 01/11/2022.
//

import UIKit
import Cosmos

class ProductDetailsViewController: UIViewController {
    
    typealias ModelType = Model.Service.Item
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    private var model: ModelType!
    
    init(model: ModelType) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
    }
    
    private func configure() {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        priceLabel.text = model.priceString
        categoryLabel.text = model.category
        previewImageView.kf.setImage(with: model.imageURL)
        ratingView.rating = model.rate.rate
    }
}

extension ProductDetailsViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .appColor
        
        ratingView.settings.filledBorderColor = .appColor
        ratingView.settings.filledColor = .appColor
        ratingView.settings.emptyBorderColor = .appColor
    }
    
}
