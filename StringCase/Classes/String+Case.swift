//
//  String+Case.swift
//  StringCase
//
//  Created by Marcin Raburski on 23/08/2016.
//  Use at your own risk.
//

public extension String {
    public enum Case {
        case unknown
        case cobol  // cobol-case
        case snake  // snake_case
        case macro  // MACRO_CASE
        case pascal // PascalCase
        case camel  // camelCase
        case dot    // dot.case
        
        func getSeparator() -> String.Separator {
            switch self {
            case .snake, .macro:
                return .underscore
            case .cobol:
                return .hyphen
            case .dot:
                return .dot
            default:
                return .none
            }
        }
    }
    
    public enum Separator: String {
        case hyphen = "-"
        case underscore = "_"
        case dot = "."
        case space = " "
        case none = ""
    }
}

extension Character {
    func isUppercased() -> Bool {
        return ("A"..."Z").contains(self)
    }
}

public extension String {
    public func cased(_ to: String.Case, from: String.Case = .unknown) -> String {
        if self.characters.count == 0 {
            return self
        }
        
        let originCase = from == .unknown ? self.getCase() : from
        guard originCase != .unknown else {
            print("Couldn't determine string casing: \(self)")
            return self
        }
        
        let components = self.components(withCase: originCase)
        return String.joined(components: components, withCase: to)
    }
    
    func components(withCase: String.Case) -> [String] {
        if withCase.getSeparator() == .none {
            // Separate by letter capitalization
            return self.componentsSeparatedByLetterCapitalization()
        }
        
        // Separate with separator
        return self.components(separatedBy: withCase.getSeparator().rawValue)
    }
    
    func componentsSeparatedByLetterCapitalization() -> [String] {
        let separator = String.Separator.underscore
        var characters = self.characters
        let first = characters.removeFirst()
        
        let transformed = String(first) + characters.map({ $0.isUppercased() ? "\(separator.rawValue)\($0)" : String($0) }).reduce("", +)
        return transformed.components(separatedBy: separator.rawValue)
    }
    
    static func joined(components: [String], withCase: String.Case) -> String {
        var tail = components
        let first = tail.removeFirst()
        var all = [String]()
        
        switch withCase {
        case .snake, .dot, .cobol:
            all = [first.lowercased()] + tail.map { $0.lowercased() }
        case .pascal:
            all = [first.capitalized] + tail.map { $0.capitalized }
        case .camel:
            all = [first.lowercased()] + tail.map { $0.capitalized }
        case .macro:
            all = [first.uppercased()] + tail.map { $0.uppercased() }
        default:
            all = components
        }
        
        return all.joined(separator: withCase.getSeparator().rawValue)
    }
    
    public func getCase() -> String.Case {
        if self.contains(.space) {
            return .unknown
        }
        
        if self.characters.count == 0 {
            return .unknown
        }
        
        if String(self.characters.first!).contains([.dot, .hyphen, .space, .underscore]) {
            return .unknown
        }
        
        if self.contains(.underscore) && !self.contains([.dot, .hyphen, .space]) {
            if self.uppercased() == self {
                return .macro
            }
            return .snake
        }
        
        if self.contains(.hyphen) && !self.contains([.dot, .underscore, .space]) {
            return .cobol
        }
        
        if self.contains(.dot) && !self.contains([.underscore, .hyphen, .space]) {
            return .dot
        }
        
        if !self.contains([.dot, .hyphen, .space, .underscore]) {
            if self.lowercased().characters.first == self.characters.first {
                return .camel
            }
            return .pascal
        }
        
        return .unknown
    }
    
    public func contains(_ separator: String.Separator) -> Bool {
        return self.contains(separator.rawValue)
    }
    
    public func contains(_ anySeparator: [String.Separator]) -> Bool {
        return anySeparator.map({ self.contains($0) }).reduce(false, { $0 || $1 })
    }
    
}
