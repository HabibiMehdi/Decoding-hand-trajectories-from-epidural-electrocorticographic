
clear;
clc;
close all

%path = './Datasets';


load('./Datasets/Motion.mat');

load('./Datasets/ECoG_time.mat');

signal =[];

for i=1:64
    fname=['./Datasets/ECoG_ch',num2str(i),'.mat'];
    x = importdata(fname);
    signal =[signal , x'];
end

%%
fs =1000;
fsM=120;
%%
m = size(MotionData{1},1);
n = length(MotionData);
y = zeros(m,3*n); %creating matrix for cancat MotionData

for i_target=1:6
    for i_dim =1:3
        y(:,(i_target-1)*3 +i_dim) =MotionData{i_target}(:,i_dim);

    end
end


%% Pre-Processing
%CAR
temp =mean(signal,2);
signal = signal -repmat(temp,1,size(signal,2));

diffTime =diff(MotionTime); % figure out measure of error device Motion Capture is almost 1 ms 

%%
yy = y;
y =interp1(MotionTime ,y,ECoGTime);


plot(y(:,1));
figure
plot(yy(:,1),'r')

%% Feature Extraction 

[b1 ,a1] = butter(3 ,[8 30]/(fs/2),'bandpass'); % for Alpha & Beta 
[b2 ,a2] = butter(3 ,[30 70]/(fs/2),'bandpass'); %for Gamma band
[bs , as] = butter(3 ,2.5/(fs/2));% for Smoothing

x1 = filtfilt(b1,a1,signal);%feature extraction from signal of Alpha & Beta band
x2 = filtfilt(b2,a2,signal);%feature extraction from signal of Gamma band
%
tempx1 = abs(x1);
tempx2 = abs(x2);

x1_smooth = filtfilt(bs,as,tempx1);
x2_smooth = filtfilt(bs,as,tempx2);

x1=zscore(x1_smooth);
x2=zscore(x2_smooth);

x1 =downsample(x1,100);
x2 =downsample(x2 ,100);

%%
freqz(bs,as)
figure
freqz(b1,a1)

%%
y = filter(bs,as,y);
y = downsample(y,100);


%% step3: concat Feature
feature =[x1,x2];
feature =[feature , ones(size(x1,1),1)];

% 
target = y;

%% step4 : feature train & test
l = size(feature,1);

train =1:floor(0.7*l);
test =floor(0.7*l)+1:l;

featureTrain = feature(train,:);
featureTest =feature(test,:);

tragetTrain =target(train,:);
targetTest = target(test,:);

%% step5: Regression

R = featureTrain'*featureTrain/size(featureTrain,1) ;
P = featureTrain'*targetTrain /size(featureTrain,1) ;
w =inv(R)*P;

yhat =featureTest * w;


