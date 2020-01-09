//
//  ViewController.swift
//  app-list
//
//  Created by Jonathan Macias on 1/7/20.
//  Copyright © 2020 jonathan. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating{
    
    
    var appsFiltered = [ Aplication ]()
    var searchActive: Bool = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let netWorking = Networking()
    
    var appsList: [Aplication] = []

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var colecctionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getAppsList()
        
        
        colecctionView.delegate = self
        colecctionView.dataSource = self
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar app"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.viewTop.addSubview(searchController.searchBar)
        
        
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (context) in
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, windowScene.activationState == .foregroundActive, let _ = windowScene.windows.first else { return }

            switch windowScene.interfaceOrientation {
            case .unknown:
                print("unknown")

            case .portrait:
                print("portrait")

            case .portraitUpsideDown:
                print("portraitUpsideDown")

            case .landscapeLeft:
                print("")
                
            case .landscapeRight:
                print("landScape right")

            @unknown default:
                print("default")
            }
            
            
            
        }) { (error) in
            print(error)
        }
    
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        // In this function is the code you must implement to your code project if you want to change size of Collection view
        let width  = (self.view.frame.width-20)/100
        return CGSize(width: width, height: width)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(appsList.count)
        
        return self.appsFiltered.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cellcv
        cell.image!.sd_setImage(with: URL(string: appsFiltered[indexPath.row].imimage), completed: nil)
        cell.name.text = appsFiltered[indexPath.row].imname
        cell.category.text = appsFiltered[indexPath.row].category
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        performSegue(withIdentifier: "showDetail", sender: cell)
//        print("dsad")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVc") as! DetailVc
//        vc.selectedApp = appsFiltered[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showDetail":


            let indexPath = colecctionView.indexPath(for: sender as! UICollectionViewCell)

            guard let detailViewController = segue.destination as? DetailVc else { return }
            detailViewController.selectedApp = appsFiltered[indexPath!.row]

        default: return
        }
    }
    
    func getAppsList() {
        
        self.netWorking.getAppsList { (response) in
            //print(response)
            
            for data in response {
                
                //print(data["im:name"])
                
                let name = data["im:name"] as! [String: Any]
                let image = data["im:image"] as! [[String: Any]]
                let summary = data["summary"] as! [String: Any]
                let category = data["category"] as! [String: Any]
                let atributesCat = category["attributes"] as! [String: Any]
                
                
                let appTmp = Aplication(imname: name["label"] as! String, imimage: image[2]["label"] as! String, sumari: summary["label"] as! String, category: atributesCat["term"] as! String)
                print(appTmp.imname)
                
                self.appsList.append(appTmp)
                
                self.colecctionView.reloadData()
                
                
            }
            
            self.appsFiltered = self.appsList
            
         
            
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text
        
        if searchString == "" {
            self.appsFiltered = appsList
            print(appsFiltered.count)
        }else {
            appsFiltered = appsList.filter{ $0.imname.lowercased().contains(searchString!.lowercased()) }
        }
        
        colecctionView.reloadData()
    }
    


}





