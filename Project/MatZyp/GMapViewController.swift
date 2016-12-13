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
        
        let robotgimbapMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.robotkimbab.latitude, longitude: dataCenter.robotkimbab.longitude))
        robotgimbapMarker.title = "로봇김밥"
        robotgimbapMarker.map = myMap
        robotgimbapMarker.userData = [0,0]
        
        let sonyeonsanhoiMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.sonyeonsanghoi.latitude, longitude: dataCenter.sonyeonsanghoi.longitude))
        sonyeonsanhoiMarker.title = "소년상회"
        sonyeonsanhoiMarker.map = myMap
        sonyeonsanhoiMarker.userData = [0,1]
        
        let daegalzipMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.daegalzip.latitude, longitude: dataCenter.daegalzip.longitude))
        daegalzipMarker.title = "대갈집"
        daegalzipMarker.map = myMap
        daegalzipMarker.userData = [0,2]
        
        let samsungredMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.samsungred.latitude, longitude: dataCenter.samsungred.longitude))
        samsungredMarker.title = "삼성빨간양념"
        samsungredMarker.map = myMap
        samsungredMarker.userData = [1,1]
        
        let sinanchonMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.sinanchon.latitude, longitude: dataCenter.sinanchon.longitude))
        sinanchonMarker.title = "신안촌"
        sinanchonMarker.map = myMap
        sinanchonMarker.userData = [1,2]
        
        let surakioMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.surakio.latitude, longitude: dataCenter.surakio.longitude))
        surakioMarker.title = "수락이오냉면"
        surakioMarker.map = myMap
        surakioMarker.userData = [2,0]
        
        let terminiMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.termini.latitude, longitude: dataCenter.termini.longitude))
        terminiMarker.title = "테르미니"
        terminiMarker.map = myMap
        terminiMarker.userData = [2,1]
        
        let chammannaMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.chammanna.latitude, longitude: dataCenter.chammanna.longitude))
        chammannaMarker.title = "참만나(노원)"
        chammannaMarker.map = myMap
        chammannaMarker.userData = [2,2]
        
        let haemateaMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.haematea.latitude, longitude: dataCenter.haematea.longitude))
        haemateaMarker.title = "해마티룸"
        haemateaMarker.map = myMap
        haemateaMarker.userData = [3,0]
        
        let bomgasMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.bomgas.latitude, longitude: dataCenter.bomgas.longitude))
        bomgasMarker.title = "봄까스"
        bomgasMarker.map = myMap
        bomgasMarker.userData = [3,1]
        
        let sogumiMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.sogumi.latitude, longitude: dataCenter.sogumi.longitude))
        sogumiMarker.title = "소구미"
        sogumiMarker.map = myMap
        sogumiMarker.userData = [3,2]
        
        let hamnamMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.hamnam.latitude, longitude: dataCenter.hamnam.longitude))
        hamnamMarker.title = "함남곱창"
        hamnamMarker.map = myMap
        hamnamMarker.userData = [4,0]
        
        let northseaMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.northsea.latitude, longitude: dataCenter.northsea.longitude))
        northseaMarker.title = "북해빙수"
        northseaMarker.map = myMap
        northseaMarker.userData = [4,1]
        
        let cryroadMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.cryroad.latitude, longitude: dataCenter.cryroad.longitude))
        cryroadMarker.title = "크라이로드노이"
        cryroadMarker.map = myMap
        cryroadMarker.userData = [4,2]
        
        let redsunMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.redsun.latitude, longitude: dataCenter.redsun.longitude))
        redsunMarker.title = "레드썬"
        redsunMarker.map = myMap
        redsunMarker.userData = [5,0]
        
        let mpizzaMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.mpizza.latitude, longitude: dataCenter.mpizza.longitude))
        mpizzaMarker.title = "명동피자"
        mpizzaMarker.map = myMap
        mpizzaMarker.userData = [5,1]
        
        let ioknyeoMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.ioknyeo.latitude, longitude: dataCenter.ioknyeo.longitude))
        ioknyeoMarker.title = "명동피자"
        ioknyeoMarker.map = myMap
        ioknyeoMarker.userData = [6,0]
        
        let tianpanMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: dataCenter.tianpan.latitude, longitude: dataCenter.tianpan.longitude))
        tianpanMarker.title = "명동피자"
        tianpanMarker.map = myMap
        tianpanMarker.userData = [6,1]
        
        markers = [alchoneMarker, hanyangChoneMarker, daedoSikttangMarker, gwangMoonMarker, robotgimbapMarker, sonyeonsanhoiMarker, daegalzipMarker, samsungredMarker, sinanchonMarker, surakioMarker, terminiMarker, chammannaMarker, haemateaMarker, bomgasMarker, sogumiMarker, hamnamMarker, northseaMarker, cryroadMarker, redsunMarker, mpizzaMarker, ioknyeoMarker, tianpanMarker]
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
        infoWindow.image.image = matzyp.menus?[0].img
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
