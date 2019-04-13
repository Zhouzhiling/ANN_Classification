function [ mat ] = cell2matrix( cell )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    in = dataset.graphWithROIs;
    caseNum = length(in);
    %caseNum = 30;
    % �����ҵ�����������Ŀ
    max = 0;
    for i = 1:caseNum
        if(length(in{i,1})>max)
            max = length(in{i,1});
        end
    end
    
    % ������������
    mat = NaN(max,max,caseNum);
    for i=1:caseNum
        cursize = length(in{i,1});
        for j=1:cursize
            for k=1:cursize
                mat(j,k,i) = in{i,1}(j,k);
            end
        end
    end
end

%% ֱ�Ӷ�graph/image- WithROIs ÿ��case��ֵȡƽ��

load imageWithROIs.mat
load graphWithROIs.mat


caseNum = length(imageWithROIs);
addInfo = zeros(caseNum, 5);
%caseNum = 30;
% �����ҵ�����������Ŀ
for i = 1:caseNum
    addInfo(i,1:3) = mean(imageWithROIs{i,1}(:,1:3));
    addInfo(i,4) = mean(imageWithROIs{i,1}(:,4));
    addInfo(i,5) = mean(imageWithROIs{i,1}(:,4));
end
