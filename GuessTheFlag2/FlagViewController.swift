//
//  FlagViewController.swift
//  GuessTheFlag2
//
//  Created by Assel Artykbay on 14.10.2024.
//

import UIKit

class FlagViewController: UIViewController {
    
    @IBOutlet var continentsImages: [UIButton]!
    @IBOutlet var continentsLabels: [UILabel]!
    let continents: [Continent] = [
        Continent(name: "Asia", image: "Asia", countries: [
            Country(name: "Kazakhstan", flagName: "Kazakhstan", continent: "Asia"),
            Country(name: "Korea", flagName: "Korea", continent: "Asia"),
            Country(name: "Japan", flagName: "Japan", continent: "Asia"),
            Country(name: "China", flagName: "China", continent: "Asia"),
            Country(name: "Thailand", flagName: "Thailand", continent: "Asia")
        ]),
        Continent(name: "Europe", image: "Europe", countries: [
            Country(name: "Slovakia", flagName: "Slovakia", continent: "Europe"),
            Country(name: "Slovenia", flagName: "Slovania", continent: "Europe"),
            Country(name: "Turkey", flagName: "Turkey", continent: "Europe"),
            Country(name: "UK", flagName: "UK", continent: "Europe"),
            Country(name: "Ukraine", flagName: "Ukraine", continent: "Europe")
        ])
    ]
    
    
    override func viewDidLoad() {
        showContinents()
    }
    
    func showContinents(){
        for (index, continent) in continents.enumerated() {
            continentsImages[index].setTitle(continent.name, for: .normal)
        }
    
    }
    
    @IBAction func selectContinent(_ sender: UIButton) {
        performSegue(withIdentifier: "Ident", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? UIButton,
           let index = continentsImages.firstIndex(of: button),
           let destinationVC = segue.destination as? ViewController {
            destinationVC.selectedContinent = continents[index]
        }
    }
}
