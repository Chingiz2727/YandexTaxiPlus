//
//  ExtenSionAutoComplete.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 15.10.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import GooglePlaces
extension ChoosePlaceTableViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        searchController?.searchBar.text = place.name
        print(place.coordinate.latitude)
        tagItem(text: place.name, lang: place.coordinate.longitude, lat: place.coordinate.latitude)
    }
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        navigationController?.popToRootViewController(animated: true)

    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        navigationController?.popToRootViewController(animated: true)

    }}
