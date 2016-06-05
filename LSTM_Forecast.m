function [ a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk ] = LSTM_Forecast( w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,X,tmp_b_tc,tmp_s_tc )
% ǰ�򴫲�
I=size(X,1);
H=size(w_ck,1);
K=size(w_ck,2);

T=size(X,2);

a_tl=zeros(I,H,T);
b_tl=zeros(I,H,T);

a_tf=zeros(I,H,T);
b_tf=zeros(I,H,T);

a_tc=zeros(I,H,T);
s_tc=zeros(I,H,T);

a_tw=zeros(I,H,T);
b_tw=zeros(I,H,T);

b_tc=zeros(I,H,T);

a_tk=zeros(I,K,T);
b_tk=zeros(I,K,T);

for t=1:size(X,2)
    if(t==1)
        a_tl(:,:,t)=X(:,t)*w_il + tmp_b_tc*w_hl + tmp_s_tc.*w_cl;  %ÿһ��������Զ�ÿ��input gate��Ȩֵ + ÿһ��input gate��Ӧ��һ��ʱ�̵�����cell����� + ÿһ��input gate��Ӧ��һ��ʱ������cell��״̬
        b_tl(:,:,t)=Sigmoid(a_tl(:,:,t));
        
        a_tf(:,:,t)=X(:,t)*w_if + tmp_b_tc*w_hf + tmp_s_tc.*w_cf;  %ÿһ��������Զ�ÿ��forget gate��Ȩֵ + ÿһ��forget gate��Ӧ��һ��ʱ�̵�����cell����� + ÿһ��forget gate��Ӧ��һ��ʱ������cell��״̬
        b_tf(:,:,t)=Sigmoid(a_tf(:,:,t));
        
        a_tc(:,:,t)=X(:,t)*w_ic + tmp_b_tc*w_hc;  %ÿһ��������Զ�ÿ��cell��Ȩֵ + ÿһ��cell��Ӧ��һ��ʱ�̵�����cell�����
        s_tc(:,:,t)=b_tf(:,:,t).*tmp_s_tc + b_tl(:,:,t).*Sigmoid2(a_tc(:,:,t));  %ÿһ��forget gate�����������һ��ʱ��cell��״̬ + ÿһ��input gate���������ͨ��g������ÿһ��ʱ�̵�cell������
        
        a_tw(:,:,t)=X(:,t)*w_iw + s_tc(:,:,t).*w_cw + tmp_b_tc*w_hw;  %ÿһ��������Զ�Ӧÿ��output gate��Ȩֵ + ÿһ��output gate��Ӧ����cell��״̬ + ÿһ��output gate��Ӧ����cell��һ��ʱ�̵����
        b_tw(:,:,t)=Sigmoid(a_tw(:,:,t));
        
        b_tc(:,:,t)=b_tw(:,:,t).*Sigmoid3(s_tc(:,:,t));  %h����
        
        a_tk(:,:,t)=b_tc(:,:,t)*w_ck;
        b_tk(:,:,t)=Sigmoid(a_tk(:,:,t));
    else
        a_tl(:,:,t)=X(:,t)*w_il + b_tc(:,:,t-1)*w_hl + s_tc(:,:,t-1).*w_cl;  %ÿһ��������Զ�ÿ��input gate��Ȩֵ + ÿһ��input gate��Ӧ��һ��ʱ�̵�����cell����� + ÿһ��input gate��Ӧ��һ��ʱ������cell��״̬
        b_tl(:,:,t)=Sigmoid(a_tl(:,:,t));
        
        a_tf(:,:,t)=X(:,t)*w_if + b_tc(:,:,t-1)*w_hf + s_tc(:,:,t-1).*w_cf;  %ÿһ��������Զ�ÿ��forget gate��Ȩֵ + ÿһ��forget gate��Ӧ��һ��ʱ�̵�����cell����� + ÿһ��forget gate��Ӧ��һ��ʱ������cell��״̬
        b_tf(:,:,t)=Sigmoid(a_tf(:,:,t));
        
        a_tc(:,:,t)=X(:,t)*w_ic + b_tc(:,:,t-1)*w_hc;  %ÿһ��������Զ�ÿ��cell��Ȩֵ + ÿһ��cell��Ӧ��һ��ʱ�̵�����cell�����
        s_tc(:,:,t)=b_tf(:,:,t).*s_tc(:,:,t-1) + b_tl(:,:,t).*Sigmoid2(a_tc(:,:,t));  %ÿһ��forget gate�����������һ��ʱ��cell��״̬ + ÿһ��input gate���������ͨ��g������ÿһ��ʱ�̵�cell������
        
        a_tw(:,:,t)=X(:,t)*w_iw + s_tc(:,:,t).*w_cw + b_tc(:,:,t-1)*w_hw;  %ÿһ��������Զ�Ӧÿ��output gate��Ȩֵ + ÿһ��output gate��Ӧ����cell��״̬ + ÿһ��output gate��Ӧ����cell��һ��ʱ�̵����
        b_tw(:,:,t)=Sigmoid(a_tw(:,:,t));
        
        b_tc(:,:,t)=b_tw(:,:,t).*Sigmoid3(s_tc(:,:,t));  %h����
        
        a_tk(:,:,t)=b_tc(:,:,t)*w_ck;
        b_tk(:,:,t)=Sigmoid(a_tk(:,:,t));
        
    end
    
end
    
        
end

