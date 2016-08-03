//
//  People.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 29.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation

//MARK: Protocol
protocol PeopleType {
    var access:Access { get }
}

//MARK: - Employee Protocol
protocol EmployeeType:PeopleType {
    var info:PeopleInfos { get }
}
protocol EmployeeFoodServiceType: EmployeeType {
}
protocol EmployeeRideServiceType: EmployeeType {
}
protocol EmployeeMaintenanceType: EmployeeType {
}
protocol EmployeeManagerType: EmployeeType{
    var tier:ManagementTier { get }
}

//MARK: - Guest Protocol
protocol GuestType:PeopleType {
}
protocol GuestClassicType:GuestType {
}
protocol GuestFreeChildType:GuestType {
    var dateOfBirth:NSDate { get }
}
protocol GuestVIPType:GuestType {
}

//MARK: - Type of access
enum TypeAccess {
    enum Employee:PeopleType {
        enum Hourly:PeopleType {
            case FoodService
            case RideService
            case Maintenance
            
            var access:Access {
                switch self {
                case .FoodService:
                    return Access(maintenance: false, rideControll: false, kitchen: true)
                case .RideService:
                    return Access(maintenance: false, rideControll: true, kitchen: false)
                case .Maintenance:
                    return Access(maintenance: true, rideControll: true, kitchen: true)
                }
            }
        }
        case Manager
        
        var access:Access {
            switch self {
            case .Manager:
                return Access(allAcess: true,skipLines: false)
            }
        }
    }
    
    enum Guest:PeopleType {
        case Classic
        case FreeChild
        case VIP
        
        var access: Access {
            switch self {
            case .Classic:
                return Access(skipLines: false, foodDiscountPourcent: nil, merchandiseDiscountPourcent: nil)
            case .FreeChild:
                return Access(skipLines: false, foodDiscountPourcent: nil, merchandiseDiscountPourcent: nil)
            case .VIP:
                return Access(skipLines: true, foodDiscountPourcent: Discount.food(10), merchandiseDiscountPourcent: Discount.merchandise(20))
            }
        }
    }
}

enum TypesOfPeople {
    case GuestClassic
    case GuestVIP
    case GuestFreeChild
    case EmployeeFoodService
    case EmployeeRideService
    case EmployeeMaintenance
    case EmployeeManager
}

//MARK: - People Infos
enum ManagementTier {
    case General
    case Senior
    case Shift
    case None
}

struct PeopleInfos {
    let firstName:String?
    let lastName:String?
    let dateOfBirthString:String?
    let dateOfBirth:NSDate?
    let streetAdress:String?
    let city:String?
    let zipCode:Int?
    let state:String?
    let socialSecurityNumber:(Int,Int,Int)?
    let managementTier:ManagementTier
    
    //General Init
    init(firstName:String?, lastName:String?, dateOfBirthString:String?, streetAdress:String?, city:String?, zipCode:Int?, state:String?, socialSecurityNumber:(Int,Int,Int)?, managementTier:ManagementTier){
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirthString = dateOfBirthString
        self.streetAdress = streetAdress
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.socialSecurityNumber = socialSecurityNumber
        self.managementTier = managementTier
        
        if let date = dateOfBirthString {
            self.dateOfBirth = dateFormatter.dateFromString(date)
        } else {
            self.dateOfBirth = nil
        }
    }
    
    //Empty Init
    init(){
        self.firstName = nil
        self.lastName = nil
        self.dateOfBirth = nil
        self.dateOfBirthString = nil
        self.streetAdress = nil
        self.city = nil
        self.zipCode = nil
        self.state = nil
        self.socialSecurityNumber = nil
        self.managementTier = .None
    }
    
    //Free Child init
    init(birthday:String){
        self.init(firstName:nil,lastName: nil,dateOfBirthString: birthday, streetAdress: nil,city: nil,zipCode: nil,state: nil,socialSecurityNumber: nil,managementTier: .None)
    }
    
    //Hourly employee init
    init(employeeFirstName:String?, lastName:String?, dateOfBirthString:String?, streetAdress:String?, city:String?, zipCode:Int?, state:String?, socialSecurityNumber:(Int,Int,Int)?){
        self.init(firstName:employeeFirstName,lastName: lastName,dateOfBirthString: dateOfBirthString,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,managementTier: .None)
    }
    
    //Manager init
    init(managementTier:ManagementTier, firstName:String?, lastName:String?, dateOfBirthString:String?, streetAdress:String?, city:String?, zipCode:Int?, state:String?, socialSecurityNumber:(Int,Int,Int)?){
        self.init(firstName:firstName,lastName: lastName,dateOfBirthString: dateOfBirthString,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,managementTier: managementTier)
    }
}

//MARK: - People object
struct GuestClassic:GuestClassicType {
    let access:Access = TypeAccess.Guest.Classic.access
}
struct GuestVIP:GuestVIPType {
    let access: Access = TypeAccess.Guest.VIP.access
}
struct GuestFreeChild:GuestFreeChildType {
    let access: Access = TypeAccess.Guest.FreeChild.access
    let dateOfBirth: NSDate
}
struct EmployeeFoodService:EmployeeFoodServiceType {
    let access:Access = TypeAccess.Employee.Hourly.FoodService.access
    let info: PeopleInfos
}
struct EmployeeRideService:EmployeeRideServiceType {
    let access: Access = TypeAccess.Employee.Hourly.RideService.access
    let info: PeopleInfos
}
struct EmployeeMaintenance:EmployeeMaintenanceType {
    let access: Access = TypeAccess.Employee.Hourly.Maintenance.access
    let info: PeopleInfos
}
struct Manager:EmployeeManagerType {
    let tier: ManagementTier
    let access: Access = TypeAccess.Employee.Manager.access
    let info: PeopleInfos
}