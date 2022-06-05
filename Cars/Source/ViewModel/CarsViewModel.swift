//
//  CarsViewModel.swift
//  Cars
//
//  Created by Vikas Kumar on 03/03/22.
//

import Foundation

class CarsViewModel {
    
    //Public Properties
    var numberOfRows: Int {
        get {
            carListModel.carsListArray.count
        }
    }
    
    func carTitle(index: Int) -> String {
        return carListModel.carsListArray[index].title ?? ""
    }
    
    func carDateTime(index: Int) -> String {
        return carListModel.carsListArray[index].formattedDateTime
    }
    
    func carDescription(index: Int) -> String {
        return carListModel.carsListArray[index].ingress ?? ""
    }
    
    func carImageURL(index: Int) -> URL? {
        if let image = carListModel.carsListArray[index].image, let imageURL = URL(string: image) {
            return imageURL
        }
        return nil
    }
    
    func setDatasource(model: CarListDataModel) {
        carListModel = model
    }
    
    //Private Property
    private var carListModel = CarListDataModel()
    
    //Fetch API Method
    func getCarsListData(completionBlock: @escaping (Bool, String?) -> Void) {
        ApiManager.shared.getData(from: .getCarsList(path: API_ENDPOINT.carListPath)) { response, error in
            if error == nil {
                if let jsonDict = response as? [String:Any], let jsonArray = jsonDict["content"] as? [[String:Any]], !jsonArray.isEmpty {
                    var modelArray = [CarListModel]()
                    jsonArray.forEach { dict in
                        let model = CarListModel(dict: dict)
                        modelArray.append(model)
                    }
                    self.carListModel.carsListArray = modelArray
                    do {
                        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: self.carListModel, requiringSecureCoding: false)
                        UserDefaults.standard.set(encodedData, forKey: OFFLINE_DATA_KEY)
                        UserDefaults.standard.synchronize()
                    } catch {
                        debugPrint(error)
                    }
                    completionBlock(true, nil)
                } else {
                    completionBlock(false, "Invalid Json Response")
                }
            } else {
                completionBlock(false, error?.localizedDescription)
            }
        }
    }
}
