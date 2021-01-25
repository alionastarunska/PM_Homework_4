//
//  DetailsViewController.swift
//  Homework_4
//
//  Created by Aliona Starunska on 24.01.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let weatherService = ServiceFactory.shared.makeWeatherService()

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private var city: City? {
        didSet {
            generateDataSource()
        }
    }
    private var forecast: [WeatherDetails] {
        return city?.forecastWeather ?? []
    }
    private var data: [String: [WeatherDetails]] = [:]
    private var daysOrder: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupBackground()
        setupTableView()
        loadForecast()
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        tableView.register(ForecastCell.self)
    }

    private func configureView() {
        guard let city = city else { return }
        nameLabel.text = city.name
        typeLabel.text = city.todayWeather?.weather.first?.main.capitalized
        if let temperature = city.todayWeather?.main.temperature {
            temperatureLabel.text = (temperature > .zero ? "+" : "") + String(format: "%.1f", temperature) + "°C"
        }
        if let temperature = city.todayWeather?.main.feelsLike {
            feelsLikeLabel.text = "Feels like: " + (temperature > .zero ? "+" : "") + String(format: "%.1f", temperature) + "°C"
        }
        descriptionLabel.text = city.todayWeather?.weather.first?.description.capitalized
    }
    
    private func loadForecast() {
        guard let city = city else { return }
        startLoading()
        weatherService.getForecastWeather(for: city) { [weak self] (city, error) in
            self?.endLoading()
            self?.city = city
            self?.configureView()
            self?.tableView.reloadData()
            if let error = error {
                self?.handle(error: error)
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
    
    private func generateDataSource() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        data.removeAll()
        daysOrder.removeAll()
        for weather in forecast {
            guard let date = weather.date else { continue }
            let day = dateformatter.string(from: date)
            if data[day] == nil {
                data[day] = []
                daysOrder.append(day)
            }
            data[day]?.append(weather)
        }
    }
}

// MARK: - Initialization

extension DetailsViewController {
    func set(city: City) {
        self.city = city
    }
}

// MARK: - TableView

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return daysOrder.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let day = daysOrder[section]
        return data[day]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as? ForecastCell
        let day = daysOrder[indexPath.section]
        if let weather = data[day]?[indexPath.row] {
            cell?.configure(with: weather)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return daysOrder[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = .white
    }
}

// MARK: - LoadableViewController

extension DetailsViewController: LoadableViewController {
    var activityView: UIActivityIndicatorView {
        return activityIndicator
    }
}

// MARK: - Constants
fileprivate extension TimeInterval {
    static var errorLabelTime: TimeInterval { return 5.0 }
}
