classdef ElipticCurve < handle
    %ELIPTICCURVE このクラスの概要をここに記述
    %   詳細説明をここに記述
    
    
    properties (Access = public)
        
    end
    
    properties (Access = protected, Constant)
        GET_TRACE_FAILED = -1;
    end
    
    methods (Access = public)
        
        function obj = ElipticCurve(D)
            while true
                
                % 1. -Dが平方剰余となるpを生成
                p = obj.FindProperPrime(D);
                
                % 2. pべきフロベニウス写像のトレースを探索する
                t = obj.FindFrobeniusTrace(D, p);
                
                % トレース発見に失敗したら1.からやり直し
                if t ~= obj.GET_TRACE_FAILED
                    break;
                end
                
                % 長すぎると怖いから
                % ここら辺にタイムアップ処理を仕掛ける予定
                
            end
            
            obj.N=p+1-t;
            obj.p=p;
            
            j = obj.GetInvariantj(D, p);
            
            [a_temp, b_temp] = obj.SetCurveParams(j, p);
            
            
        end
        
        function [a, b, p] = GetParams(obj)
            a = obj.a;
            b = obj.b;
            p = obj.p;
        end
        
    end
    
    methods (Access = protected)
        
        function p = FindProperPrime(~, D)
            randomRange = [100000 200000];
            while true
                prime = nthprime(randi(randomRange));
                if LegendreSymbol(-D, prime)==1
                    p = prime;
                    break;
                end

            end

        end
        
        function t = FindFrobeniusTrace(~, D, p)
            for V = 1:10000
                t = sqrt(4*sym(p)-sym(D)*sym(V)^2);
                if isSymType(t, 'integer')
                    return;
                end
            end
            t = obj.GET_TRACE_FAILED;
        end
        
        function j = GetInvariantj(~, D, p)
            switch (D)
                case EDiscriminant.D11
                    j = mod((sym(-2^5)^3), sym(p));
                case EDiscriminant.D19
                    j = mod(((sym(-2^5)*3)^3), sym(p));
                case EDiscriminant.D43
                    j = mod(((sym(-2^6)*3*5)^3), sym(p));
                case EDiscriminant.D67
                    j = mod(((sym(-2^5)*3*5*11)^3), sym(p));
                case EDiscriminant.D163
                    j = mod(((sym(-2^6)*3*5*23*29)^3), sym(p));
                otherwise
                    error("想定しない判別式が入力されました");
            end
        end
        
        function [a, b] = SetCurveParams(~, j, p)
            a = mod(sym(3*j)/sym(1728-j), sym(p));
            b = mod(sym(2*j)/sym(1728-j), sym(p));
        end
    end
    
    properties (Access = protected)
        a
        b
        
        p
        N
    end
        
end

