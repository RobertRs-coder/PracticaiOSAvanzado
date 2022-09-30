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

    var onError: ((String) -> Void)?
    var onSuccess: (() -> Void)?
    
    init(networkModel: NetworkModel = NetworkModel(),
         locationManager: CLLocationManager = CLLocationManager(),
         keychain: KeychainSwift = KeychainSwift(),
         coreDataManager: CoreDataManager = .shared,
         onError: ( (String) -> Void)? = nil,
         onSuccess: ( () -> Void)? = nil) {
        self.networkModel = networkModel
        self.locationManager = locationManager
        self.keychain = keychain
        self.coreDataManager = coreDataManager
        self.onError = onError
        self.onSuccess = onSuccess
    }
    
    //MARK: Variables
    var heroes: [Hero] = []
    
    //MARK: Cycle of Life
    func vieWDidLoad() {

    }
        

    //MARK: MapKit
    func getHeroesAnnotations(completion: ([MKPointAnnotation]) -> Void) {
        
        var annotationsArray: [ MKPointAnnotation ] = []
//        getHeroesCoreData()
        
        for hero in heroes {
            let annotations = MKPointAnnotation()
            annotations.title = hero.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: hero.latitud ?? 0.0, longitude: hero.longitud ?? 0.0)
            annotationsArray.append(annotations)
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
