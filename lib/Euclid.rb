# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

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


