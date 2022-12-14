//
//  Predicate.swift
//  Market
//
//  Created by Mina Malak on 30/10/2022.
//

import Foundation

struct Predicate<Target> {
    
    var matches: (Target) -> Bool

    init(matcher: @escaping (Target) -> Bool) {
        matches = matcher
    }
    
}

prefix func !<T>(rhs: KeyPath<T, Bool>) -> Predicate<T> {
    rhs == false
}

func ><T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    return Predicate { $0[keyPath: lhs] > rhs }
}

func <<T, V: Comparable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    return Predicate { $0[keyPath: lhs] < rhs }
}

func ==<T, V: Equatable>(lhs: KeyPath<T, V>, rhs: V) -> Predicate<T> {
    return Predicate { $0[keyPath: lhs] == rhs }
}

func &&<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    return Predicate { lhs.matches($0) && rhs.matches($0) }
}

func ||<T>(lhs: Predicate<T>, rhs: Predicate<T>) -> Predicate<T> {
    return Predicate { lhs.matches($0) || rhs.matches($0) }
}

func ~=<T, V: Collection>(lhs: KeyPath<T, V>,
                          rhs: V.Element) -> Predicate<T> where V.Element: Equatable {
    return Predicate { $0[keyPath: lhs].contains(rhs) }
}

extension Collection {
    
    func filter(matching predicate: Predicate<Element>) -> [Element] {
        return filter(predicate.matches)
    }
    
}
