% client 发送方Sender
% 设置网络IP后，即可发送信息至指定服务端。
% Author： 380545156@qq.com
% Date: Aug 3rd, 2020

% Prepare data for transmiss
% 一个来自从图像中识别出来的目标的信息表现
Image_ID = 2233; % int
BBox_2D = [911 513 95 118] % 1*4 double
BBox_3D = [911 513 500 95 118 120]  % 1*6 double
Object_type = 'boat'   % string
Azi_2D = 283.92  % double;
Azi_3D = [0.5774 0.5774 0.5774] % 1*3 double
Dist_Center = 1564.9;  % double
Dist_3D = 1564.9;  % double

% t_client = tcpip('192.168.88.60',30000,'NetworkRole','client') %与本地主机建立连接，端口号为30000，作为客户机连接
t_client = tcpip('127.0.0.1',8090,'NetworkRole','client')
% t_client = tcpip('localhost',30000,'NetworkRole','client') %与本地主机建立连接，端口号为30000，作为客户机连接

t_client.OutputBuffersize = 1000000
fopen(t_client);                                              %与一个服务器建立连接，直到建立完成返回，否则报错
% 需要对
OD_Result_send =  strcat(num2str(Image_ID),',',num2str(BBox_2D(1)),',',num2str(BBox_2D(2)),',',num2str(BBox_2D(3)),',',num2str(BBox_2D(4)),',',...
    num2str(BBox_3D(1)),',',num2str(BBox_3D(2)),',',num2str(BBox_3D(3)),',',num2str(BBox_3D(4)),',',num2str(BBox_3D(5)),',',num2str(BBox_3D(6)),',',...
    Object_type,',',num2str(Azi_2D),',',num2str(Azi_3D(1)),',',num2str(Azi_3D(2)),',',num2str(Azi_3D(3)),',',num2str(Dist_Center),',',num2str(Dist_3D))
data_send = [200 10000  100000  ]                                              % 发送的数字数据
txt_send = 'HELLO'                                           % 发送的文本数据
% pause(0.1);                                                % 等待连接稳定，随意设置
% fprintf(t_client,data_send)  
fwrite(t_client,data_send,'uint16')                             % 写入数字数据
% pause(0.5);
fprintf(t_client,OD_Result_send)                             % 发送文本数据
fclose(t_client)