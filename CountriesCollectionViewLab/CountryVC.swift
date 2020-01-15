//
//  ViewController.swift
//  CountriesCollectionViewLab
//
//  Created by Christian Hurtado on 1/14/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class CountryVC: UIViewController {
    
    @IBOutlet weak var countrySearch: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchQuery = "united" {
        didSet{
        searchBarQuery(for: searchQuery)
        }
    }
    
    var countries = [Country](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        countrySearch.delegate = self
        searchBarQuery(for: "uni")
    }
        
    func searchBarQuery(for search: String) {
     CountrySearchAPI.getCountries(for: search, completion: {[weak self] (result) in
     switch result {
     case .failure( let appError ):
         print("Error \(appError)")
     case .success( let countries):
         self?.countries = countries
        dump(countries)
         }
 })
 }
}

extension CountryVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchBar.text!
    }
}

extension CountryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCVC else {
            fatalError("Could not type cast reusable cell")
        }
        let country = countries[indexPath.row]
        cell.countryName.text = country.name.description
        cell.capitalName.text = country.capital.description
        cell.popLabel.text = "Population: \(country.population.description)"
        cell.popLabel.textColor = .gray
        cell.configureCell(for: country)
        cell.backgroundColor = .white
        return cell
    }
}

extension CountryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//            let interItemSpacing = CGFloat(10)
//            let maxWidth = UIScreen.main.bounds.size.width // device's width
//    //      let maxHeight = UIScreen.main.bounds.size.height
//            let numberOfItems: CGFloat = 3 // items per row
//            let totalSpacing: CGFloat = numberOfItems * interItemSpacing
//            let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems

        return  CGSize(width: 220, height: 220) // CGSize(width: itemWidth, height: itemWidth)
        }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//        }
    
    
}
