//
//  ShowRoadViewContoller.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage

class ShowRoadViewContoller: UIViewController {
    @IBOutlet weak var roadImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    public var userLocation:CLLocationCoordinate2D?
    public var userDestination:CLLocationCoordinate2D?
    public var placeName:String?
    private var presenter: ShowRoadPresenter?
    private var spinner:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter=ShowRoadPresenter()
        presenter!.viewDelegate=self
        addressLabel.text=placeName!
        presenter!.getStaticMap()
        presenter!.getDistance()
        spinner=UIViewController.displaySpinner(onView: self.view)
    }
}
extension ShowRoadViewContoller:ShowRoadProtocol
{
    
    var source:CLLocationCoordinate2D{return self.userLocation!}
    var destination:CLLocationCoordinate2D{return self.userDestination!}
    
    func showError(_ msg: ErrorType) {
        let alert = UIAlertController(title: "Alert", message: msg.rawValue, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    func updateRouteImage(_ url:String) -> Void
    {
        let urlStr:String=url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        roadImageView.sd_setImage(with: URL(string:urlStr), placeholderImage: UIImage(named: "placeholder.png"),options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            UIViewController.removeSpinner(spinner: self.spinner!)
        })
    }

    func updateDistanceLabel(_ distance:String) -> Void{
        addressLabel.text=addressLabel.text!+"\n Distance: "+distance
        addressLabel.layoutIfNeeded()
    }
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    class func removeSpinner(spinner :UIView) {
            spinner.removeFromSuperview()
    }
}
