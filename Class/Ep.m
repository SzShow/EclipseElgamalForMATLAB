classdef Ep
    
    properties (Access = protected, Constant)
        INFINITE_POINT = -9999;
    end
    
    properties (SetAccess = protected)
        x
        y 
        
        elipticCurve
        
        isInfinitePoint
    end
    
    methods (Access = public)
        
        % 座標の入力が無い場合は自動的に無限遠点となります
        % xのみ座標が記入された場合は楕円曲線のパラメータに基づいて
        % 求められる座標yの内、正の値を返します。
        function obj = Ep(E, x, y)
            obj.elipticCurve = E;
            
            if nargin == 1
                      
                % いるんか？？？って感じですが、お気持ち的に
                % なんか入れないと気持ち悪いので・・・
                obj.x = obj.INFINITE_POINT;
                obj.y = obj.INFINITE_POINT;

                obj.isInfinitePoint = true;
            elseif nargin == 2
                obj.x = mod(sym(x), E.p);
                obj.y = E.CalculateY2(obj.x);
                
                if ~isSymType(obj.y, 'rational') && ...
                    ~isSymType(obj.y, 'integer')
                    error("xは楕円曲線上の有理点を持ちません")
                end
                
                obj.isInfinitePoint = false;
                
            elseif nargin == 3
                
                if mod(sym(y)^2, E.p) ~= E.CalculateY2(x)
                    error("入力された座標は楕円曲線上の点ではありません");
                    
                end
                    
                obj.x = sym(x);
                obj.y = sym(y);

                obj.isInfinitePoint = false;
            end

        end
        
        function n = GetOrder(obj)
            
        end
        
        % 表面上では（群構造上の）加算を簡単に見せたいので
        % 演算子'+'をオーバーロードします。
        function R=plus(P, Q)
            
            % 無限遠点のチェック
            if P.isInfinitePoint
                R = Q;
                return;
            elseif Q.isInfinitePoint
                R = P;
                return;
            end
            
            a = P.elipticCurve.a;
            b = P.elipticCurve.b;
            p = P.elipticCurve.p;
            
            % 1. 逆元のチェック
            % 2. 同点のチェック
            if P.y==-Q.y
                R = Ep(P.elipticCurve);
                return;
            elseif P.x==Q.x && ...
                P.y==Q.y
%                 grad_num = 3*(P.x^2)+a;
%                 grad_dem = mod(2*P.y, p);
%             else
%                 grad_num = Q.y-P.y;
%                 grad_dem = mod(Q.x-P.x, p);
%             end
%             x3 = mod(grad_num^2-(P.x*(grad_dem^2))-(Q.x*(grad_dem^2)), p);
%             y3 = mod((grad_num*(P.x-x3))-(P.y*grad_dem), p);
%             R = Ep(P.elipticCurve, x3/(grad_dem^2), y3/grad_dem);
                grad = (3*(P.x^2)+a)/(2*P.y);
            else
                grad = (Q.y-P.y)/(Q.x-P.x);
            end
            
            x3 = mod(grad^2-P.x-Q.x, p);
            y3 = mod(grad*(P.x-x3)-P.y, p);
                      
            R = Ep(P.elipticCurve, x3, y3);
        end
        
        
        
    end
    
    properties (Access = protected)
     

    end
end

