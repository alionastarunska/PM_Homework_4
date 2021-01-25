//
//  ListViewController.swift
//  Homework_4
//
//  Created by Aliona Starunska on 24.01.2021.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let cityService = ServiceFactory.shared.makeCityService()
    private let weatherService = ServiceFactory.shared.makeWeatherService()
    private var cities: [City] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        reloadTableView()
        loadCityData()
        setupBackground()
    }
    
    // MARK: - Private
    
    private func loadCityData() {
        let group = DispatchGroup()
        startLoading()
        cities.forEach({
            group.enter()
            weatherService.getWeather(for: $0) { [weak self] (city, error) in
                group.leave()
                if let error = error {
                    self?.handle(error: error)
                    return
                }
                if let index = self?.cities.firstIndex(of: city) {
                    self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
                }
            }
        })
        group.notify(queue: .main) {
            self.endLoading()
        }
    }
    
    private func reloadTableView() {
        cities = cityService.getCities()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(CityCell.self)
    }
    
    private func handleSelection(of city: City) {
        guard let detailsViewController: DetailsViewController = storyboard?.get() else { return }
        detailsViewController.set(city: city)
        present(detailsViewController, animated: true)
    }
    
    private func didType(name: String) {
        guard !name.isEmpty else { return }
        if let city = cityService.addCity(with: name) {
            startLoading()
            weatherService.getWeather(for: city) { [weak self] (_, error) in
                self?.endLoading()
                if let error = error {
                    self?.cityService.remove(city: city)
                    self?.handle(error: error)
                    return
                } else {
                    self?.reloadTableView()
                }
            }
        }
    }
    
    private func handle(error: Error) {
        errorLabel.text = error.localizedDescription
        errorLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .errorLabelTime) {
            self.errorLabel.isHidden = true
        }
    }
    
    private func setupBackground() {
        backgroundImageView.image = Date().isDarkTime ? Assets.dark : Assets.light
    }
}

// MARK: - TableView

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseIdentifier, for: indexPath) as? CityCell
        cell?.configure(with: cities[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard cities.indices.contains(indexPath.row) else { return }
        handleSelection(of: cities[indexPath.row])
    }
}

// MARK: - TextField

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let name = textField.text {
            didType(name: name)
            textField.text = ""
        }
        return true
    }
}

// MARK: - LoadableViewController

extension ListViewController: LoadableViewController {
    var activityView: UIActivityIndicatorView {
        return activityIndicator
    }
}

// MARK: - Constants
fileprivate extension TimeInterval {
    static var errorLabelTime: TimeInterval { return 5.0 }
}
