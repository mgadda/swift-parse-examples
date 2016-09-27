import SwiftParse

class Brainfuck {
  var memory = ContiguousArray<Int8>(repeating: 0, count: 1024)
  var p: Int = 0
  let ast: [Instruction]

  init?(source: String) {
    switch parseBrainfuck(source: source) {
    case let .some(instructions, next):
      if !next.isEmpty {
        print("Syntax error at \(next)")
        return nil
      }
      ast = instructions
    default:
      print("Syntax error")
      return nil
    }
  }

  func run() {
    eval(ast)
  }

  private func eval(_ instructions: [Instruction]) {
    for instruction in instructions {
      switch instruction {
      case .incPointer:
        if p < 1023 {
          p += 1
        }
      case .decPointer:
        if p > 0 {
          p -= 1
        }
      case .incByte:
        memory[p] += 1
      case .decByte:
        memory[p] -= 1
      case .writeByte:
        print(UnicodeScalar(Int(memory[p])) ?? "", terminator: "")
      case .readByte:
        memory[p] = Int8(readLine(strippingNewline: true)!) ?? 0
      case let .loop(loopInstructions):
        while memory[p] != 0 {
          eval(loopInstructions)
        }
      }
    }
  }

  var debugDescription: String {
    var desc = "\nPointer = \(p)"
    desc += "\nMemory = \n"
    desc += memory.debugDescription
    return desc
  }
}
