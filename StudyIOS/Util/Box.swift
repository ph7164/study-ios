//
//  Box.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/25.
//

import Foundation

final class Box<T> {

    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
