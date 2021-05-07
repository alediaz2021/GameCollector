//
//  ViewController.swift
//  GameCollector
//
//  Created by Alejandro Diaz Sotolongo on 4/28/21.
//  Copyright © 2021 aaaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview1: UITableView!
    
    var games : [Game] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cel = UITableViewCell()
        let game = games[indexPath.row]
        cel.textLabel?.text = game.title
        cel.imageView?.image = UIImage(data : game.image!)
        return cel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview1.delegate = self
        tableview1.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            games = try context2.fetch(Game.fetchRequest())
            tableview1.reloadData()
        } catch{
            
        }
    }
    //lo q seleccionas en el table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        performSegue(withIdentifier: "gameSeque", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVc = segue.destination as! PlusViewController
        nextVc.game = sender as? Game
    }


}

