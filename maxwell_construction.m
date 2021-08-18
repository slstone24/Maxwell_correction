clear
close all

%% init 
v1 = 0.5; % liquid phase vol
v2 = 50; % gas phase vol
N = 1000; %resolution


%% T = 0.95
T1 = 0.95; % user defined temp input

%define domain and isotherm
v = linspace(v1, v2, N);
p_vals1 = ((8 * T1) ./ (3 .* v - 1)) - 3 ./ v.^2;

%find local max and min
p1_min_vals = islocalmin(p_vals1);
p1_max_vals = islocalmax(p_vals1);

for i = 1:length(p1_min_vals)
    if p1_min_vals(i) == 1
        p1min = p_vals1(i);
        p1min_idx = i;
    end
    if p1_max_vals(i) == 1
        p1max = p_vals1(i);
        p1max_idx = i;
    end
end

%initialize step to loop through different p_eq and calculate areas
step = 0.00001;
n = ((p1max - p1min) / step) + 1;
p_eq_vals = linspace(p1min,p1max,n);
area1 = ones(1,round(n)-1);
area2 = ones(1,round(n)-1);
eq_area_vals = ones(1,round(n)-1);

%loop through all p_eq vals
maxwell_vals = ones(1,round(n)-1);
for k = 1:length(p_eq_vals)
    maxwell_vals(k) = equal_area(p_eq_vals(k), T1);
end

%find minimum area value
min_idx = find(maxwell_vals == min(maxwell_vals));
p_eq_min = p_eq_vals(min_idx) * ones(1,N);
correction = maxwell_vals(min_idx);

%plot isotherm along with optimized p_eq
figure(1)
plot(v,p_vals1);
hold on
plot(v, p_eq_min);
ylabel('p = p/p-critical');
xlabel('v = v/v-critical');
title(['vdW Isotherm p(v) for T  = ' num2str(T1)]);
ylim([0.5 1.5]);
xlim([0.5 4.5]);

%isolate area of isotherm to be corrected & plot correction
[~,vr,p] = equal_area(p_eq_vals(min_idx),T1);
figure(2)
vr_c = [v(v <= vr(1)) vr(1) vr(3) v(v >= vr(3))];
pr_c = [p_vals1(v <= vr(1)) p(vr(1)) p(vr(3)) p_vals1(v >= vr(3))]; 
plot(vr_c, pr_c);
ylabel('p = p/p-critical');
xlabel('v = v/v-critical');
title(['vdW Isotherm p(v) for T  = ' num2str(T1) ...
    ' with Maxwell Correction']);
ylim([0.5 1.5]);
xlim([0.5 4.5]);
    
%% T = 0.8
T2 = 0.8;

%define domain and isotherm
v = linspace(v1, v2, N);
p_vals2 = ((8 * T2) ./ (3 .* v - 1)) - 3 ./ v.^2;

%find local max and min
p2_min_vals = islocalmin(p_vals2);
p2_max_vals = islocalmax(p_vals2);

for i = 1:length(p2_min_vals)
    if p2_min_vals(i) == 1
        p2min = p_vals2(i);
        p2min_idx = i;
    end
    if p2_max_vals(i) == 1
        p2max = p_vals2(i);
        p2max_idx = i;
    end
end

%initialize step to loop through different p_eq and calculate areas
step = 0.001;
n = ((p2max - p2min) / step) + 1;
p_eq_vals = linspace(p2min,p2max,n);
area1 = ones(1,round(n)-1);
area2 = ones(1,round(n)-1);
eq_area_vals = ones(1,round(n)-1);

%loop through all p_eq vals
maxwell_vals = ones(1,round(n)-1);
for k = 1:length(p_eq_vals)
    maxwell_vals(k) = equal_area(p_eq_vals(k), T2);
end

%find minimum area value
min_idx = find(maxwell_vals == min(maxwell_vals));
p_eq_min = p_eq_vals(min_idx) * ones(1,N);
correction = maxwell_vals(min_idx);

%plot isotherm along with optimized p_eq
figure(3)
plot(v,p_vals2);
hold on
plot(v, p_eq_min);
ylabel('p = p/p-critical');
xlabel('v = v/v-critical');
title(['vdW Isotherm p(v) for T  = ' num2str(T2)]);
ylim([-0.4 0.8]);
xlim([0 5]);

%isolate area of isotherm to be corrected & plot correction
[~,vr,p] = equal_area(p_eq_vals(min_idx),T2);
figure(4)
vr_c = [v(v <= vr(1)) vr(1) vr(3) v(v >= vr(3))];
pr_c = [p_vals2(v <= vr(1)) p(vr(1)) p(vr(3)) p_vals2(v >= vr(3))]; 
plot(vr_c, pr_c);
ylabel('p = p/p-critical');
xlabel('v = v/v-critical');
title(['vdW Isotherm p(v) for T  = ' num2str(T2) ...
    ' with Maxwell Correction']);

