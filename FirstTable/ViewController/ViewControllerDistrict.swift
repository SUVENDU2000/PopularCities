//
//  ViewControllerDistrict.swift
//  FirstTable
//
//  Created by Harapriya on 25/04/23.
//

import UIKit

class ViewControllerDistrict: UIViewController, UITableViewDelegate, UITableViewDataSource, DataReceiver {
    
    var receivedData: Any?
    private(set) var localityList: LocalityResponse?
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localityList?.response.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableViewOutlet.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = localityList?.response.data[indexPath.row].localityName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PresentManager.jumpToVC(storyboard: "Mian", from: self, withVCClass: ShowImageViewController.self, andData: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cityId = receivedData as? Int else { return }
        getLocalityId(cityId: cityId)
        tableViewOutlet.reloadData()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
    }
    
    func getLocalityId(cityId: Int) {
        NetworkManager.getLocalityList(cityId: cityId) { response in
            self.localityList = response
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        }
    }
    
    
    @IBAction func didTappedBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
