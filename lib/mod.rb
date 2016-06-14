# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

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
