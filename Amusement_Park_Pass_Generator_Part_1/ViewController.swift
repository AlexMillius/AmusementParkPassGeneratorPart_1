//
//  ViewController.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 29.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNewPeople(type:TypesOfPeople, firstName:String?, lastName:String?, dateOfBirth:String?,streetAdress:String?,city:String?,zipCode:String?,state:String?,socialSecurityNumber:(Int,Int,Int)?,company:String?,managementTier:ManagementTier?) -> PeopleType {
        
        var date:NSDate?
        if let dateOfBirth = dateOfBirth, let dateFormatter = dateFormatter {
            dateFormatter.dateFormat = "dd.MM.YYYY"
            date = dateFormatter.dateFromString(dateOfBirth)
        }
        
        switch type {
        case .GuestClassic:
            return GuestClassic()
        case .GuestVIP:
            return GuestVIP()
        case .GuestFreeChild:
            if let date = date {
                return GuestFreeChild(dateOfBirth: date)
            } else {
                // Fixme: throw an error
                return GuestFreeChild(dateOfBirth: NSDate())
            }
        case .EmployeeFoodService:
            //Fixme: unwrap optional and throw error accordingly, remove forced unwrapping
            return EmployeeFoodService(info: PeopleInfos(firstName: firstName!, lastName: lastName!, dateOfBirth: date!, streetAdress: streetAdress!, city: city!, zipCode: zipCode!, state: state!, socialSecurityNumber: socialSecurityNumber!))
        case .EmployeeRideService:
            //Fixme: unwrap optional and throw error accordingly, remove forced unwrapping
            return EmployeeRideService(info: PeopleInfos(firstName: firstName!, lastName: lastName!, dateOfBirth: date!, streetAdress: streetAdress!, city: city!, zipCode: zipCode!, state: state!, socialSecurityNumber: socialSecurityNumber!))
        case .EmployeeMaintenance:
            //Fixme: unwrap optional and throw error accordingly, remove forced unwrapping
            return EmployeeMaintenance(info: PeopleInfos(firstName: firstName!, lastName: lastName!, dateOfBirth: date!, streetAdress: streetAdress!, city: city!, zipCode: zipCode!, state: state!, socialSecurityNumber: socialSecurityNumber!))
        case .EmployeeManager:
            //Fixme: unwrap optional and throw error accordingly, remove forced unwrapping
            return Manager(tier: managementTier!, info: PeopleInfos(firstName: firstName!, lastName: lastName!, dateOfBirth: date!, streetAdress: streetAdress!, city: city!, zipCode: zipCode!, state: state!, socialSecurityNumber: socialSecurityNumber!))
        }
    }
}

