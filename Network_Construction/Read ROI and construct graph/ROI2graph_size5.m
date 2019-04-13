function [ graphWithROIs ] = ROI2graph_size5(imageWithROIs)
%	generate graph from given ROI 
%   input: a ROI matrix where NaN indicates non-ROI region, 
%   output: a graph adjacent matrix 
%	Each node in the graph is a pixel in the ROI, and the
%   node connect to its adjacent 26 pixels, the weight of each edge is the intensity
%   difference between adjacent pixels

%	imageWithROI: ROI matrix
%	graph:adjacent matrix of a graph
% I = load('./DataNew/imageWithROIs.mat');
imageWithROIs = imageSUV;
seq = [-2,-1,0,1,2];
mask = zeros(125,3);
for i = 0:124
    
    a = rem(i,5) + 1;
    b = floor((i - floor(i / 25)*25)/5) + 1;
    c = floor(i/25) + 1;
    
    mask(i+1,:) = [seq(c),seq(b),seq(a)];
end

graphWithROIs = cell(size(imageWithROIs,1),1);
for idx = 1:length(imageWithROIs)
    idx
    imageWithROI = imageWithROIs{idx,1};
    [width,height,depth]=size(imageWithROI);
    
    map=zeros(width,height,depth);
    nNodes=0;
    for i=1:width
        for j=1:height
            for k=1:depth
                if (~(imageWithROI(i,j,k))==0)
                    nNodes=nNodes+1;
                    map(i,j,k)=nNodes;
                end
            end
        end
    end

    graph=zeros(nNodes,nNodes);
    for i=1:width
        for j=1:height
            for k=1:depth
                if (map(i,j,k)~=0)
                    node0=map(i,j,k);pixel0=imageWithROI(i,j,k);
                    for t=1:125
                        % ������ǰ�����Χ124������
                        ii=i+mask(t,1);jj=j+mask(t,2);kk=k+mask(t,3);
                        % ȷ������û��Խ��
                        if (ii>=1 && ii<=width && jj>=1 && jj<=height && kk>=1 && kk<=depth)
                            % �����ǰ��Χ����ֵ
                            if (map(ii,jj,kk)~=0)
                                % nodel ��Χ������
                                % pixel1 ��Χ���ǿ��
                                % ��һ�¼������ֵ ��������������Χ���ƫ�� bingo
                                node1=map(ii,jj,kk);pixel1=imageWithROI(ii,jj,kk);
                                % graph(i,j)�����Ϊi��pixel�����Ϊj��pixel֮���ƫ��ľ���ֵ
                                % �������Ǹ��Գ��� ��Ԫ��Ϊ0
                                if(abs(mask(t,1))==2 || abs(mask(t,2))==2 || abs(mask(t,3))==2)
                                    coeff = 2;
                                else
                                    coeff = 1;
                                end
                                graph(int16(node0),int16(node1))=coeff * abs(pixel0-pixel1);  
                            end
                        end
                    end
                end
            end
        end
    end
    graphWithROIs{idx,1} = graph;
end
save ./radiogenomics_PET/graphWithROIs.mat graphWithROIs -v7.3

end