clc; clear;
% Reading data
l=imread('l.png');l= rgb2gray(l);
r=imread('rc.png');r= rgb2gray(r);
c=imread('cc.png');c= rgb2gray(c);
% Create the optimizer and metric, setting the 
% modality to 'multimodal' since the images come from different sensors.
[optimizer, metric] = imregconfig('multimodal')
% Tune the properties of the optimizer to get the problem to converge on 
% a global maxima and to allow for more iterations.
optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;
% registration
movingRegistered = imregister(l, c, 'affine', optimizer, metric);
% figure
% imshowpair(c, movingRegistered,'Scaling','joint')
movingRegistered2 = imregister(movingRegistered, r, 'affine', optimizer, metric);
% figure
% imshowpair(c, movingRegistered2,'Scaling','joint')
% Create blended overlay image, scaling the intensities of images jointly 
% as a single data set.
C = imfuse(movingRegistered,movingRegistered2,'blend','Scaling','joint');
% Crop
croped = imcrop(C,[32 32 120 140]);
% surf(croped);
% Calculating Area, ConvexArea and Perimeter
stats = regionprops('table',croped,'Area',...
    'ConvexArea','Perimeter');
area = stats.Area;
convexArea = stats.ConvexArea;
perimeter = stats.Perimeter;
% Removing 1/10
area=round(sum(area));
area=round(area/10)
convexArea=round(sum(convexArea));
convexArea=round(convexArea/10)
perimeter=round(sum(perimeter));
perimeter=round(perimeter/10)
% Normalize data into rangee of [0 2] which around 0 is Microcephaly,
% around 1 is normal and around 2 is Macrocephaly.
tablee=load('test.mat');
tablee=tablee.tablee;
% Adding achieved data to the end of the table
realw=1360;
tablee(11,1)=area;
tablee(11,2)=realw;
% norm_data = (tablee(:,1) - min(tablee(:,1))) / ( max(tablee(:,1)) - min(tablee(:,1)) )
NormedReal = rescale(tablee(:,1),0,2)
NormedEst = rescale(tablee(:,2),0,2)
% Calculate mean-squared error and Mean absolute error.
errmse = mse(area, realw);
errmae = mae(area,realw);
fprintf('\n The Mean-squared error is = %0.4f\n', errmse);
fprintf('\n The Mean absolute error is = %0.4f\n', errmae);
% ANFIS classification
finaltab=[NormedEst tablee(:,3)];
% Generate and train a fuzzy inference system. By default, the FIS structure is 
% created using a grid partition of the input variable range with
% two membership functions.
fis = anfis(finaltab);
% Plot the ANFIS output and training data.
x = finaltab(:,1);
anfisOutput = evalfis(fis,x);
% plot(x,finaltab(:,2),'*r',x,finaltab,'.b')
% legend('Training Data','ANFIS Output','Location','NorthWest')
% Improving fis
opt = anfisOptions('InitialFIS',10,'EpochNumber',40);
% Suppress the error and step size Command Window display.
opt.DisplayErrorValues = 0;
opt.DisplayStepSize = 0;
% Train the FIS.
fis = anfis(finaltab,opt);
% Plot the ANFIS output and training data.
figure
anfisOutput = evalfis(fis,x);
plot(x,finaltab(:,2),'*r',x,finaltab,'.b')
legend('Training Data','ANFIS Output','Location','NorthWest')
% Round final result to 0,1 and 2
roundedres=round(anfisOutput);
% Convertong digit labels to text labels
for i = 1 : 11 
    if roundedres (i) == 0 
            charac {i} =  'Microcephaly'; 
    else if roundedres (i) == 1
            charac {i} =  'Normal'; 
    else if roundedres (i) == 2
            charac {i} =  'Macrocephaly'; 
    end
        end
    end
end
charac
test=charac(11)
fprintf('\n Test Image Result is = %0.4f\n');
fprintf('%s %s %d %d %d %3.2f\n',test{:});
% Plotting Results
figure;
subplot(2,4,1)
subimage(l);title('Depth Left');
subplot(2,4,2)
subimage(c);title('Depth Front');
subplot(2,4,3)
subimage(r);title('Depth Right');
subplot(2,4,4)
subimage(movingRegistered);title('Left, Front Registration');
subplot(2,4,5)
subimage(movingRegistered2);title('Full Registration');
subplot(2,4,6)
subimage(C);title('Fuse Registrated');
subplot(2,4,7)
subimage(croped);title('Face Croped');
subplot(2,4,8)
surf(croped);title('3-D Registered');
