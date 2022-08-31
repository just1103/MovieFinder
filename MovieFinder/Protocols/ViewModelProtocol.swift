//
//  ViewModelProtocol.swift
//  MovieFinder
//
//  Created by Hyoju Son on 2022/09/01.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}

