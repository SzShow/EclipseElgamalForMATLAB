classdef ElipticCurve < handle
    
    properties (Access = public)
        a
        b
        
        p
    end
    
    methods (Access = public)
        
        function obj = ElipticCurve(a, b, p)
                       
            obj.a = mod(sym(a), sym(p));
            obj.b = mod(sym(b), sym(p));
            obj.p = sym(p);
            
        end
        
        function y = CalculateY2(obj, x)
            y = mod((sym(x)^3)+(obj.a*x)+obj.b, obj.p);
        end
    end
    
end

