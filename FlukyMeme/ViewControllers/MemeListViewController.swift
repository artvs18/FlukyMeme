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
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memeList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 5, dy: 5)
        cell.layer.mask = maskLayer
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)
        guard let cell = cell as? MemeCell else { return UITableViewCell() }
        guard let meme = memeList?.memes[indexPath.row] else { return UITableViewCell() }
        
        cell.configure(with: meme)
        
        
        cell.layer.borderColor = UIColor.label.cgColor
        cell.layer.borderWidth = 10
        
        print(indexPath.row)
        
        return cell
    }
}

extension MemeListViewController {
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let memeInfoVC = segue.destination as? MemeInfoViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        memeInfoVC?.memeDescription = memeList?.memes[indexPath.row].memeDescription
    }
    
    // MARK: - Network
    
    func fetchMemeList() {
        guard let url = URL(string: Link.memeListURL.rawValue) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            do {
                let decoder = JSONDecoder()
                self?.memeList = try decoder.decode(MemeList.self, from: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
