//
//  CarsListTableViewCell.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import UIKit

class CarsListTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carTitleLabel: UILabel!
    @IBOutlet weak var carDateLabel: UILabel!
    @IBOutlet weak var carDescriptionLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!

    //Gradient Property
    let gradientLayer = CAGradientLayer()
    
    //MARK: - Init Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if carImageView.bounds.width >= ScreenSize.SCREEN_WIDTH {
            gradientLayer.frame = carImageView.bounds
        }
    }

    //Setup Gradient Method
    func setupGradient() {
        let height: CGFloat = ScreenSize.SCREEN_WIDTH * 3/4
        gradientLayer.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 0.6, 1]
        carImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
