//
//  MapViewController.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 30/9/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //MARK: IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: Variables
    
    private var locations: [Location] = []
    
    //MARK: Constants
    let viewModel = MapViewModel()
    
    //MARK: Cycle of life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Transformations"
        

        
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.loadLocations()
            }
        }
        
        viewModel.vieWDidLoad()
    }
    
    func set(model: [Location]) {
        self.locations = model
    }
    

    func loadLocations () {
        setupMap()
        viewModel.getHeroAnnotations(locations: locations) { arrayAnnotations in
            mapView.addAnnotations(arrayAnnotations)

        }
    }
    
    
    func setupMap() {
        mapView.showsUserLocation = true
        mapView.centerToLocation(location: CLLocation(latitude: 21.282, longitude: -157.82944))
    }

}
