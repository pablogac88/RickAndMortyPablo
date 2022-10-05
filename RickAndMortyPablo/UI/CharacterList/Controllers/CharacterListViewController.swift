//
//  ViewController.swift
//  RickAndMortyPablo
//
//  Created by Pablo García-Alcaide on 4/10/22.
//
import UIKit
import SwinjectStoryboard

protocol CharacterListViewProtocol: AnyObject {
    func reloadView()
}
    
class CharacterListViewController: UIViewController {
    
    enum TableSection: Int {
        case characterList
        case loader
    }
    
    var viewModel: CharacterListViewModelProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    private let pageLimit = 20
    private var currentLastId: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        viewModel?.getCharacters()
    }
    
    private func configureViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCell.nib,
                           forCellReuseIdentifier: CharacterCell.reuseIdentifier)
    }
}

extension CharacterListViewController: CharacterListViewProtocol {
    func reloadView() {
        tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 2
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = TableSection(rawValue: indexPath.section) else { return 0 }
        return section == .loader ? 1 : 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .characterList:
            return viewModel?.characters.count ?? 0
        case .loader:
            return (viewModel?.characters.count ?? 0) >= pageLimit ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        if section == .loader {
            return UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        guard
            var character = viewModel?.characters[indexPath.row],
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reuseIdentifier) as? CharacterCell
        else {
            return UITableViewCell()
        }
        cell.delegate = self
        if let favouritesList = viewModel?.favouritesList {
            character.isFavourite = favouritesList.contains("\(character.idCharacter)")
        }
        
        cell.configure(with: character)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(rowSelected: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
       
        if section == .loader {
            viewModel?.getCharacters()
        }
    }
}

extension CharacterListViewController {
    // MARK: - Navigation
    func navigateToDetail(rowSelected: Int) {
        guard let character = viewModel?.characters[rowSelected] else { return }
        
        let storyboard = SwinjectStoryboard.create(name: NavigationScene.characterDetail.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? CharacterDetailViewController else { return }
        viewController.viewModel?.character = character
        navigationController?.present(viewController, animated: true)
    }
}

extension CharacterListViewController: CharacterCellDelegate {
    func checkFavouriteCharacter(idCharacter: String, setFavourite: Bool) {
        
        if let row = viewModel?.favouritesList.firstIndex(where: {$0 == idCharacter}) {
            if var characterModified = viewModel?.characters[row] {
                characterModified.isFavourite = setFavourite
                viewModel?.characters[row] = characterModified
                
                if setFavourite {
                    viewModel?.favouritesList.append(idCharacter)
                } else {
                    viewModel?.favouritesList.remove(at: row)
                }
            }
        } else {
            viewModel?.favouritesList.append(idCharacter)
        }
        DispatchQueue.main.async {
            UserDefaults.standard.removeFavourites()
            UserDefaults.standard.set(self.viewModel?.favouritesList ?? [])
        }
    }
}
