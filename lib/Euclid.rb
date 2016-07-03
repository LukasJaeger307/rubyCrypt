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

#Contains the expanded euclid-algorithm
module Euclid
    
    #The expanded euclid algorithm. Sorts a and b by size,
    #computes their gcd and linear combination factors to 
    #compute the gcd and returns all of it
    def Euclid.euclidAlgorithm(a,b)
        if (a > b) then
            euclid = EuclidSet.new(a,b)
        else
            euclid = EuclidSet.new(b,a)
        end
        euclid.executeEuclid
    end
    
    def Euclid.chineseRemainderTheorem(mods)
        m = 1
        mods.keys.each do |mi|
            m *= mi
        end
        x = 0
        mods.keys.each do |mi|
            bigMi = m / mi
            euclidSet = euclidAlgorithm(mi, bigMi)
            yi = euclidSet.s
            x += yi * mods[mi] * bigMi
        end
        return x % m     
    end
end

class EuclidSet
    
	attr_reader :a, :b, :q, :r, :s, :t, :gcd
	

	def a=(value)
		if (value > @b) then
			@a = value
		else
			@a = @b
			@b = value
		end
		calcQAndR
	end

	def b=(value)
		if (value < @a) then
			@b = value
		else
			@b = @a
			@a = value
		end	
	end
    
    def executeEuclid
        recursiveDescent(self)
    end
    
    protected
    attr_writer :s, :t, :gcd
	
	private
    
    def initialize(a,b)
		if a > b then
			@a = a
			@b = b
		else
			@a = b
			@b = a
		end
		calcQAndR
	end
    
	def calcQAndR()
        if (@b > 0) then
            @q = @a / @b
            @r = @a % @b
        else
            @q = 0
            @r = 0
        end
	end
    
    def recursiveDescent(euclidSet)
        if euclidSet.b == 0 then
            euclidSet.s = 1
            euclidSet.t = 0
            euclidSet.gcd = euclidSet.a
            return euclidSet
        else
            newSet = EuclidSet.new(euclidSet.b, euclidSet.r)
            recursiveDescent(newSet)
            euclidSet.s = newSet.t
            euclidSet.t = newSet.s - euclidSet.q * newSet.t
            euclidSet.gcd = newSet.gcd
            return euclidSet
        end
    end
end


