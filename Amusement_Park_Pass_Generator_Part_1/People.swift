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
    var access:AreaAccess { get }
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

//MARK: - Type of people
enum TypeAccess {
    enum Employee:PeopleType {
        enum Hourly:PeopleType {
            case FoodService
            case RideService
            case Maintenance
            
            var access:AreaAccess {
                switch self {
                case .FoodService:
                    return AreaAccess(maintenance: false, rideControll: false, kitchen: true)
                case .RideService:
                    return AreaAccess(maintenance: false, rideControll: true, kitchen: false)
                case .Maintenance:
                    return AreaAccess(maintenance: true, rideControll: true, kitchen: true)
                }
            }
        }
        case Manager
        
        var access:AreaAccess {
            switch self {
            case .Manager:
                return AreaAccess(allAcess: true,skipLines: false)
            }
        }
    }
    
    enum Guest:PeopleType {
        case Classic
        case FreeChild
        case VIP
        
        var access: AreaAccess {
            switch self {
            case .Classic:
                return AreaAccess(skipLines: false, foodDiscountPourcent: nil, merchandiseDiscountPourcent: nil)
            case .FreeChild:
                return AreaAccess(skipLines: false, foodDiscountPourcent: nil, merchandiseDiscountPourcent: nil)
            case .VIP:
                return AreaAccess(skipLines: true, foodDiscountPourcent: discount.food(10), merchandiseDiscountPourcent: discount.merchandise(20))
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

//MARK: - Area Access
enum discount {
    case food(Int)
    case merchandise(Int)
}

struct AreaAccess {
    let amusement:Bool
    let maintenance:Bool
    let office:Bool
    let rideControll:Bool
    let kitchen:Bool
    let rides:Bool
    let skipLines:Bool
    let foodDiscountPourcent:discount?
    let merchandiseDiscountPourcent:discount?
    
    //General Init
    init(amusement:Bool, maintenance:Bool, office:Bool, rideControll:Bool, kitchen:Bool, rides:Bool, skipLines:Bool, foodDiscountPourcent:discount?, merchandiseDiscountPourcent:discount?){
        self.amusement = amusement
        self.maintenance = maintenance
        self.office = office
        self.rideControll = rideControll
        self.kitchen = kitchen
        self.rides = rides
        self.skipLines = skipLines
        self.foodDiscountPourcent = foodDiscountPourcent
        self.merchandiseDiscountPourcent = merchandiseDiscountPourcent
    }
    
    //Hourly employee Init
    init(maintenance:Bool, rideControll:Bool, kitchen:Bool){
    self.init(amusement:true,maintenance:maintenance,office:false,rideControll:rideControll,kitchen:kitchen,rides:true,skipLines:false,foodDiscountPourcent:discount.food(15),merchandiseDiscountPourcent:discount.merchandise(25))
    }
    
    //Manager employee Init
    init(allAcess:Bool,skipLines:Bool){
        if allAcess {
            self.init(amusement:true,maintenance:true,office:true,rideControll:true,kitchen:true,rides:true,skipLines:skipLines,foodDiscountPourcent:discount.food(25),merchandiseDiscountPourcent:discount.merchandise(25))
        } else {
            self.init(amusement:false,maintenance:false,office:false,rideControll:false,kitchen:false,rides:false,skipLines:skipLines,foodDiscountPourcent:nil,merchandiseDiscountPourcent:nil)
        }
    }
    
    //Guest Init
    init(skipLines:Bool,foodDiscountPourcent:discount?, merchandiseDiscountPourcent:discount?){
        self.init(amusement:true,maintenance:false,office:false,rideControll:false,kitchen:false,rides:true,skipLines:skipLines,foodDiscountPourcent:foodDiscountPourcent,merchandiseDiscountPourcent:merchandiseDiscountPourcent)
    }
}

//MARK: - People Infos
enum ManagementTier {
    case General
    case Senior
    case Shift
}

struct PeopleInfos {
    let firstName:String?
    let lastName:String?
    let dateOfBirth:NSDate?
    let streetAdress:String?
    let city:String?
    let zipCode:String?
    let state:String?
    let socialSecurityNumber:(Int,Int,Int)?
    let company:String?
    let managementTier:ManagementTier?
    
    //General Init
    init(firstName:String, lastName:String, dateOfBirth:NSDate, streetAdress:String, city:String, zipCode:String, state:String, socialSecurityNumber:(Int,Int,Int),company:String?, managementTier:ManagementTier?){
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.streetAdress = streetAdress
        self.city = city
        self.zipCode = zipCode
        self.state = state
        self.socialSecurityNumber = socialSecurityNumber
        self.company = company
        self.managementTier = managementTier
    }
    
    //Hourly employee init
    init(firstName:String, lastName:String, dateOfBirth:NSDate, streetAdress:String, city:String, zipCode:String, state:String, socialSecurityNumber:(Int,Int,Int)){
        self.init(firstName:firstName,lastName: lastName,dateOfBirth: dateOfBirth,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,company: nil,managementTier: nil)
    }
    
    //Manager init
    init(managementTier:ManagementTier, firstName:String, lastName:String, dateOfBirth:NSDate, streetAdress:String, city:String, zipCode:String, state:String, socialSecurityNumber:(Int,Int,Int)){
        self.init(firstName:firstName,lastName: lastName,dateOfBirth: dateOfBirth,streetAdress: streetAdress,city: city,zipCode: zipCode,state: state,socialSecurityNumber: socialSecurityNumber,company: nil,managementTier: managementTier)
    }
}

//MARK: - People object
struct GuestClassic:GuestClassicType {
    let access:AreaAccess = TypeAccess.Guest.Classic.access
}
struct GuestVIP:GuestVIPType {
    let access: AreaAccess = TypeAccess.Guest.VIP.access
}
struct GuestFreeChild:GuestFreeChildType {
    let access: AreaAccess = TypeAccess.Guest.FreeChild.access
    let dateOfBirth: NSDate
}
struct EmployeeFoodService:EmployeeFoodServiceType {
    let access:AreaAccess = TypeAccess.Employee.Hourly.FoodService.access
    let info: PeopleInfos
}
struct EmployeeRideService:EmployeeRideServiceType {
    let access: AreaAccess = TypeAccess.Employee.Hourly.RideService.access
    let info: PeopleInfos
}
struct EmployeeMaintenance:EmployeeMaintenanceType {
    let access: AreaAccess = TypeAccess.Employee.Hourly.Maintenance.access
    let info: PeopleInfos
}
struct Manager:EmployeeManagerType {
    let tier: ManagementTier
    let access: AreaAccess = TypeAccess.Employee.Manager.access
    let info: PeopleInfos
}





