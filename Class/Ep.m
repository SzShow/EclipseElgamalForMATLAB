classdef Ep
    %EP このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties
        Property1
    end
    
    methods (Access = public)
        function obj = Ep(E, x, y)
            obj.elipticCurve = E;
            obj.x = x;
            obj.y = y;
        end
        
        function R=plus(P, Q)
            
        end
        
    end
    
    properties (Access = protected)
        elipticCurve ElipticCurve
        x
        y
    end
end

