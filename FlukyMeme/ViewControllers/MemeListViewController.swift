//
//  MemeListViewController.swift
//  FlukyMeme
//
//  Created by Artemy Volkov on 09.11.2022.
//

import UIKit

class MemeListViewController: UITableViewController {
    private var memeList: MemeList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMemeList()
    }
    
    @IBAction func moreFlukyMemesButtonTapped(_ sender: UIBarButtonItem) {
        fetchMemeList()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memeList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 5, dy: 5)
        cell.layer.mask = maskLayer
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)
        guard let cell = cell as? MemeCell else { return UITableViewCell() }
        guard let meme = memeList?.memes[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: meme)        
        return cell
    }
}

extension MemeListViewController {
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeInfoVC = segue.destination as? MemeInfoViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        memeInfoVC?.memeDescription = memeList?.memes[indexPath.row].memeDescription
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Network
    
    func fetchMemeList() {
        NetworkManager.shared.fetchMemeList(from: Link.memeListURL.rawValue) { [weak self] result in
            switch result {
            case .success(let memeList):
                self?.memeList = memeList
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
