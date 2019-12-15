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
        
        % ���W�̓��͂������ꍇ�͎����I�ɖ������_�ƂȂ�܂�
        % x�̂ݍ��W���L�����ꂽ�ꍇ�͑ȉ~�Ȑ��̃p�����[�^�Ɋ�Â���
        % ���߂�����Wy�̓��A���̒l��Ԃ��܂��B
        function obj = Ep(E, x, y)
            obj.elipticCurve = E;
            
            if nargin == 1
                      
                % ����񂩁H�H�H���Ċ����ł����A���C�����I��
                % �Ȃ񂩓���Ȃ��ƋC���������̂ŁE�E�E
                obj.x = obj.INFINITE_POINT;
                obj.y = obj.INFINITE_POINT;

                obj.isInfinitePoint = true;
            elseif nargin == 2
                obj.x = mod(sym(x), E.p);
                obj.y = E.CalculateY2(obj.x);
                
                if ~isSymType(obj.y, 'rational') && ...
                    ~isSymType(obj.y, 'integer')
                    error("x�͑ȉ~�Ȑ���̗L���_�������܂���")
                end
                
                obj.isInfinitePoint = false;
                
            elseif nargin == 3
                
                if mod(sym(y)^2, E.p) ~= E.CalculateY2(x)
                    error("���͂��ꂽ���W�͑ȉ~�Ȑ���̓_�ł͂���܂���");
                    
                end
                    
                obj.x = sym(x);
                obj.y = sym(y);

                obj.isInfinitePoint = false;
            end

        end
        
        function n = GetOrder(obj)
            
        end
        
        % �\�ʏ�ł́i�Q�\����́j���Z���ȒP�Ɍ��������̂�
        % ���Z�q'+'���I�[�o�[���[�h���܂��B
        function R=plus(P, Q)
            
            % �������_�̃`�F�b�N
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
            
            % 1. �t���̃`�F�b�N
            % 2. ���_�̃`�F�b�N
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

