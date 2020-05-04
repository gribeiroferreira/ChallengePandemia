//
//  EtapasViewController.swift
//  AppUser
//
//  Created by Luma Gabino Vasconcelos on 27/04/20.
//  Copyright © 2020 Gabriel Ferreira. All rights reserved.
//

import UIKit

class EtapasViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let etapaCellIdentifier: String = "TituloEtapaViewCell"
    var stageTitles: [String] = ["Início", "Sinais de gravidade?", "Indicar Isolamento Domiciliar", "Síndrome Respiratória Aguda Grave", "Indicação para internação?", "Negativo - Lista de Procedimentos", "Positivo - Lista de Procedimentos", "Acompanhamento Leito Clínico", "Notificar e Coletar Exames", "Acompanhamento Leito de Terapia", "Notificar e Coletar Exames"]
    let appBlue = UIColor(named: "appBlue")
    let appColor = UIColor(named: "appColor")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setupAccessibility()
        
        let nib = UINib.init(nibName: self.etapaCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.etapaCellIdentifier)
        
        self.setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Etapas"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "appBlue")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "appColor")
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: self.appColor ?? UIColor.blue]
    }
    
    private func setupAccessibility() {
        let titleFont = UIFont(name: "SFProDisplay-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)

        self.titleLabel.dynamicFont = titleFont
        
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        self.titleLabel.font = fontMetrics.scaledFont(for: titleFont, maximumPointSize: 40.0)
    }

}


// MARK: - Table view extension
extension EtapasViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stageTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.etapaCellIdentifier, for: indexPath) as! TituloEtapaViewCell
        let stage = self.stageTitles[indexPath.row]
        cell.titleLabel.text = stage

        if indexPath.row == self.stageTitles.count-1 {
            cell.lineView.isHidden = true
            
            //Teste identificação da etapa atual
            cell.circleView.image = UIImage(named: "stageSelected")
            
            //Teste deixar fonte regular
            let titleFont = UIFont(name: "SFProDisplay-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18)
            cell.titleLabel.dynamicFont = titleFont
        }
        
        
        return cell
    }
    
    
}
