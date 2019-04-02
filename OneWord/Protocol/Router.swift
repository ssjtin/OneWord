//
//  Router.swift
//  OneWord
//
//  Created by Hoang Luong on 28/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//
import UIKit

protocol Router {
    func route(to destination: String, fromVC: UIViewController, parameters: Any?)
}
