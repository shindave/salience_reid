datas = zeros(8, 316);

k = [5,10,15,20,25,50,75,90];

for i = 1:size(k,2)
    load(['knn_salience_nr_100_KofNr_', num2str(k(i)),'CMC.mat']);
    datas(i,:) = CMC;
end
x = 1:316;
plot(x,datas(2,:),'r-',x,datas(6,:),'b-', x, datas(8,:),'g-');