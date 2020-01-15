//
//  CountryCVC.swift
//  CountriesCollectionViewLab
//
//  Created by Christian Hurtado on 1/14/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import ImageKit

class CountryCVC: UICollectionViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    
    @IBOutlet weak var countryFlag: UIImageView!
    
    func configureCell(for country: Country){
        
        let imageUrl = "https://www.countryflags.io/\(country.alpha2Code)/flat/64.png"
        countryFlag.getImage(with: imageUrl) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.countryFlag.image = UIImage(systemName: "exclaimationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.countryFlag.image = image
                }
                
            }
        }
    }
}
