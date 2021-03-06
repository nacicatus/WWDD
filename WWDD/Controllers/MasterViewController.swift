//
//  MasterViewController.swift
//  WWDD
//
//  Created by Yajnavalkya on 2020. 04. 21..
//  Copyright © 2020. Yajnavalkya. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController  {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchFooter: SearchFooter!
    @IBOutlet var searchFooterBottomConstraint: NSLayoutConstraint!
    
    var symptoms: [Symptom] = []
    var filteredSymptoms : [Symptom] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        symptoms = Symptom.symptoms()
    

        // Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //  Search Bar Text
        searchController.searchBar.placeholder = "Search symptoms"
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.font = textFieldInsideSearchBar?.font?.withSize(12)
        textFieldInsideSearchBar?.textColor = UIColor.white
    

        // 6 Scope Buttons
        searchController.searchBar.setScopeBarButtonTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 0.1)], for: .normal)
        searchController.searchBar.scopeButtonTitles = Symptom.System.allCases.map { $0.rawValue }
        searchController.searchBar.showsScopeBar = false

        
        // Keyboard handling
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main) { (notification) in self.handleKeyboard(notification: notification )}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    
//    Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowDetailSegue",
            let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? DetailViewController
            else {
                return
        }
        
        let symptom: Symptom
        if isFiltering {
            symptom = filteredSymptoms[indexPath.row]
        } else {
            symptom = symptoms[indexPath.row]
        }
        detailViewController.symp = symptom
    }
    
    
//    Searching functions
    
    var isSearchBarEmpty : Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    
    // Filter function
    func filterContentForSearchText(_ searchText: String, system: Symptom.System? = nil) {
        filteredSymptoms = symptoms.filter { (symptom: Symptom) -> Bool in
            
            let doesSystemMatch = system == .all || symptom.system == system
            
            if isSearchBarEmpty {
                return doesSystemMatch
            } else {
                return doesSystemMatch && symptom.name.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func handleKeyboard(notification: Notification) {
        // 1
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            searchFooterBottomConstraint.constant = 0
            view.layoutIfNeeded()
            return
        }
        
        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
                return
        }
        // 2
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.searchFooterBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        })
    }
}

extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            searchFooter.setIsFilteringToShow(filteredItemCount: filteredSymptoms.count, of: symptoms.count)
            return filteredSymptoms.count
        }
        searchFooter.setNotFiltering()
        return symptoms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let symptom: Symptom
        if isFiltering {
            symptom = filteredSymptoms[indexPath.row]
        } else {
            symptom = symptoms[indexPath.row]
        }
        cell.textLabel?.text = symptom.name
        cell.detailTextLabel?.text = symptom.system.rawValue
        return cell
    }
}

extension MasterViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let sys = Symptom.System(rawValue: searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])
        filterContentForSearchText(searchBar.text!, system: sys)
        
    }
}

extension MasterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let sys = Symptom.System(rawValue: searchBar.scopeButtonTitles![selectedScope])
        filterContentForSearchText(searchBar.text!, system: sys)
    }
}

