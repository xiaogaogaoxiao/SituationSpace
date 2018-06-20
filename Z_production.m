function [Z_x,oxyz,R]=Z_production(X,UCAV_p)

   vec=[X(1);X(4);X(7)]-UCAV_p;                                   % �۲�λ��
   
   if vec(1)>=0
        dem=0;                               % ��һ�������ڲ���Ҫ�ԽǶ�������   
   else
         if vec(2)>=0                                       % �ڶ�����Ҫ��pi
            dem=1;
         else
            dem=-1;                                         % ��������Ҫ��pi
         end  
   end
   
   D=[norm(vec) 0;0 norm(vec)];                                      % ����
   R=blkdiag(0.05*norm(vec),inv(D)*0.1*eye(2)*inv(D)');           % �������
   v_R=sqrtm(R)*randn(3,1);
   Z_x=[norm(vec);
        atan((vec(2))/(vec(1)+1e-12))+pi*dem;
        asin((vec(3))/(norm(vec)+1e-12))]+v_R;                        % �۲�                     
   oxyz=[Z_x(1).*cos(Z_x(3)).*cos(Z_x(2));
         Z_x(1).*cos(Z_x(3)).*sin(Z_x(2));
         Z_x(1).*sin(Z_x(3))]+UCAV_p;                       % ����ָ������� 
end