//
//  MapViewModel.swift
//  PracticaiOSAvanzado
//
//  Created by Roberto Rojo Sahuquillo on 30/9/22.
//

import Foundation
import CoreLocation
import KeychainSwift
import MapKit


final class MapViewModel {
    // Creamos
    //MARK: Constants
    private let networkModel: NetworkModel
    private let locationManager: CLLocationManager
    private var keychain: KeychainSwift
    private var coreDataManager: CoreDataManager

    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         locationManager: CLLocationManager = CLLocationManager(),
         keychain: KeychainSwift = KeychainSwift(),
         coreDataManager: CoreDataManager = .shared,
         onSuccess: ( () -> Void)? = nil) {
        self.networkModel = networkModel
        self.locationManager = locationManager
        self.keychain = keychain
        self.coreDataManager = coreDataManager
        self.onSuccess = onSuccess
    }
    
    //MARK: Variables
    var heroes: [Hero] = []
    
    //MARK: Cycle of Life
    func vieWDidLoad() {
        checkLocationServices()
        checkLocationAuthorization()
        
        onSuccess?()
    }
        

    //MARK: MapKit
    func getHeroAnnotations(locations: [Location], completion: ([MKPointAnnotation]) -> Void) {
        
        var annotationsArray: [ MKPointAnnotation ] = []
//        getHeroesCoreData()
        
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitud , longitude: location.longitud )
            annotationsArray.append(annotations)
            print(annotations)
        }
        completion(annotationsArray)
    }
    
    //MARK: Locations
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            checkLocationAuthorization()
        } else {
            print("Location services are not enabled")
            }
        }
        
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            print("No access")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("Access")
//            mapView.showsUserLocation = true
        @unknown default:
            break
           }
////            case .notDetermined:
////                print("No access")
////            case .restricted:
////                print("No access")
////            case .denied:
////                print("No access")
////            case .authorizedAlways:
////                print("Access")
////                mapView?.showsUserLocation = true
////            case .authorizedWhenInUse:
////                print("Access")
////                mapView?.showsUserLocation = true
////            @unknown default:
////                break
//            default:
//                break
    }
}
