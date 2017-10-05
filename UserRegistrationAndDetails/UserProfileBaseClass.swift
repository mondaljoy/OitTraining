//
//  UserProfileBaseClass.swift
//
//  Created by JOY MONDAL on 9/6/17
//  Copyright (c) inadev. All rights reserved.
//

import Foundation
import SwiftyJSON



public final class UserProfileBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let lastName = "lastName"
    static let gender = "gender"
    static let dob = "dob"
    static let firstName = "firstName"
    static let dept = "dept"
    static let photo = "photo"
  }

  // MARK: Properties
  public var lastName: String?
  public var gender: String?
  public var dob: String?
  public var firstName: String?
  public var dept: String?
  public var photo: String?

  // MARK: SwiftyJSON Initializers
    init() {
        
    }
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    lastName = json[SerializationKeys.lastName].string
    gender = json[SerializationKeys.gender].string
    dob = json[SerializationKeys.dob].string
    firstName = json[SerializationKeys.firstName].string
    dept = json[SerializationKeys.dept].string
    photo = json[SerializationKeys.photo].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = lastName { dictionary[SerializationKeys.lastName] = value }
    if let value = gender { dictionary[SerializationKeys.gender] = value }
    if let value = dob { dictionary[SerializationKeys.dob] = value }
    if let value = firstName { dictionary[SerializationKeys.firstName] = value }
    if let value = dept { dictionary[SerializationKeys.dept] = value }
    if let value = photo { dictionary[SerializationKeys.photo] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.lastName = aDecoder.decodeObject(forKey: SerializationKeys.lastName) as? String
    self.gender = aDecoder.decodeObject(forKey: SerializationKeys.gender) as? String
    self.dob = aDecoder.decodeObject(forKey: SerializationKeys.dob) as? String
    self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
    self.dept = aDecoder.decodeObject(forKey: SerializationKeys.dept) as? String
    self.photo = aDecoder.decodeObject(forKey: SerializationKeys.photo) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(lastName, forKey: SerializationKeys.lastName)
    aCoder.encode(gender, forKey: SerializationKeys.gender)
    aCoder.encode(dob, forKey: SerializationKeys.dob)
    aCoder.encode(firstName, forKey: SerializationKeys.firstName)
    aCoder.encode(dept, forKey: SerializationKeys.dept)
    aCoder.encode(photo, forKey: SerializationKeys.photo)
  }

}
