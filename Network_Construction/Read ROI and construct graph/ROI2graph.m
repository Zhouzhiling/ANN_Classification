function [ graph ] = ROI2graph(imageWithROI)
%	generate graph from given ROI 
%   input: a ROI matrix where NaN indicates non-ROI region, 
%   output: a graph adjacent matrix 
%	Each node in the graph is a pixel in the ROI, and the
%   node connect to its adjacent 26 pixels, the weight of each edge is the intensity
%   difference between adjacent pixels

%	imageWithROI: ROI matrix
%	graph:adjacent matrix of a graph
mask=[-1,1,1;0,1,1;1,1,1;-1,0,1;0,0,1;1,0,1;-1,-1,1;0,-1,1;1,-1,1;...
    -1,1,0;0,1,0;1,1,0;-1,0,0;0,0,0;1,0,0;-1,-1,0;0,-1,0;1,-1,0;...
    -1,1,-1;0,1,-1;1,1,-1;-1,0,-1;0,0,-1;1,0,-1;-1,-1,-1;0,-1,-1;1,-1,-1;];

[width,height,depth]=size(imageWithROI);

map=zeros(width,height,depth);
nNodes=0;
for i=1:width
    for j=1:height
        for k=1:depth
            if (isnan(imageWithROI(i,j,k))==false)
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
                for t=1:27
                    % ������ǰ�����Χ9+8+9=26������
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
                            graph(int16(node0),int16(node1))=abs(pixel0-pixel1);  
                        end
                    end
                end
            end
        end
    end
end
end


