classdef Ep
    %EP ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
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

