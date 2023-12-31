import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    override func loadView() {
        super.loadView()
        
        view = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        viewModel.loadWeatherList
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.weatherManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit - SearchVC")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension SearchViewController {
    func configure() {
        searchView.searchBar.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.changeUnitBtn.addTarget(self, action: #selector(changeUnit), for: .touchUpInside)
        searchView.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        searchView.collectionView.collectionViewLayout = layout()
    }
    
    func bind() {
        viewModel.reloadCollectionView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchView.refreshControl.endRefreshing()
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    

    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self else { return }
            viewModel.removeWeather(index: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func changeUnit() {
        viewModel.type = viewModel.type == .celsius ? .fahrenheit : .celsius
        viewModel.changeUnit
    }
    
    @objc func refresh() {
        searchView.refreshControl.beginRefreshing()
        viewModel.type = .celsius
        viewModel.loadWeatherList
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.textFieldText = searchBar.searchTextField.text
        viewModel.searchWeather
        searchBar.text = nil
    }
}

extension SearchViewController: WeatherViewModelDelegate {
    func didFetchWeather(weather: Weather) {
        viewModel.receiveWeather(weather: weather)
    }
    
    func didFailToFetchWeather(error: Error) {
        showAlert(title: "에러", message: error.localizedDescription)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCell.identifier,
            for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        let weatherInfo = viewModel.weatherList[indexPath.item]
        cell.configure(type: viewModel.type, info: weatherInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
