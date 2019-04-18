function isoverlap = isoverlap2(coords, overlap, index)
% takes an list of 3D coordinates and minimum requries separation and returns whether or not two spheres
% overlap
%coos=buildlattice(coords);
coos=coords;
coords(index,:)=[]; % because don't want to find distance to itself

dists=sqrt(sum(bsxfun(@minus,coords,coos(index,:)).^2,2));
isoverlap=any(dists<overlap);
end