//
//  ViewController.swift
//  UnccRadar
//
//  Created by Alexander Pinkerton on 4/1/16.
//  Copyright © 2016 Alexander Pinkerton. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var label_lat: UILabel!
    @IBOutlet weak var label_long: UILabel!
    @IBOutlet weak var buildingChooser: UIPickerView!
    @IBOutlet weak var bar_distance: UIProgressView!
    
    let buildingList = [
        "Mozzarella",
        "Gorgonzola",
        "Provolone",
        "Brie",
        "Maytag Blue",
        "Sharp Cheddar",
        "Monterrey Jack",
        "Stilton",
        "Gouda",
        "Goat Cheese",
        "Asiago"]
    
    var airports: [String: Location] = [
        "Woodward": Location(latitude: 35.307504, longitude: 80.735387),
        "Portal": Location(latitude: 35.311696, longitude: 80.74307),
        "Epic": Location(latitude: 35.309726, longitude: 80.743411),
        "West Deck": Location(latitude: 35.30547, longitude: 80.736605),
        "Burson": Location(latitude: 35.307526, longitude: 80.732355),
        "East Deck 2": Location(latitude: 35.305399, longitude: 80.726812),
        "East Deck 1": Location(latitude: 35.304772, longitude: 80.727505),
        "YYZ": Location(latitude: 23, longitude: 23),
        "YYZ": Location(latitude: 23, longitude: 23),
        "YYZ": Location(latitude: 23, longitude: 23),
        "YYZ": Location(latitude: 23, longitude: 23),
        "YYZ": Location(latitude: 23, longitude: 23)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

