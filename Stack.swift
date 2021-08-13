import Foundation

struct Stack<T> {
    private var elements = [T]()
    init() {}
    
    var peek: T? {
        return self.elements.last
    }
    
    var count: Int {
        return self.elements.count
    }
    
    var isEmpty: Bool {
        return self.elements.isEmpty
    }
    
    mutating func pop() -> T? {
        return self.elements.popLast()
    }
    
    mutating func push(_ value: T) {
        self.elements.append(value)
    }
}

extension Stack: CustomStringConvertible {
    var description: String {
        return self.elements.description
    }
}
