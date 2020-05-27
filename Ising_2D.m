clear

addpath('export/');

%bi-indice to linear (i, j)--->(j-1)*N+i
tmax=350;
T=0.000000001;
J=1;
h=0;
k=1;
n=100;
step=700000;

s=sign(0.5-rand(n));

[nbr1, nbr2, nbr3] = nearest_neighbors(s,n);

E=energy(s, J, h);
av_mag=[];
mag_suc=[];
E_m=[];
Cv=[];



%for T=0:tmax
i=0;
while i<step+1

    %random pick
    pick=randi(n,2,1);
%     
    %flip spin
    s(pick(1), pick(2))=s(pick(1), pick(2))*-1;
    
    A=nbr2{pick(1), pick(2)};
    %s(pick(1), pick(2))=s(pick(1), pick(2))*(-1);
    
    dE = -2*J*s(pick(1), pick(2))*sum(s(A))-2*s(pick(1), pick(2))*h;
    q = exp(-dE/(k*T));
            
    if dE<0
        
    s(pick(1), pick(2)) = s(pick(1), pick(2));    
        
    elseif dE>0 && rand > q    
    s(pick(1), pick(2)) = (-1)*s(pick(1), pick(2));   
    
    else
    s(pick(1), pick(2)) = s(pick(1), pick(2));    

    end
    
       
    
    
    
    if mod(i,1000)==0
    %if i==1000 |i==10000 | i==100000 | i==step
    
    hFig = figure(1);
    set(hFig, 'Position', [30 50 550 500])
    hold on


    imagesc(s)
    

    set(gcf, 'Color', 'w');

    %colorbar('SouthOutside')
    colormap bone


    axis off;
    hold off

    drawnow

end
    
    
 i=i+1;
  
  
  
  
end

M = sum(sum(s))/numel(s);
