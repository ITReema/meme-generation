//
//  ViewController.swift
//  meme generation
//
//  Created by mac_os on 15/10/1440 AH.
//  Copyright © 1440 mac_os. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    var topText: String?
    var bottomText: String?
    var currentImage: UIImage!
    @IBOutlet var top: UITextField!
    @IBOutlet var buttom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meme"
        top.isHidden = true
        buttom.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
    }
    
    @objc func importPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true)
        
    }
    
    @objc func share(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        imageView.image = image
    }


    @IBAction func setTopText(_ sender: Any) {
        guard imageView.image != nil else {
            let noImageAC = UIAlertController(title: "No image found!", message: "Choose an image before trying to add text to it!", preferredStyle: .alert)
            noImageAC.addAction(UIAlertAction(title: "OK", style: .default))
            present(noImageAC, animated: true)
            
            return
        }
        top.isHidden = false
        let topTextAC = UIAlertController(title: "Top text", message: "Insert a text at the top of the meme", preferredStyle: .alert)
        topTextAC.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak topTextAC] _ in
            guard let topText = topTextAC?.textFields?[0].text else { return }
            self?.topText = topText
            self?.top.text = topText
        }
        
        topTextAC.addAction(submitAction)
        present(topTextAC, animated: true)
    }
    
    @IBAction func setBottomText(_ sender: Any) {
        guard imageView.image != nil else {
            let noImageAC = UIAlertController(title: "No image found!", message: "Choose an image before trying to add text to it!", preferredStyle: .alert)
            noImageAC.addAction(UIAlertAction(title: "OK", style: .default))
            present(noImageAC, animated: true)
            
            return
        }
        
        buttom.isHidden = false
        let bottomTextAC = UIAlertController(title: "Bottom text", message: "Insert a text at the bottom of the meme", preferredStyle: .alert)
        bottomTextAC.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak bottomTextAC] _ in
            guard let bottomText = bottomTextAC?.textFields?[0].text else { return }
            self?.bottomText = bottomText
            self?.buttom.text = bottomText
            
        }
        
        bottomTextAC.addAction(submitAction)
        present(bottomTextAC, animated: true)
    }
    
}

