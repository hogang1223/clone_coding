//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by hogang on 2023/08/10.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
