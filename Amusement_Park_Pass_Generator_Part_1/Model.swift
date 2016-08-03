//
//  Model.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Mohamed Lee on 30.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation

//MARK: - Error
enum ErrorMissingInfo:ErrorType {
    case FirstNameMissing(String)//ok
    case LastNameMissing(String)//ok
    case DateOfBirthMissing(String)//ok
    case StreetAdressMissing(String)//ok
    case CityMissing(String)//ok
    case ZipCodeMissing(String)//ok
    case StateMissing(String)//ok
    case SocialSecurityNumberMissing(String)//ok
    case ManagementTierMissing(String)//ok
}

enum Error:ErrorType {
    case UnknownType(String)//Should never appen
    case UnableToCreatePeople//ok
    case InvalidDateFormat//ok
    case PeopleTooOldForFree//ok
}

//MARK: - date Helper
let dateFormatter = NSDateFormatter()
let calendar = NSCalendar.currentCalendar()

func checkIfThisIsTheBirthday(birthdayDate:NSDate) -> Bool{
    let currentComponents = calendar.components([.Day , .Month ], fromDate: NSDate())
    let birthDayComponents = calendar.components([.Day , .Month ], fromDate: birthdayDate)
    if currentComponents.month == birthDayComponents.month && currentComponents.day == birthDayComponents.day {
        return true
    } else {return false}
}

//MARK: - create people
func createNewPeople(type type:TypesOfPeople, firstName:String?, lastName:String?, dateOfBirthString:String?,streetAdress:String?,city:String?,zipCode:Int?,state:String?,socialSecurityNumber:(Int,Int,Int)?,managementTier:ManagementTier) throws -> PeopleType {
    
    func checkDateFormat(date :String) throws -> NSDate{
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let birthday = dateFormatter.dateFromString(date)
        if let birthdayUnwrapped = birthday {
            return birthdayUnwrapped
        } else {
            throw Error.InvalidDateFormat
        }
    }
    
    switch type {
    case .GuestClassic:
        return GuestClassic()
    case .GuestVIP:
        return GuestVIP()
    case .GuestFreeChild:
        guard let dateOfBirth = dateOfBirthString else {
            throw ErrorMissingInfo.DateOfBirthMissing("date of birth")
        }
        
        //Check if the date can be converted in this format
        let birthdayUnwrapped = try checkDateFormat(dateOfBirth)
        
        //Check if the people is youg enough
        let age = calendar.components(.Year, fromDate: birthdayUnwrapped,toDate: NSDate(),options: []).year
        guard age < 5 else {
            throw Error.PeopleTooOldForFree
        }
        
        return GuestFreeChild(dateOfBirth: birthdayUnwrapped)
    case .EmployeeFoodService, .EmployeeRideService, .EmployeeMaintenance, .EmployeeManager:
        
        //Check every common info
        guard let firstName = firstName else {
            throw ErrorMissingInfo.FirstNameMissing("first name")
        }
        guard let lastName = lastName else {
            throw ErrorMissingInfo.LastNameMissing("last name")
        }
        if let date = dateOfBirthString {
            try checkDateFormat(date)
        }else {
            throw ErrorMissingInfo.DateOfBirthMissing("date of birth")
        }
        guard let streetAdress = streetAdress else {
            throw ErrorMissingInfo.StreetAdressMissing("street adress")
        }
        guard let city = city else {
            throw ErrorMissingInfo.CityMissing("city")
        }
        guard let zipCode = zipCode else {
            throw ErrorMissingInfo.ZipCodeMissing("zip code")
        }
        guard let state = state else {
            throw ErrorMissingInfo.StateMissing("state")
        }
        guard let socialSecurityNumber = socialSecurityNumber else {
            throw ErrorMissingInfo.SocialSecurityNumberMissing("social security number")
        }
        
        // ReCheck for the type to dyspatch init correctly
        switch type {
        case .EmployeeFoodService:
            return EmployeeFoodService(info: PeopleInfos(firstName: firstName, lastName: lastName, dateOfBirthString: dateOfBirthString, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber, managementTier: managementTier))
        case .EmployeeRideService:
            return EmployeeRideService(info: PeopleInfos(employeeFirstName: firstName, lastName: lastName, dateOfBirthString: dateOfBirthString, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        case .EmployeeMaintenance:
            return EmployeeMaintenance(info: PeopleInfos(employeeFirstName: firstName, lastName: lastName, dateOfBirthString: dateOfBirthString, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        case .EmployeeManager:
            if managementTier == ManagementTier.None {
                throw ErrorMissingInfo.ManagementTierMissing("management tier")
            }
            return Manager(tier: managementTier, info: PeopleInfos(employeeFirstName: firstName, lastName: lastName, dateOfBirthString: dateOfBirthString, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        default: throw Error.UnknownType("Unknown type of people")
        }
    }
}