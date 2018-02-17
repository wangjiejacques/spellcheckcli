//
//  main.swift
//  spellcheckcli
//
//  Created by WANG Jie on 17/02/2018.
//  Copyright © 2018 jwang123. All rights reserved.
//

import Foundation
import AppKit
extension String {
    var misspelled: [NSRange] {
        var ranges = [NSRange]()
        var range = NSRange()
        while true {
            range = NSSpellChecker.shared.checkSpelling(of: self, startingAt: range.upperBound)
            if range.length == 0 {
                break
            }
            if ranges.contains(range) {
                break
            }
            ranges.append(range)
        }
        return ranges
    }
}

struct TextLocation {
    let line: Int
    let start: Int
    let end: Int
}

func spellCheck(lines: [String]) -> [TextLocation] {
    var locations = [TextLocation]()
    lines.enumerated().forEach { (lineIndex, element) in
        let line = element
        for range in line.misspelled {
            let location = TextLocation(line: lineIndex, start: range.lowerBound, end: range.upperBound)
            locations.append(location)
        }
    }
    return locations
}

func run(args: [String]) {
    guard args.count >= 2 else {
        print("Example usage:")
        print("1. spell check the files by file name.")
        print("    `spellcheck file1, file2...`")
        print("2. spell check the uncommited swfit file.")
        print("    `git diff --only-name|grep .swift|xargs spellcheck`")
        return
    }
    for file in args[1...] {
        guard let content = try? String(contentsOfFile: file) else {
            print("\(file) not exists")
            return
        }

        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map { String($0) }
        let locations = spellCheck(lines: lines)
        for location in locations {
            let line = lines[location.line]
            let start = line.index(line.startIndex, offsetBy: location.start)
            let end = line.index(line.startIndex, offsetBy: location.end)
            let word = line[start..<end]
            print("At \(file): [\(location.line+1), \(location.start+1)] \(word)")
        }
    }
}
let args = CommandLine.arguments
run(args: args)


