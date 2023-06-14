//
//  SearchVC.swift
//  Test
//
//  Created by Deepak on 14/06/23.
//

protocol SearchVCDelegate {
    
    func selectedDict(weatherInfoViewModel:WeatherInfoViewModel)
}

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var delegate: SearchVCDelegate?
    lazy var viewModel = {
        ViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initViewModel(searchString:String) {
        
        //MARK: Check Internet Connection
        InternetManager.isUnreachable { _ in
            self.showAlert(title: "Alert", message: "Please check your internet connection and try again.")
            return
        }
        let dict = ["q":searchString,"appid":"626230428842e632fc51d71887830d69"]

        viewModel.getWeatherInfo(dict: dict, completion: { success, model, error in
            
            if success, let response = model{
                print(response)
                self.delegate?.selectedDict(weatherInfoViewModel: response)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                print(error!)
                 DispatchQueue.main.async {
                     self.showAlert(title: "Alert", message: "Json not coming proper format")
                }
            }
        })
    }
}

extension SearchVC: UISearchBarDelegate
{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
  }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        if searchBar.text!.count > 0{
            self.initViewModel(searchString: searchBar.text!)
        }
    }
}


