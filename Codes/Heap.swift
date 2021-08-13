import Foundation

struct Heap<T: Comparable> {
    private enum ChildLocation {
        case left
        case right
    }
    
    private var elements = [T]()
    private let sort: (T, T) -> Bool
    
    init(sort: @escaping (T, T) -> Bool, elements: [T] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                shiftDown(from: i)
            }
        }
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> T? {
        return elements.first
    }
    
    private func childIndex(of index: Int, direction: ChildLocation) -> Int {
        return direction == .left ? (index * 2) + 1 : (index * 2) + 2
    }
    
    private func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    mutating func pop() -> T? {
        guard !isEmpty else {
            return nil
        }
        
        elements.swapAt(0, count - 1)
        
        defer {
            shiftDown(from: 0)
        }
        
        return elements.removeLast()
    }
    
    private mutating func shiftDown(from index: Int) {
        var parent = index
        
        while true {
            let left = childIndex(of: parent, direction: .left)
            let right = childIndex(of: parent, direction: .right)
            
            var candidate = parent  // 탐색할 노드 지정
            
            // 자식노드가 있고, 그 자식노드 값이 부모노드 값보다 크다면(max heap인 경우)
            if left < count, sort(elements[left], elements[candidate]) {
                candidate = left
            }
            
            if right < count, sort(elements[right], elements[candidate]) {
                candidate = right
            }
             
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func push(_ data: T) {
        elements.append(data)
        shiftUp(from: elements.count - 1)
    }
    
    private mutating func shiftUp(from index: Int) {
        var child = index
        
        while true {
            let parent = parentIndex(of: child)
            
            if child > 0 && sort(elements[child], elements[parent]) {
                elements.swapAt(child, parent)
                child = parent
            } else {
                return
            }
        }
    }
}
