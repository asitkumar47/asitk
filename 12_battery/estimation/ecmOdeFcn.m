function dx = ecmOdeFcn(~, x, u, packapacity_Ah, r1_Ohm, r2_Ohm, c1_F, c2_F)

dx = [0; 0; 0];

dx(1) = -u / (packapacity_Ah * 3600);
dx(2) = u / c1_F - x(2) / (r1_Ohm * c1_F);
dx(3) = u / c2_F - x(3) / (r2_Ohm * c2_F);

end