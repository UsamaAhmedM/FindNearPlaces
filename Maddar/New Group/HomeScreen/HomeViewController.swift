//
//  HomeViewController.swift
//  Maddar
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var map: GMSMapView!
    
    private var spinner:UIView?
    @IBAction func didTapBanksButton(_ sender: UIButton) {
        presenter!.requestBanksInArea()
    }
    
    @IBAction func didTapMosquesButton(_ sender: UIButton) {
        presenter!.requestMosquesInArea()
    }
    
    private var presenter: HomeViewPresenter?
    
    private var locationManager:CLLocationManager?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Maddar Task"
        presenter=HomeViewPresenter()
        presenter!.viewDelegate=self
        locationManager=CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestAlwaysAuthorization()
        self.enableLocationServices()
        map.delegate=self;
    }

    
}
extension HomeViewController: HomeViewProtocol{
    func updateMarkersOnMap(_ array:[Any]) {
        map.clear()
        let marker = GMSCustomMarker((presenter?.userLocation?.coordinate)!,PlacesTypes.currentLocation,
                                     "Your Location");
        marker.map = self.map
        let res=array as! [Results]
        
        for result in res
        {
            let marker = GMSCustomMarker(
                CLLocationCoordinate2D(                    latitude:result.geometry!.location!.lat!,
                                                           longitude:result.geometry!.location!.lng!                                       ),
                (presenter?.currentSearch)!,result.name!);
        marker.map = self.map
        }
        UIViewController.removeSpinner(spinner: spinner!)
    }
    
    func showError(_ msg: ErrorType) {
        let alert = UIAlertController(title: "Alert", message: msg.rawValue, preferredStyle: UIAlertControllerStyle.alert)
        switch msg {
        case .location:
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.enableLocationServices()
                    self.locationManager?.requestAlwaysAuthorization()
                    break
                case .cancel,.destructive:
                    break
                }}))
            self.present(alert, animated: true, completion: nil)
            break
        case .internet,.parse:
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.enableLocationServices()
                    break
                case .cancel,.destructive:
                    break
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showSpinner()->Void{
        spinner = UIViewController.displaySpinner(onView: self.map)
    }
}

// Location Handling
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        self.locationManager!.startUpdatingLocation()
        
        self.map.isMyLocationEnabled = true
        self.map.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        presenter?.userLocation=location
        self.map.clear();
        let marker = GMSCustomMarker(location.coordinate,PlacesTypes.currentLocation,
            "Your Location");
        marker.map = self.map
        self.map.camera = GMSCameraPosition(target: location.coordinate,
                                            zoom: 50, bearing: 0, viewingAngle: 0)
        self.locationManager!.stopUpdatingLocation()
    }
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined,.restricted, .denied:
            self.showError(.location)
            break
        case .authorizedAlways,.authorizedWhenInUse:
            self.locationManager!.startUpdatingLocation()
            break
        }
    }
}

// handle tap on marker
extension HomeViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if(marker.title != "Your Location")
        {
        let storyboard = UIStoryboard(name: "ShowRoadScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShowRoadViewContoller") as? ShowRoadViewContoller
        vc!.userDestination=marker.position
        vc!.userLocation=presenter?.userLocation?.coordinate
        vc!.placeName=marker.title
        self.navigationController!.pushViewController(vc!, animated: true)
        }
        return true
    }
}
