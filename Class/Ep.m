classdef Ep
    %EP このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    properties (Access = protected, Constant)
        INFINITE_POINT = -9999;
    end
    
    methods (Access = public)
        
        % 座標の入力が無い場合は自動的に無限遠点となります
        % xのみ座標が記入された場合は楕円曲線のパラメータに基づいて
        % 求められる座標yの内、正の値を返します。
        function obj = Ep(E, x, y)
            if nargin == 1
                obj.elipticCurve = E;
                
                % いるんか？？？って感じですが、お気持ち的に
                % なんか入れないと気持ち悪いので・・・
                obj.x = obj.INFINITE_POINT;
                obj.y = obj.INFINITE_POINT;

                obj.isInfinitePoint = true;
            elseif nargin == 2
                obj.elipticCurve = E;
                obj.x = mod(sym(x), E.p);
                obj.y = mod(sqrt((sym(x)^3)+(E.a*x)+E.b), E.p);
                
            elseif nargin == 3
                obj.elipticCurve = E;
                obj.x = x;
                obj.y = y;

                obj.isInfinitePoint = false;
            end

        end
        
        function [x, y]=GetPoint(obj)
            x=obj.x;
            y=obj.y;
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
            
            [x1, y1] = P.GetPoint();
            [x2, y2] = Q.GetPoint();
            
            % 1. 逆元のチェック
            % 2. 同点のチェック
            if y1==-y2
                R = Ep(P.elipticCurve);
                return;
            elseif x1==x2 && ...
                y1==y2
                a = P.elipticCurve.GetParams();
                grad = (3*(x1^2)+a)/(2*y1);
            else
                grad = (y2-y1)/(x2-x1);
            end
            
            x3 = grad^2-x1-x2;
            y3 = grad*(x1-x3)-y1;
            
            R = Ep(P.elipticCurve, x3, y3);
        end
        
        
        
    end
    
    properties (Access = protected)
        elipticCurve
        x
        y
        
        isInfinitePoint
    end
end

