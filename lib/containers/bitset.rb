require "CBitset"

=begin
  Copyright (c) 2011 Tyler McMullen

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  "Software"), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
=end

class Containers::Bitset

  # Return a string that represents this bitset packed into 8-bit
  # characters. The first 3 bits represent the number of padding bits
  # in the final byte of the string.

  # You could make a good case that this is redundant with
  # Marshal.dump and Marshal.load, but it does save a few bytes.
  def pack
    # Number of bits of zero padding in this representation.
    padding_bits = (size+3) & 7
    padding_bits = (padding_bits == 0) ? 0 : (8 - padding_bits)
    [("%03b" % padding_bits) + self.to_s].pack("b*")
  end

  # Convert a string created using the pack method back into a bitset.
  def self.unpack str
    bits = str.unpack("b*")[0]
    padding_bits = bits[0...3].to_i(2)
    from_s(bits[3 .. -1 - padding_bits])
  end

end
