//
//  ViewController.swift
//  UI_SingularTest
//
//  Created by stephen on 8/6/17.
//  Copyright © 2017 Bai Cloud Tech Co. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pickerController: UIImagePickerController!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerController = UIImagePickerController()
        pickerController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func pickAnImageFromAlbum(){

        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
}

// MARK: Delegation Methods
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: UIImagePickerControllerDelegate Implmentation
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imagePickerView.image = image
            imagePickerView.sizeToFit()
            imagePickerView.contentMode = .scaleAspectFit
            
        }
        // need this or imagePickerView.image = image gives an error
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UINavigationControllerDelegate Implementaion
    
}
