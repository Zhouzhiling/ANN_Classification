function [gradx, grady, gradz, grad, dir] = ComputeSobelGrad(patch_1)

	patch_1 = rescale(patch_1,0,1);
%	patch = randi([0,255],3,3,3);
%	sum(sum(patch(:,:,1)))
%	sum(sum(patch(:,:,3)))
	
	%����sobel z�����ݶ�ģ��
	hz(:,:,1) = [-1,-2,-1;-2,-4,-2;-1,-2,-1];
	hz(:,:,2) = zeros(3,3);
	hz(:,:,3) = hz(:,:,1) .* -1;

	% x direction and y direction
	hx=permute(hz,[3 2 1]);
	hy=permute(hz,[1 3 2]);                    

	gradx=imfilter(patch_1,hx,'same');
	gradx=abs(gradx); %����ͼ���sobel��ֱ�ݶ�

	grady=imfilter(patch_1,hy,'same');
	grady=abs(grady); %����ͼ���sobelˮƽ�ݶ�

	gradz=imfilter(patch_1,hz,'same');
	gradz=abs(gradz); %����ͼ���sobelˮƽ�ݶ�

	grad=sqrt(gradx.^2+grady.^2+gradz.^2);  %�õ�ͼ���sobel�ݶ�
	[theta,rho,z] = cart2pol(gradx,grady,gradz);

	dir = Classifyinto8Octant(theta,rho,z);
end