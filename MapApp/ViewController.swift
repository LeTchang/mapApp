//
//  ViewController.swift
//  MapApp
//
//  Created by Tchang on 21/06/16.
//  Copyright © 2016 Tchang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Viewcontroller outlets
    @IBOutlet weak var mapVw: MKMapView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    // MARK: - External View outlets
    @IBOutlet var addVw: UIView!
    @IBOutlet var LocationsView: UIView!
    
    // MARK: - TableView with LocationsView
    @IBOutlet weak var locationTableView: UITableView!
    
    
    // Mark: - Textfields when ADD
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var latitudeText: UITextField!
    @IBOutlet weak var longitudeText: UITextField!
    
    // MARK: - Private variable
    var locationArray = [Location]()
    let screenWidth = UIScreen.mainScreen().bounds.width
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        mapInit()
    }
    
    // MARK: - Other functions
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapVw.setRegion(coordinateRegion, animated: true)
    }
    
    func showError() -> Void {
        let alert = UIAlertController(title: "Error", message: "Wrong format", preferredStyle: UIAlertControllerStyle.Alert)
        alert.view.setNeedsLayout()
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func mapInit() {
        locationArray.append(Location(name: "42 - Paris", latitude: 48.896684, longitude: 2.318408))
        locationArray.append(Location(name: "42 - USA", latitude: 37.548623, longitude: -122.059118))
        mapVw.annotation("42 Paris", latitude: 48.896684, longitude: 2.318408)
        mapVw.annotation("42 USA", latitude: 37.548623, longitude: -122.059118)
        let initialLocation = CLLocation(latitude: 48.896684, longitude: 2.318408)
        centerMapOnLocation(initialLocation)
    }
    
    func viewInit() {
        addVw.translatesAutoresizingMaskIntoConstraints = false
        addVw.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        LocationsView.translatesAutoresizingMaskIntoConstraints = false
        LocationsView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
        locationTableView.dataSource = self
        locationTableView.delegate = self
    }
    
    // MARK: - Show & Add external Views
    func showLocationsView() {
        view.addSubview(LocationsView)
        let bottomConstraint = LocationsView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        let leftConstraint = LocationsView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let topConstraint = LocationsView.topAnchor.constraintEqualToAnchor(view.topAnchor)
        let widthConstraint = LocationsView.widthAnchor.constraintEqualToConstant(screenWidth / 2)
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, topConstraint, widthConstraint])
        view.layoutIfNeeded()
        self.LocationsView.center.x -= screenWidth / 2
        UIView.animateWithDuration(0.3) {
            self.LocationsView.center.x += self.screenWidth / 2
        }
    }
    
    func hideLocationsView() {
        UIView.animateWithDuration(0.3, animations: {
            self.LocationsView.center.x -= self.screenWidth / 2
        }) { completed in
            if completed == true {
                self.LocationsView.removeFromSuperview()
            }
        }
    }
    
    func showAddView() {
        view.addSubview(addVw)
        let bottomConstraint = addVw.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
        let leftConstraint = addVw.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let topConstraint = addVw.topAnchor.constraintEqualToAnchor(view.topAnchor)
        let rightConstraint = addVw.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, topConstraint, rightConstraint])
        view.layoutIfNeeded()
        self.addVw.alpha = 0
        UIView.animateWithDuration(0.3) {
            self.addVw.alpha = 1
        }
    }
    
    func hideAddView() {
        UIView.animateWithDuration(0.3, animations: {
            self.addVw.alpha = 0
        }) { completed in
            if completed == true {
                self.addVw.removeFromSuperview()
            }
        }
    }
    
    // MARK: - TableView functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! customTableViewCell
        let longitude = String(locationArray[indexPath.row].getLongitude())
        let latitude = String(locationArray[indexPath.row].getLatitude())
        let location = "Coord: " + latitude + ", " + longitude
        cell.nameText.text = locationArray[indexPath.row].getName()
        cell.locationText.text = location
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let latitude = locationArray[indexPath.row].getLatitude()
        let longitude = locationArray[indexPath.row].getLongitude()
        hideLocationsView()
        
        centerMapOnLocation(CLLocation(latitude: latitude, longitude: longitude))
    }
    
    // MARK: - IBActions
    @IBAction func onSearch(sender: AnyObject) {
        if LocationsView.window != nil {
            hideLocationsView()
        } else {
            showLocationsView()
        }
    }
    
    @IBAction func onAdd(sender: AnyObject) {
        if addVw.window != nil {
            hideAddView()
        } else {
            showAddView()
        }
    }
    
    @IBAction func onAddAction(sender: AnyObject) {
        guard let name = nameText.text?.trim() else {
            showError()
            return
        }
        guard let longitude = Double(longitudeText.text!) where longitude < 180 && longitude > -180 else {
            showError()
            return
        }
        guard let latitude = Double(latitudeText.text!) where latitude < 90 && latitude > -90 else {
            showError()
            return
        }
        let new = Location(name: name, latitude: latitude, longitude: longitude)
        locationArray.append(new)
        locationTableView.reloadData()
        mapVw.annotation(name, latitude: latitude, longitude: longitude)
        hideAddView()
    }

    @IBAction func onCancelAction(sender: AnyObject) {
        hideAddView()
    }
}