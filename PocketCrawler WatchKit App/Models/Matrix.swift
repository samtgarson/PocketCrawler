//
//  Matrix.swift
//  Matrix
//
//  Created by Sam Garson on 30/07/2021.
//

class Matrix<T> {
    let rows: Int, columns: Int
    
    var grid = [T?]()
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        reset()
    }
    
    func validLocation(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func validLocation(_ loc: Coordinate) -> Bool {
        return validLocation(row: loc.y, column: loc.x)
    }
    
    func exists(_ loc: Coordinate) -> Bool {
        self[loc] != nil
    }
    
    func at(_ loc: Coordinate) -> T? {
        self[loc]
    }
    
    subscript(column: Int, row: Int) -> T? {
        get {
            precondition(validLocation(row: row, column: column), "Index out of range")
            return grid[row * self.rows + column]
        }
        set {
            precondition(validLocation(row: row, column: column), "Index out of range")
            grid[row * self.rows + column] = newValue
        }
    }
    
    subscript(loc: Coordinate) -> T? {
        get { self[loc.x, loc.y] }
        set { self[loc.x, loc.y] = newValue }
    }
    
    var center: Coordinate {
        let row = (rows > 1 ? rows - 1 : rows) / 2
        let col = (columns > 1 ? columns - 1 : columns) / 2
        return Coordinate(row, col)
    }
    
    var description: String {
        var dsc = ""
        for row in 0..<rows {
            for col in 0..<columns {
                if let i = self[row, col] {
                    dsc += String(describing: i) + " "
                } else {
                    dsc += "∙ "
                }
            }
            dsc += "\n"
        }
        return dsc
    }
    
    func reset() {
        grid = Array(repeating: nil, count: rows * columns)
    }
    
    func neighbours(of loc: Coordinate) -> [T] {
        loc.neighbours.compactMap {
            guard validLocation($0) else { return nil }
            return self[$0]
        }
    }
}

extension Matrix {
    
    func asRows() -> [[T?]] {
        return (0..<rows).map { row in
            stride(from: row * columns, to: (row + 1) * columns, by: 1).map { index in
                grid[index]
            }
        }
    }
}
