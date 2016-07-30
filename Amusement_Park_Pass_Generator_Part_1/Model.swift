//
//  Model.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Mohamed Lee on 30.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import Foundation

enum ErrorMissingInfo:ErrorType {
    case FirstNameMissing(String)
    case LastNameMissing(String)
    case DateOfBirthMissing(String)
    case StreetAdressMissing(String)
    case CityMissing(String)
    case ZipCodeMissing(String)
    case StateMissing(String)
    case SocialSecurityNumberMissing(String)
    case ManagementTierMissing(String)
}

enum Error:ErrorType {
    case UnknownType(String)
    case UnableToCreatePeople
    case InvalidDateFormat
    case PeopleTooOldForFree
}

let dateFormatter = NSDateFormatter()
let calendar = NSCalendar.currentCalendar()

func createNewPeople(type type:TypesOfPeople, firstName:String?, lastName:String?, dateOfBirth:String?,streetAdress:String?,city:String?,zipCode:Int?,state:String?,socialSecurityNumber:(Int,Int,Int)?,managementTier:ManagementTier?) throws -> PeopleType {
    
    switch type {
    case .GuestClassic:
        return GuestClassic()
    case .GuestVIP:
        return GuestVIP()
    case .GuestFreeChild:
        guard let dateOfBirth = dateOfBirth else {
            throw ErrorMissingInfo.DateOfBirthMissing("date of birth")
        }
        
        //Check if the date can be converted in this format
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let birthday = dateFormatter.dateFromString(dateOfBirth)
        guard let birthdayUnwrapped = birthday else {
            throw Error.InvalidDateFormat
        }
        
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
        guard let dateOfBirth = dateOfBirth else {
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
            return EmployeeFoodService(info: PeopleInfos(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        case .EmployeeRideService:
            return EmployeeRideService(info: PeopleInfos(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        case .EmployeeMaintenance:
            return EmployeeMaintenance(info: PeopleInfos(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        case .EmployeeManager:
            guard let managementTier = managementTier else {
                throw ErrorMissingInfo.ManagementTierMissing("management tier")
            }
            return Manager(tier: managementTier, info: PeopleInfos(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber))
        default: throw Error.UnknownType("Unknown type of people")
        }
    }
}