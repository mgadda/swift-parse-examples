//  Created by Matthew Gadda on 9/26/16.
//  Copyright © 2016 Matt Gadda. All rights reserved.

import SwiftParse

let helloWorld = "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."
if let bf = Brainfuck(source: helloWorld) {
  bf.run()
  print(bf.debugDescription)
}
