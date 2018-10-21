//
//  Try.swift
//  
//
//  Created by Balraj Singh on 21/10/18.
//

import Foundation

public enum Try<T> {
    case error(Error)
    case success(T)
    
    /// This func takes 2 function and applies them based on Try value
    public func fold<B>(_ onError : (Error) -> A, _ onSuccess : (T) -> A) -> B {
        switch self {
        case let .error(e):
            return onError(e)
        case let .success(e):
            return onSuccess(e)
        }
    }
    
    /// Named function for `>>-`. If the `Try` is `Error`, simply returns
    /// a new `Error` with the value of the receiver. If `Success`, applies the function `f`
    /// and returns the result.
    public func flatMap<S>(_ f : (R) -> Try<S>) -> Try<S> {
        return self >>- f
    }
}

public func >>- <RA, RB>(a : Try<RA>, f : (RA) -> Try<RB>) -> Try<RB> {
    switch a {
    case let .error(e):
        return .error(e)
    case let .success(s):
        return f(s)
    }
}
