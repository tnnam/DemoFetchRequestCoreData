//
//  ViewController.swift
//  DemoFetchRequestCoreData
//
//  Created by Tran Ngoc Nam on 5/9/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure() {
        guard index != nil else {  return  }
        nameTextField.text = DataService.shared.people[index ?? 0].name
        ageTextField.text = String(DataService.shared.people[index ?? 0].age)
        photoImageView.image = DataService.shared.people[index ?? 0].photo as? UIImage
    }
    
    // Hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        return true
    }
    
    // MARK: Select Image
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        let entity = User(context: AppDelegate.context)
        guard let name = nameTextField.text else { return }
        guard let age = Int(ageTextField.text ?? "") else { return }
        guard let photo = photoImageView.image else { return }
        entity.name = name
        entity.photo = photo
        entity.age = Int32(age)
        // save data
        DataService.shared.saveDataToCoreData()
        // pop về
        navigationController?.popViewController(animated: true)
    }
    
}

