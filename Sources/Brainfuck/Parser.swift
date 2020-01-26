import SwiftParse

enum Instruction {
  case incPointer, decPointer, incByte, decByte, writeByte, readByte
  case loop([Instruction])
}

typealias LoopParser = StandardParser<String, Instruction>

struct BrainfuckParser {  
  static let incPointer = match(">") ^^ { _ in Instruction.incPointer }
  static let decPointer = match("<") ^^ { _ in Instruction.decPointer }
  static let incByte = match("+") ^^ { _ in Instruction.incByte }
  static let decByte = match("-") ^^ { _ in Instruction.decByte }
  static let writeByte = match(".") ^^ { _ in Instruction.writeByte }
  static let readByte = match(",") ^^ { _ in Instruction.readByte }

  static let pointerOps = incPointer | decPointer
  static let byteOps = incByte | decByte
  static let ioOps = writeByte | readByte
  static let operation = pointerOps | byteOps | ioOps | loop()
  
  // loop must defined as a static function because it references
  // operation which in turn references loop.
  static let loop: () -> LoopParser = {
    loopStart ~ operation* ~ loopEnd ^^ { Instruction.loop($0.0.1) }
  }
  
  static let loopStart = match("[")
  static let loopEnd = match("]")
  
  static let program = operation+
}
