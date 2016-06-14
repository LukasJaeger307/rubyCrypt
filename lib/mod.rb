# The MIT License (MIT)
#
# Copyright (c) 2016 LukasJaeger307
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#Contains functions for modular arithmetic
module Mod
    
    #Adds x and y and divides the result modulo by mod
	def Mod.add (x, y, mod) 
		(x + y) % mod
	end

    #Subtracts y from x and divides the result modulo by mod
	def Mod.sub(x,y,mod)
		(x - y) % mod
	end

    #Multiplies x and y and divides the result modulo by mod
	def Mod.mul(x,y,mod)
		(x * y) % mod
	end

    #Exponentiates x with y and divides the result modulo by mod
	def Mod.exp(x,y,mod)
		(x ** y) % mod
	end
end
