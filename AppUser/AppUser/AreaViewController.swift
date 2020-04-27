//
//  AreaViewController.swift
//  AppUser
//
//  Created by Gabriel Ferreira on 23/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class AreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var area : String?
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var protocolTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let protocolIdentifier : String = "ProtocolTableViewCell"
    let protList : [String] = ["Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí.", "Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí.", "Lorem Ipsum é que nem os comportamentos machistas dentro da criação. Você não presta atenção, só sai reproduzindo por aí.", "Um número inversamente proporcional a todas as piadas de cunho machista e sexual que elas escutam todos os dias. Sim, todos os dias."]
    let fluxList : [String] = ["Mas também, pra que levar a sério um texto que não diz nada ou mulheres que são minoria? Afinal, elas somam só 20% da criação.", "Mas também, pra que levar a sério um texto que não diz nada ou mulheres que são minoria? Afinal, elas somam só 20% da criação.", "Mas também, pra que levar a sério um texto que não diz nada ou mulheres que são minoria? Afinal, elas somam só 20% da criação.", "Um número inversamente proporcional a todas as piadas de cunho machista e sexual que elas escutam todos os dias. Sim, todos os dias."]
    var list : [String] = []
    
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.area
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "appBlue") ?? UIColor.black]
        if #available(iOS 13.0, *) {
            let textField = self.searchBar.searchTextField
            textField.backgroundColor = UIColor(named: "appYellow")
            
            textField.textColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            textField.tintColor = .black
        } else {
            let textField = self.searchBar.value(forKey: "searchField") as! UITextField
            
            textField.backgroundColor = UIColor(named: "appYellow")
            textField.textColor = .black
            textField.attributedPlaceholder = NSAttributedString(string: "Pesquisar", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            textField.tintColor = .black
        }
        self.searchBar.delegate = self
        
        definesPresentationContext = true
        self.segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "appColor") ?? UIColor.lightText], for: .selected)
        
        self.protocolTable.delegate = self
        self.protocolTable.dataSource = self
        self.protocolTable.indexDisplayMode = .alwaysHidden
        
        let nib = UINib.init(nibName: self.protocolIdentifier, bundle: nil)
        self.protocolTable.register(nib, forCellReuseIdentifier: self.protocolIdentifier)
        
        self.list = self.protList
    }
    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.protocolIdentifier, for: indexPath) as! ProtocolTableViewCell
        let actual = self.list[indexPath.row]

        cell.nameLabel.text = actual

        return cell
    }
    
    // MARK: - Segmented Control
    
    @IBAction func indexChanged(_ sender: Any) {
        self.list = self.getList()
        self.protocolTable.reloadData()
    }
    
    func getList() -> [String] {
        var actual : [String]
        
        switch self.segmented.selectedSegmentIndex {
        case 0:
            actual = self.protList
        case 1:
            actual = self.fluxList
        default:
            actual = self.protList
        }
        
        return actual
    }
    
    // MARK: - Search

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.list = getList()
        self.list = self.list.filter{ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: [NSString.CompareOptions.diacriticInsensitive, NSString.CompareOptions.caseInsensitive])
            return range.location != NSNotFound
        }
        if(self.list.count == 0){
            if searchText.count == 0 {
                self.list = self.getList()
            }
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.protocolTable.reloadData()
    }
    
    // MARK: - Navigation
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
