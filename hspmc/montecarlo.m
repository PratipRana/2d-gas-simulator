close all;clear all;

N = 8^3; % total number of spheres (best 9^3 or more)
phi = .05; % volume fraction 
zeta = .001; % maximum displacement (best zeta=.005 for phi=.45 and zeta=.033 for phi=.2)
iter = 10000; % number of passes to make over all particles (best 7000 or more)
coords=zeros(N,3); % list of the 3D positions of all particles
overlap=(6*phi/(pi*N))^(1/3); % set this to diam;
% create initial, evenly-spaced lattice
numcell=(ceil(N^(1/3)));
cellside=1/numcell;
hh=linspace(-.5+.5*cellside,.5 -.5*cellside,numcell);
for ii=1:N
    coords(ii,1)=hh(ceil(ii/ceil(N/numcell)));
    coords(ii,2)=hh(floor(mod(ii,ceil(N/numcell))/numcell)+1);
    coords(ii,3)=hh(mod(ii,numcell)+1);
end
% scatter3(coords(:,1),coords(:,2),coords(:,3),'filled');
% uncomment line above to show final lattice
%% metropolis section
h = waitbar(0,'Please wait...');
s = clock;

accepts=0;
rejects=0;
acceptTime=zeros(1,iter);
rejectTime=[];
for ii=1:iter
    for jj=1:N
        newcoords=coords;
        x=coords(jj,1);
        y=coords(jj,2);
        z=coords(jj,3);
        dx=2*zeta*rand-zeta;
        dy=2*zeta*rand-zeta;
        dz=2*zeta*rand-zeta;
        x=x+dx;
        y=y+dy;
        z=z+dz;
        if x>.5
            x=x-1;
        end
        if x<-.5
            x=x+1;
        end
        if y>.5
            y=y-1;
        end
        if y<-.5
            y=y+1;
        end
        if z>.5
            z=z-1;
        end
        if z<-.5
            z=z+1;
        end
        newcoords(jj,1)=x;
        newcoords(jj,2)=y;
        newcoords(jj,3)=z;
        if isoverlap2(newcoords, overlap, jj)==0 % only accept if there is no overlap
            coords(jj,1)=x;
            coords(jj,2)=y;
            coords(jj,3)=z;
            accepts=accepts+1;
        else
            rejects=rejects+1; % overlap
            rejectTime= [rejectTime;ii];
            
            
        end
    end
    if ii ==1
        is = etime(clock,s);
        esttime = is * 50;
    end
     h = waitbar(i/50,h,...
     ['remaining time =',num2str(esttime-etime(clock,s),'%4.1f'),'sec' ]);
end
disp(accepts/(accepts+rejects));
scatter3(coords(:,1),coords(:,2),coords(:,3),'filled'); 
% uncomment line above to show final lattice

