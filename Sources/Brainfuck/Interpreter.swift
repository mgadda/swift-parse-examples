import SwiftParse

class Brainfuck {
  var memory = ContiguousArray<Int8>(repeating: 0, count: 1024)
  var ptr: Int = 0
  let ast: [Instruction]

  init?(source: String) {
    switch BrainfuckParser.program(AnyCollection(source)) {
    case let .success((instructions, out)):
      if !out.isEmpty {
        print("Syntax error at \(out)")
        return nil
      }
      ast = instructions
    case let .failure(error):
      print(error)
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
        if ptr < 1023 {
          ptr += 1
        }
      case .decPointer:
        if ptr > 0 {
          ptr -= 1
        }
      case .incByte:
        memory[ptr] += 1
      case .decByte:
        memory[ptr] -= 1
      case .writeByte:
        print(UnicodeScalar(Int(memory[ptr])) ?? "", terminator: "")
      case .readByte:
        memory[ptr] = Int8(readLine(strippingNewline: true)!) ?? 0
      case let .loop(loopInstructions):
        while memory[ptr] != 0 {
          eval(loopInstructions)
        }
      }
    }
  }

  var debugDescription: String {
    var desc = "\nPointer = \(ptr)"
    desc += "\nMemory = \n"
    desc += memory.debugDescription
    return desc
  }
}
