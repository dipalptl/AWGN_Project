a=taus();
b=taus();
u0=concat(a,b[31:16]);
u1=b[15:0];
exp_e=LeadingZeroDetector(u0)+1;
x_e=u0<<exp_e;
y_e=((C2_e[x_e_B]*x_e)+C1_e[x_e_B])*x_e_B+C0_e[x_e_B];
ln2=ln(2);
e'=exp_e*ln2;
e=(e'-y_e)<<1;
exp_f=5-LeadingZeroDetector(e);
x_f'=e>>exp_f;
x_f=if(exp_f[0], x_f'>>1, x_f')   
y_f=C1_f[x_f_B]*x_f_B+C0_f[x_f_B];


exp_f'=if(exp_f[0], exp_f+1>>1, exp>>1)
    f=y_f<<exp_f';
    
    g0=sin(2*pi*u1);
    g1=cos(2*pi*u1);
    quad=u1[15:14];
    
    
    x_g_a=u1[13:0];
    x_g_b=(1-2^-14)-u1[13:0];
    
    y_g_a=C1_g[x_g_a_B]*x_g_a_B+C0_g[x_g_a_B];
    y_g_B=C1_g[x_g_b_B]*x_g_b_B+C0_g[x_g_b_B];
    
    switch(seg)
        
        case 0: g0 = y_g_b; g1=y_g_a;
        case 1: g0 = y_g_a; g1=-y_g_b;
        case 2: g0 = -y_g_b; g1=-y_g_a;
        case 3: g0 = -y_g_a; g1=y_g_b;
            
            x0=f*g0;
            x1=f*g1;