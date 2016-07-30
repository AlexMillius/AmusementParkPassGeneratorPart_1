//
//  ViewController.swift
//  Amusement_Park_Pass_Generator_Part_1
//
//  Created by Alex Millius on 29.07.16.
//  Copyright © 2016 TumTum. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createHardCodedPeople(type:TypesOfPeople, firstName:String?, lastName:String?, dateOfBirth:String?,streetAdress:String?,city:String?,zipCode:String?,state:String?,socialSecurityNumber:(Int,Int,Int)?,company:String?,managementTier:ManagementTier?) throws -> PeopleType {
        
        var people:PeopleType?
        
        do {
            people = try createNewPeople(type, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, streetAdress: streetAdress, city: city, zipCode: zipCode, state: state, socialSecurityNumber: socialSecurityNumber, company: company, managementTier: managementTier)
        } catch ErrorMissingInfo.FirstNameMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.LastNameMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.DateOfBirthMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.StreetAdressMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.CityMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.ZipCodeMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.StateMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.SocialSecurityNumberMissing(let error){
            print("please enter a \(error)")
        } catch ErrorMissingInfo.ManagementTierMissing(let error){
            print("please enter a \(error)")
        } catch Error.UnknownType(let error){
            print(error)
        } catch let error {
            print(error)
        }
        
        if let people = people {
            return people
        } else {
            print("Unable to create people")
            throw Error.UnableToCreatePeople
        }
    }
}

