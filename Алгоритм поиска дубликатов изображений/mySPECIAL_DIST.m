function [ distance ] = mySPECIAL_DIST( vect_x, vect_y )

% vect_x=xlsread('Тест', 'read', 'D3:H3');
% vect_y=xlsread('Тест', 'read', 'D4:H4');

numerator=sqrt( sum(  (vect_x-vect_y ).^2 )  );
denominator=sqrt( sum(vect_x.^2) ) + sqrt( sum(vect_y.^2) );
distance=numerator/denominator;


end

