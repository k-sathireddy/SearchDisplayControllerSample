//
//  ViewController.swift
//  searchBarSample


import UIKit

class ViewController: UIViewController,UISearchDisplayDelegate, UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var countrySerachBar: UISearchBar!
    
    var marrCountryList = [String]()
    var marrFilteredCountryList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.countriesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        marrCountryList = ["USA", "Bahamas", "Brazil", "Canada", "Republic of China", "Cuba", "Egypt", "Fiji", "France", "Germany", "Iceland", "India", "Indonesia", "Jamaica", "Kenya", "Madagascar", "Mexico", "Nepal", "Oman", "Pakistan", "Poland", "Singapore", "Somalia", "Switzerland", "Turkey", "UAE", "Vatican City"]
        self.countriesTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
         UIView.animate(withDuration: 1.0, animations: { () -> Void in }) { (completed) -> Void in
         self.countrySerachBar.becomeFirstResponder()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.marrFilteredCountryList.count
        } else {
            return self.marrCountryList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellCountry = self.countriesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var countryName : String!
        if tableView == self.searchDisplayController!.searchResultsTableView {
            countryName = marrFilteredCountryList[(indexPath as NSIndexPath).row]
        } else {
            countryName = marrCountryList[(indexPath as NSIndexPath).row]
        }
        cellCountry.textLabel?.text = countryName
        return cellCountry
    }
   
    func filterTableViewForEnterText(_ searchText: String) {
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchText)
        let array = (self.marrCountryList as NSArray).filtered(using: searchPredicate)
        self.marrFilteredCountryList = array as! [String]
        self.countriesTableView.reloadData()
    }
    
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        self.filterTableViewForEnterText(searchString!)
        return true
    }
    
    
    func searchDisplayController(_ controller: UISearchDisplayController,
                                 shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterTableViewForEnterText(self.searchDisplayController!.searchBar.text!)
        return true
    }

}

