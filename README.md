A Hex Encoder with an incrementable state for the [Basys 3](https://digilent.com/reference/programmable-logic/basys-3/start)
### Report
See [Wiki](https://github.com/werydude/FPGA-Demo/wiki)

### Controls
- Press left and right buttons to select display digit
- Press up/down to increment/decrement value
- Move 4 LSB (right-most) switches to encode hex value
- Press center button to commit swiches value to display

### LED
- **LD0-3**: Switches value
- **LD4-7**: 4-bit data value of selected digit
- _LD8_: NC (seperator)
- **LD9-15**: Segements value of selected digit
