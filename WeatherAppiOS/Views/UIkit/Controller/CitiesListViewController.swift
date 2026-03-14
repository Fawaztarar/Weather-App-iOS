////
////  CitiesListViewController.swift
////  WeatherAppiOS
////
////  Created by Fawaz Tarar on 09/03/2026.
////

//
//
//
//
//  CitiesListViewController.swift
//

import UIKit
import SwiftData
import SwiftUI
import Combine

final class CitiesListViewController: UIViewController {

    private let vm: CitiesListVM
    private let container: AppContainer

    private let tableView = UITableView()

    private var savedCities: [SavedCity] = []

    private let context: ModelContext

    private let searchController = UISearchController(searchResultsController: nil)

    private var cancellables = Set<AnyCancellable>()
    
    private let cityService: SavedCityService

    init(vm: CitiesListVM, context: ModelContext, container: AppContainer, cityService: SavedCityService) {
        self.vm = vm
        self.context = context
        self.container = container
        self.cityService = cityService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private enum Section {
        case savedCities
        case searchResults
    }

    private var isSearching: Bool {
        !vm.searchText.isEmpty
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        
        

        setupTableView()
        configureSearch()
        bindViewModel()

        fetchCities()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCities()
    }

    // MARK: - Setup

    private func setupTableView() {

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(
            CityTableViewCell.self,
            forCellReuseIdentifier: CityTableViewCell.identifier
        )

        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        tableView.backgroundColor = .systemGroupedBackground

        tableView.contentInset = UIEdgeInsets(
            top: 20,
            left: 0,
            bottom: 20,
            right: 0
        )

        // prevents sideways bounce
        tableView.alwaysBounceHorizontal = false
    }

    // MARK: - Table Helpers

    private var savedCitiesCount: Int {
        savedCities.count
    }

    private var searchResultsCount: Int {

        if case .loaded(let results) = vm.searchState {
            return results.count
        }

        return 0
    }

    // MARK: - Data

    private func fetchCities() {

        let descriptor = FetchDescriptor<SavedCity>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )

        if let cities = try? context.fetch(descriptor) {

            savedCities = cities

            Task {
                await vm.loadWeather(for: cities)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Search

    private func configureSearch() {

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    // MARK: - Combine Binding

    private func bindViewModel() {

        vm.$searchState
            .combineLatest(vm.$searchText)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _, _ in

                guard let self else { return }

                self.tableView.reloadData()

            }
            .store(in: &cancellables)
    }
}

////////////////////////////////////////////////////////////

extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: Sections

    func numberOfSections(in tableView: UITableView) -> Int {

        if isSearching {
            return searchResultsCount
        } else {
            return savedCitiesCount
        }
    }

    // MARK: Rows

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    // MARK: Cell

//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(
//            withIdentifier: CityTableViewCell.identifier,
//            for: indexPath
//        ) as! CityTableViewCell
//
//        if isSearching {
//
//            if case .loaded(let results) = vm.searchState {
//
//                let result = results[indexPath.section]
//
//                let fakeCity = SavedCity(name: result.name)
//
//                cell.configure(city: fakeCity, weather: nil)
//            }
//
//        } else {
//
//            let city = savedCities[indexPath.section]
//
//            let weather = vm.weatherByCity[city.name]
//
//            cell.configure(city: city, weather: weather)
//        }
//
//        return cell
//    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.identifier,
            for: indexPath
        ) as! CityTableViewCell

        if isSearching {
            configureSearchCell(cell, indexPath: indexPath)
        } else {
            configureSavedCityCell(cell, indexPath: indexPath)
        }

        return cell
    }
    
    
    private func configureSavedCityCell(
        _ cell: CityTableViewCell,
        indexPath: IndexPath
    ) {
        let city = savedCities[indexPath.section]

        let weather = vm.weatherByCity[city.name]

        cell.configure(city: city, weather: weather)
    }
    
    private func configureSearchCell(
        _ cell: CityTableViewCell,
        indexPath: IndexPath
    ) {

        if case .loaded(let results) = vm.searchState {

            let result = results[indexPath.section]

            let fakeCity = SavedCity(name: result.name)

            cell.configure(city: fakeCity, weather: nil)
        }
    }
    
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        if isSearching { return nil }

        let city = savedCities[indexPath.section]

        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [weak self] _, _, completion in

            guard let self else { return }

            self.deleteCity(city, at: indexPath)

            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    private func deleteCity(_ city: SavedCity, at indexPath: IndexPath) {

        cityService.deleteCity(city)

        savedCities.remove(at: indexPath.section)

        tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
    }

    // MARK: Selection

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        let cityName: String

        if isSearching {

            if case .loaded(let results) = vm.searchState {

                cityName = results[indexPath.section].name

            } else {
                return
            }

        } else {

            cityName = savedCities[indexPath.section].name
        }

        let vm = container.makeWeatherDetailVM(city: cityName)

//        let detailView = WeatherDetailView(vm: vm)
//
//        let hosting = UIHostingController(rootView: detailView)
//
//        navigationController?.pushViewController(hosting, animated: true)
        
//        let service = SavedCityService(context: context)

        let detailVC = WeatherDetailViewController(
            vm: vm,
            saveService: cityService
        )
        
//        let detailVC = WeatherDetailViewController(vm: vm)

           navigationController?.pushViewController(detailVC, animated: true)
    }

    // MARK: Card spacing

    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {

        return 12
    }

    func tableView(_ tableView: UITableView,
                   viewForFooterInSection section: Int) -> UIView? {

        UIView()
    }
}

////////////////////////////////////////////////////////////

extension CitiesListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let text = searchController.searchBar.text ?? ""

        vm.searchText = text
    }
}
