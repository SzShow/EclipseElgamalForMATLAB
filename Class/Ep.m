classdef Ep
    %EP ���̃N���X�̊T�v�������ɋL�q
    %   �ڍא����������ɋL�q
    
    properties (Access = protected, Constant)
        INFINITE_POINT = -9999;
    end
    
    methods (Access = public)
        
        % ���W�̓��͂������ꍇ�͎����I�ɖ������_�ƂȂ�܂�
        % x�̂ݍ��W���L�����ꂽ�ꍇ�͑ȉ~�Ȑ��̃p�����[�^�Ɋ�Â���
        % ���߂�����Wy�̓��A���̒l��Ԃ��܂��B
        function obj = Ep(E, x, y)
            if nargin == 1
                obj.elipticCurve = E;
                
                % ����񂩁H�H�H���Ċ����ł����A���C�����I��
                % �Ȃ񂩓���Ȃ��ƋC���������̂ŁE�E�E
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
            
            [x1, y1] = P.GetPoint();
            [x2, y2] = Q.GetPoint();
            
            % 1. �t���̃`�F�b�N
            % 2. ���_�̃`�F�b�N
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

