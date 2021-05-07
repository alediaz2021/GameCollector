//
//  PlusViewController.swift
//  GameCollector
//
//  Created by Alejandro Diaz Sotolongo on 5/3/21.
//  Copyright © 2021 aaaa. All rights reserved.
//

import UIKit

class PlusViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var addtexField: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deletebutton: UIButton!
    var imagePicker = UIImagePickerController()
    var game : Game? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if game != nil {
            image.image = UIImage(data: game!.image as! Data)
            addtexField.text = game!.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deletebutton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    
    /*@IBAction func photosTap(_ sender: Any) {
        print("okook")
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }*/
    

    @IBAction func photoTap(_ sender: Any) {
        print("okook")
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTap(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func addButton(_ sender: Any) {
        if game != nil{
            game!.title = addtexField.text
            game!.image = image.image!.pngData()
            
        } else {
            let context2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let game = Game(context: context2)
            game.title = addtexField.text
            game.image = image.image!.pngData()
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let context2 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context2.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         let images = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
         
         image.image = images
         
         imagePicker.dismiss(animated: true, completion: nil)
     }
    
    
}
