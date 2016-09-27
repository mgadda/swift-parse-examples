import SwiftParse

enum Instruction {
  case incPointer, decPointer, incByte, decByte, writeByte, readByte
  case loop([Instruction])
}

func parseBrainfuck(source: String) -> ([Instruction], [Character])? {
  typealias OperationParser = ([Character]) -> (Instruction, [Character])?
  typealias LoopParser = ([Character]) -> (Instruction, [Character])?

  let incPointer = accept(">") ^^ { _ in Instruction.incPointer }
  let decPointer = accept("<") ^^ { _ in Instruction.decPointer }
  let incByte = accept("+") ^^ { _ in Instruction.incByte }
  let decByte = accept("-") ^^ { _ in Instruction.decByte }
  let writeByte = accept(".") ^^ { _ in Instruction.writeByte }
  let readByte = accept(",") ^^ { _ in Instruction.readByte }

  var loop: LoopParser = placeholder
  let operation: OperationParser = incPointer | decPointer | incByte | decByte | writeByte | readByte | loop

  loop = accept("[") ~ operation* ~ accept("]") ^^ { Instruction.loop($0.0.1) }

  let program = operation+

  return program(stringToArray(source))
}
