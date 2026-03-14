//
//  WeatherDetailViewController.swift
//  WeatherAppiOS
//
//  Created by Fawaz Tarar on 11/03/2026.
//

import UIKit


//WeatherDetailViewController
//1️⃣ Create UICollectionView
//2️⃣ Create Layout
//3️⃣ Register Cells
//4️⃣ Create DiffableDataSource
//5️⃣ Apply Snapshot

final class WeatherDetailViewController: UIViewController {
    
    private let vm: WeatherDetailVM
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, WeatherDetailItem>!
    
    private let saveButton = FloatingActionButton()
    
    private let saveService: SavedCityService
    
    
    
    init(vm: WeatherDetailVM, saveService: SavedCityService) {
        self.vm = vm
        self.saveService = saveService
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViews()
        setupConstraints()
        setupDataSource()
        setupSaveButton()
        
        loadWeather()
    }
    
    private func loadWeather() {
        Task {
            await vm.fetch()
            
            switch vm.state {
            case .loaded(let detail):
                applySnapshot(detail)
                
            case .failed(let error):
                showError(error)
                
            case .loading:
                showLoading()
                
            default:
                break
            }
        }
    }
    
    private func showLoading() {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    //
    //    UICollectionView
    //    │
    //    ├── Section 0
    //    │     Hero Weather
    //    │
    //    ├── Section 1
    //    │     Hourly Forecast
    //    │     (horizontal scroll)
    //    │
    //    └── Section 2
    //          Daily Forecast
    //          (vertical list)
    
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    
    private func setupConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: WeatherDetailLayout.createLayout()
        )
        
        registerCell()
    }
    
    private func setupDataSource() {
        configureDataSource()
    }
    
    
    
    
    
    private func registerCell() {
        collectionView.register(HeroWeatherCell.self, forCellWithReuseIdentifier: HeroWeatherCell.identifier)
        
        collectionView.register(HourlyWeatherCell.self, forCellWithReuseIdentifier: HourlyWeatherCell.identifier)
        
        
        collectionView.register(DailyWeatherCell.self, forCellWithReuseIdentifier: DailyWeatherCell.identifier)
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, WeatherDetailItem>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            
            switch item {
                
            case .hero(let weather):
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: HeroWeatherCell.identifier,
                    for: indexPath
                ) as! HeroWeatherCell
                
                cell.configure(with: weather)
                
                return cell
                
            case .hourly(let hourly):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCell.identifier, for: indexPath) as! HourlyWeatherCell
                
                cell.configure(with: hourly)
                
                return cell
                
            case .daily(let daily):
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCell.identifier, for: indexPath) as! DailyWeatherCell
                
                cell.configure(with: daily)
                
                return cell
            }
        }
    }
    
    private func applySnapshot(_ detail: WeatherDetail) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherDetailItem>()
        
        snapshot.appendSections([.heroWeather, .hourlyForecast, .dailyForecast])
        
        snapshot.appendItems(
            [.hero(detail.weather)],
            toSection: .heroWeather
        )
        
        snapshot.appendItems(
            detail.hourly.map { .hourly($0) },
            toSection: .hourlyForecast
        )
        
        
        snapshot.appendItems(
            detail.daily.map { .daily($0) },
            toSection: .dailyForecast
        )
        
        
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    
    
    private func setupSaveButton() {
        
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        saveButton.addTarget(self, action: #selector(saveCityTapped), for: .touchUpInside)
    }
    
    @objc private func saveCityTapped() {
        print("Save city tapped")
        
        // here you would call your save service
         saveService.saveCity(name: vm.cityName)
        
        navigationController?.popViewController(animated: true)
    }
    
}
