//
//  ViewController.swift
//  StenoAPICalling
//
//  Created by Arpit iOS Dev. on 07/06/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func sendRequestButtonTapped(_ sender: UIButton) {
        if let query = nameTextField.text, !query.isEmpty {
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StenoAPIViewController") as? StenoAPIViewController {
                vc.query = query
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        nameTextField.resignFirstResponder()
    }
}



