//
//  GMapViewController.swift
//  MatZyp
//
//  Created by User on 2016. 11. 19..
//  Copyright © 2016년 CodersHigh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GMapViewController: UIViewController, GMSMapViewDelegate, UISearchBarDelegate, LocateOnTheMap, GMSAutocompleteFetcherDelegate, CLLocationManagerDelegate{

    var markers : [GMSMarker] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = self.tabBarController?.tabBar.items?[1].title
    }
    /**
     * Called when an autocomplete request returns an error.
     * @param error the error that was received.
     */
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                let newMark = GMSMarker()
                newMark.title = prediction.attributedFullText.string
                //self.resultArray.append(prediction.attributedFullText.string)
                self.resultArray.append(newMark)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        //print(resultArray)
    }
    
    @IBOutlet weak var myMap: GMSMapView!
    
    var searchResultController : SearchResultsController!
    var resultArray = [GMSMarker]()
    var gmsFetcher: GMSAutocompleteFetcher!
    let locationManager = CLLocationManager()
    
    @IBAction func searchWithAddress(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        self.present(searchController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.558814, longitude: 127.040152, zoom: 12)
        
        myMap.mapType = kGMSTypeNormal
        myMap.isMyLocationEnabled = true
        myMap.settings.myLocationButton = true
        myMap.delegate = self
        myMap.camera = camera
        
        //let currentLocation = CLLocationCoordinate2DMake(37.558814, 127.040152)
        //let marker = GMSMarker(position: currentLocation)
        //marker.title = "알촌"
        //marker.userData = [0,1]
        //marker.map = myMap
        
        let alchoneMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.alchone.latitude,longitude: dataCenter.alchone.longitude))
        alchoneMarker.title = "알촌"
        alchoneMarker.map = myMap
        alchoneMarker.userData = [7,1]
        
        let hanyangChoneMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.hanyangChone.latitude, longitude: dataCenter.hanyangChone.longitude))
        hanyangChoneMarker.title = "한양촌"
        hanyangChoneMarker.map = myMap
        hanyangChoneMarker.userData = [7,0]
        
        let daedoSikttangMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.daedosikttang.latitude, longitude: dataCenter.daedosikttang.longitude))
        daedoSikttangMarker.title = "대도식당"
        daedoSikttangMarker.map = myMap
        daedoSikttangMarker.userData = [7,2]
        
        let gwangMoonMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.gwangMoon.latitude, longitude: dataCenter.gwangMoon.longitude))
        gwangMoonMarker.title = "광화문집"
        gwangMoonMarker.map = myMap
        gwangMoonMarker.userData = [1,0]
        
        markers = [alchoneMarker, hanyangChoneMarker, daedoSikttangMarker, gwangMoonMarker]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
    }
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        
        
        DispatchQueue.main.async { () -> Void in
            
            //let position = CLLocationCoordinate2DMake(lat, lon)
            //let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 17)
            //self.googleMapsView.camera = camera
            self.myMap.camera = camera
            
            //marker.title = "Address : \(title)"
            //marker.map = self.googleMapsView
            
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let infoWindow = Bundle.main.loadNibNamed("CustomMarker", owner: self, options: nil)?.first as! CustomMarker
        
        infoWindow.label.text = marker.title
        let selectIndexSet = marker.userData as! Array<Int>
        let location = dataCenter.locations[selectIndexSet[0]] as Location
        //let matzyp = location.matzyps?[selectIndexSet[1]]
        guard let matzyp = location.matzyps?[selectIndexSet[1]] else{
            return infoWindow
        }
        infoWindow.image.image = matzyp.img
        infoWindow.rating.rating = (matzyp.rate)
        infoWindow.count.text = String(matzyp.reviews.count)
        
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        //let previous = storyboard.instantiateViewController(withIdentifier: "MatZypListView") as! MatZypListViewController
        let vc = storyboard.instantiateViewController(withIdentifier: "SegViewControllerID") as! SegViewController
        
        //let selectedIndex:Int = marker.userData as! Int
        //let location = dataCenter.locations[selectedIndex] as Location
        let selectIndexSet = marker.userData as! Array<Int>
        let setting = dataCenter.setting as Setting
        //let matzyp = location.matzyps?[selectedIndex]
        let location = dataCenter.locations[selectIndexSet[0]] as Location
        let matzyp = location.matzyps?[selectIndexSet[1]]
        
        //previous.location = location
        //previous.setting = setting
        vc.matzyp = matzyp
        vc.setting = setting
        //self.navigationController!.pushViewController(previous, animated: true)
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        let placeClient = GMSPlacesClient()
        //
        //
        //        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
        //           // NSError myerr = Error;
        //            print("Error @%",Error.self)
        //
        //            self.resultsArray.removeAll()
        //            if results == nil {
        //                return
        //            }
        //
        //            for result in results! {
        //                if let result = result as? GMSAutocompletePrediction {
        //                    self.resultsArray.append(result.attributedFullText.string)
        //                }
        //            }
        //
        //            self.searchResultController.reloadDataWithArray(self.resultsArray)
        //
        //        }
        
        
        self.resultArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        for m in markers {
            if m.title?.contains(searchText) == true{
                self.resultArray.append(m)
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - CLLocationManagerDelegate
//1
/*extension GMapViewController{
    // 2
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .authorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            myMap.isMyLocationEnabled = true
            myMap.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            myMap.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
}
*/
