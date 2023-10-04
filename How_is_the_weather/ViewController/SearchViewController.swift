import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let searchViewModel = SearchViewModel()
    private let weatherViewModel = WeatherViewModel()
    override func loadView() {
        super.loadView()
        
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bind()
        searchViewModel.loadWeatherList

        weatherViewModel.fetchWeatherForCity("Seoul")

    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        searchViewModel.manager.delegate = self

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
        weatherViewModel.delegate = self
        searchView.searchBar.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.collectionViewLayout = layout()
    }
    
    func bind() {
        searchViewModel.reloadCollectionView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, _ in
            guard let self = self else { return }
            searchViewModel.removeWeather(index: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.textFieldText = searchBar.searchTextField.text
        searchViewModel.searchWeather
        searchBar.text = nil
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SearchViewController: WeatherViewModelDelegate {
    func didFetchWeather(weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let weatherID = self.weatherViewModel.weatherID {
                print(weatherID)
                let bgColor = BackgroundColor(weatherID: weatherID)
                let gradientView = AnimatedGradientView(frame: self.view.bounds)
                gradientView.setGradient(startColor: bgColor.startColor, endColor: UIColor.white)
                self.view.insertSubview(gradientView, at: 0)
            }
        }
    }

    func didFailToFetchWeather(error: Error) {
        showAlert(title: "에러", message: error.localizedDescription)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCell.identifier,
            for: indexPath) as? WeatherCell else { return UICollectionViewCell() }
        let weatherInfo = searchViewModel.weatherList[indexPath.item]
        cell.configure(info: weatherInfo)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
