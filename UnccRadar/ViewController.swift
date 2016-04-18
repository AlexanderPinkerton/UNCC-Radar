//
//  ViewController.swift
//  UnccRadar
//
//  Created by Alexander Pinkerton on 4/1/16.
//  Copyright © 2016 Alexander Pinkerton. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController:UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var label_current_lat: UILabel!
    @IBOutlet weak var label_current_long: UILabel!
    @IBOutlet weak var label_target_lat: UILabel!
    @IBOutlet weak var label_target_long: UILabel!
    @IBOutlet weak var buildingChooser: UIPickerView!
    @IBOutlet weak var bar_distance: UIProgressView!
    @IBOutlet weak var imageView_needle: UIImageView!
    @IBOutlet weak var bar_label: UILabel!
    
    var locValue:CLLocationCoordinate2D!
    let locationManager=CLLocationManager()
    var currentLocation: CLLocation!
    var targetLocation: CLLocation!
    var user: CLLocationCoordinate2D!
    var direction:CLLocationDirection!
    
    @IBOutlet weak var label_eta: UILabel!
    var toRotate: CGFloat! = 0
    var bearing: Double! =  0.0
    
    var degrees = 0.0
    
    var currentDistance: Double = 0
    var startDistance: Double = 0.0
    
    var currentTarget: String!
    
    
    var buildings: [String: CLLocation] = [
        "Woodward": CLLocation(latitude: 35.307100, longitude: -80.735971),
        "Portal": CLLocation(latitude: 35.311696, longitude: -80.74307),
        "Epic": CLLocation(latitude: 35.309726, longitude: -80.743411),
        "West Deck": CLLocation(latitude: 35.30547, longitude: -80.736605),
        "Burson": CLLocation(latitude: 35.307526, longitude: -80.732355),
        "East Deck 2": CLLocation(latitude: 35.305399, longitude: -80.726812),
        "East Deck 1": CLLocation(latitude: 35.304772, longitude: -80.727505),
        "Barnhardt Student Activity Center": CLLocation(latitude: 35.306142, longitude: -80.734261),
        "Belk Gym": CLLocation(latitude: 35.305385, longitude:-80.735473),
        "Cone University Center": CLLocation(latitude: 35.30529, longitude: -80.733135),
        "King": CLLocation(latitude: 35.305224, longitude: -80.732450),
        "Atkins": CLLocation(latitude: 35.305419, longitude:-80.732205),
        "Reese": CLLocation(latitude: 35.304687, longitude: -80.732485),
        "Colvard": CLLocation(latitude: 35.305013, longitude: -80.731749),
        "Rowe": CLLocation(latitude: 35.304403, longitude: -80.730719),
        "Denny": CLLocation(latitude: 35.305377, longitude: -80.729844),
        "Robinson Hall": CLLocation(latitude: 35.303938, longitude: -80.72993),
        "Storrs": CLLocation(latitude: 35.30463, longitude: -80.728978),
        "Kennedy": CLLocation(latitude: 35.305967, longitude: -80.730883),
        "Friday": CLLocation(latitude: 35.306319, longitude: -80.72993),
        "Fretwell": CLLocation(latitude: 35.30616, longitude: -80.728978),
        "Cato": CLLocation(latitude: 35.305447, longitude: -80.728572),
        "McEniry": CLLocation(latitude: 35.307091, longitude: -80.730017),
        "Smith": CLLocation(latitude: 35.306871, longitude: -80.731576),
        "Cameron Hall": CLLocation(latitude: 35.307694, longitude: -80.73123),
        "Auxiliary Services Bldg": CLLocation(latitude: 35.307765, longitude: -80.730493),
        "McMillan Greenhouse": CLLocation(latitude: 35.30781, longitude: -80.729692),
        "Elm Hall": CLLocation(latitude: 35.308771, longitude: -80.731404),
        "Oak Hall": CLLocation(latitude: 35.309037, longitude: -80.732072),
        "Pine Hall": CLLocation(latitude: 35.309297, longitude: -80.731405),
        "Maple Hal": CLLocation(latitude: 35.309033, longitude: -80.731348),
        "Student Union": CLLocation(latitude: 35.308614, longitude: -80.733737),
        "Union Deck": CLLocation(latitude: 35.309167, longitude: -80.735192),
        "Belk Hall": CLLocation(latitude: 35.310159, longitude: -80.735084),
        "Wallis Hall": CLLocation(latitude: 35.311215, longitude: -80.733748),
        "Lynch Hall": CLLocation(latitude: 35.310415, longitude: -80.73374),
        "Witherspoon Hall": CLLocation(latitude: 35.310918, longitude: -80.732518),
        "Bioinformatics": CLLocation(latitude: 35.312676, longitude: -80.742007),
        "Grigg Hall": CLLocation(latitude: 35.311161, longitude: -80.742062),
        "RUP-2": CLLocation(latitude: 35.309825, longitude: -80.742971),
        "Uncc Fitness Trai": CLLocation(latitude: 35.308987, longitude: -80.744259),
        "Richardson Stadium": CLLocation(latitude: 35.310566, longitude: -80.740126),
        "Duke Centennial Hall": CLLocation(latitude: 35.311927, longitude: -80.741224),
        "Kulwicki Laboratory": CLLocation(latitude: 35.312301, longitude: -80.740707),
        "Motorsports Research": CLLocation(latitude: 35.312632, longitude: -80.740271),
        "South Village Deck": CLLocation(latitude: 35.300642, longitude: -80.736162),
        "Residence Dining Hall": CLLocation(latitude: 35.302099, longitude: -80.733655),
        "Moore Hall": CLLocation(latitude: 35.302603, longitude: -80.734131),
        "Sanford Hall": CLLocation(latitude: 35.302982, longitude: -80.733525),
        "Memorial Hall": CLLocation(latitude: 35.303803, longitude: -80.735906),
        "Niner House": CLLocation(latitude: 35.304082, longitude: -80.727771),
        "East Deck 3": CLLocation(latitude: 35.306029, longitude: -80.726147),
        "Cafeteria Activities Bldg": CLLocation(latitude: 35.308998, longitude: -80.728285),
        "Sycamore Hall": CLLocation(latitude: 35.308858, longitude: -80.728956),
        "Hickory Hall": CLLocation(latitude: 35.309198, longitude: -80.728956),
        "Cedar Hall": CLLocation(latitude: 35.309581, longitude: -80.728956),
        "Hawthorn Hall": CLLocation(latitude: 35.311501, longitude: -80.727424),
        "Greek Village": CLLocation(latitude: 35.312421, longitude: -80.725816),
        "Campus Police/ Facilities management": CLLocation(latitude: 35.311995, longitude: -80.730305),
        "North Deck": CLLocation(latitude: 35.313469, longitude: -80.731494)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buildingChooser.dataSource = self
        buildingChooser.delegate = self
        targetLocation = buildings["Atkins"]
        

        self.locationManager.requestWhenInUseAuthorization()
        direction = 0.00
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }
        else{
            //display warning message here
            print("location service not enabled")
        }

        
        user = locationManager.location?.coordinate
        calculateUserAngle(user)
        
        
    }
    func calculateUserAngle(user:CLLocationCoordinate2D) {
        
        var x = 0.0; var y = 0.0;  var deg = 0.0; var delLon = 0.0;
        
        delLon = targetLocation.coordinate.longitude - user.longitude;
        y = sin(delLon) * cos(targetLocation.coordinate.latitude);
        x = cos(user.latitude) * sin(targetLocation.coordinate.latitude) - sin(user.latitude) * cos(targetLocation.coordinate.latitude) * cos(delLon);
    
        deg = radiansToDegrees(atan2(y, x))
        if(deg<0){
            deg = -deg;
        } else {
            deg = 360 - deg;
        }    
        degrees = deg;
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    //--------------------------------------------------------------
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array(buildings.keys).count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(buildings.keys).sort(<)[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //This function is executed when the spinner stops on an item.
        //label_lat.text = buildingList[row]
        
        //var location: Location!
        targetLocation = buildings[Array(buildings.keys).sort(<)[row]]
        label_target_lat.text = String(format: "%.4f",targetLocation.coordinate.latitude)
        label_target_long.text = String(format: "%.4f",targetLocation.coordinate.longitude)
        
        currentTarget = Array(buildings.keys).sort(<)[row];
        startDistance = currentLocation.distanceFromLocation(targetLocation)
        
        
    }
    
    func locationManager(manager: CLLocationManager,didUpdateHeading newHeading:CLHeading) {
        
        //Spin the needle if heading changed.
        onPositionChange((degrees)-newHeading.magneticHeading, image: imageView_needle)
        
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let curLoc:CLLocationCoordinate2D = manager.location!.coordinate
        calculateUserAngle(curLoc)
        label_current_lat.text = "\(curLoc.latitude)"
        label_current_long .text = "\(curLoc.longitude)"
        label_current_lat.text = String(format: "%.4f",
            curLoc.latitude)
        label_current_long.text = String(format: "%.4f",
            curLoc.longitude)
        
        currentLocation = CLLocation(latitude: curLoc.latitude, longitude: curLoc.longitude)
        
        //Update the distance to the current target
        let distance = Double(currentLocation.distanceFromLocation(targetLocation))
        let progress = 1 - (distance/startDistance)
        bar_distance.setProgress(Float(progress), animated: false)
        bar_label.text = (String)(Int(distance))+" Meters"
        
        //get eta
        let speed = currentLocation.speed
        print(speed)
        let eta = distance/speed
        
        if(speed != -1){
            label_eta.text = "Time remaining: \(eta)"
        }
        else{
            label_eta.text = "Time remaining: N/A"
        }
        

    }
    
    
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
    
    func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {
        
        let lat1 = degreesToRadians(point1.coordinate.latitude)
        let lon1 = degreesToRadians(point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(point2.coordinate.latitude)
        let lon2 = degreesToRadians(point2.coordinate.longitude)
        
        let dlon = lon2 - lon1
        
        let y = sin(dlon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dlon);
        var radiansBearing = atan2(y, x);
        
        if(radiansBearing < 0.0)
        {
            radiansBearing += 2*M_PI;
        }
        
        return radiansToDegrees(radiansBearing)
    }
    
    func onPositionChange(angle: Double, image: UIImageView)
    {
        UIView.animateWithDuration(1.0, animations:
            {
                let a = CGFloat(self.degreesToRadians(angle))
                image.transform = CGAffineTransformMakeRotation(a)
        })
    }
    
    
}

