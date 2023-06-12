//
//  ViewController.swift
//  FirstTable
//
//  Created by Harapriya on 25/04/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    private(set) var cityList: CityResponse?
    
}
//MARK: ViewLifeCycle:-
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GetCityList()
    }
}


//MARK: privat func
extension ViewController {
    private func setUpTableView() {
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        tableViewOutlet.estimatedRowHeight = 100
        tableViewOutlet.rowHeight = 100
    }
    
    private func GetCityList() {
        NetworkManager.getCityList() { response in
            self.cityList = response
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        }
    }
}

//MARK: tableViewDelegate and DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList?.response.data?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        let cityImg = (cityList?.response.data?[indexPath.row].cityImg)!
        if let imageUrl = URL(string: cityImg) {
            cell.cityImage.load(url: imageUrl)
        }
        cell.cityName.text = cityList?.response.data?[indexPath.row].cityName ?? ""
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PresentManager.jumpToVC(storyboard: "Main", from: self, withVCClass: ViewControllerDistrict.self, andData: cityList?.response.data?[indexPath.row].cityID)
    }
}



extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
