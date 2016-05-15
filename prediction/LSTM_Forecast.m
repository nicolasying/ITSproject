function [ a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk ] = LSTM_Forecast( w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,X,tmp_b_tc,tmp_s_tc )
% 前向传播
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
        a_tl(:,:,t)=X(:,t)*w_il + tmp_b_tc*w_hl + tmp_s_tc.*w_cl;  %每一个输入乘以对每个input gate的权值 + 每一个input gate对应上一个时刻的所有cell的输出 + 每一个input gate对应上一个时刻所有cell的状态
        b_tl(:,:,t)=Sigmoid(a_tl(:,:,t));
        
        a_tf(:,:,t)=X(:,t)*w_if + tmp_b_tc*w_hf + tmp_s_tc.*w_cf;  %每一个输入乘以对每个forget gate的权值 + 每一个forget gate对应上一个时刻的所有cell的输出 + 每一个forget gate对应上一个时刻所有cell的状态
        b_tf(:,:,t)=Sigmoid(a_tf(:,:,t));
        
        a_tc(:,:,t)=X(:,t)*w_ic + tmp_b_tc*w_hc;  %每一个输入乘以对每个cell的权值 + 每一个cell对应上一个时刻的所有cell的输出
        s_tc(:,:,t)=b_tf(:,:,t).*tmp_s_tc + b_tl(:,:,t).*Sigmoid2(a_tc(:,:,t));  %每一个forget gate的输出乘以上一个时刻cell的状态 + 每一个input gate的输出乘以通过g函数的每一个时刻的cell的输入
        
        a_tw(:,:,t)=X(:,t)*w_iw + s_tc(:,:,t).*w_cw + tmp_b_tc*w_hw;  %每一个输入乘以对应每个output gate的权值 + 每一个output gate对应所有cell的状态 + 每一个output gate对应所有cell上一个时刻的输出
        b_tw(:,:,t)=Sigmoid(a_tw(:,:,t));
        
        b_tc(:,:,t)=b_tw(:,:,t).*Sigmoid3(s_tc(:,:,t));  %h函数
        
        a_tk(:,:,t)=b_tc(:,:,t)*w_ck;
        b_tk(:,:,t)=Sigmoid(a_tk(:,:,t));
    else
        a_tl(:,:,t)=X(:,t)*w_il + b_tc(:,:,t-1)*w_hl + s_tc(:,:,t-1).*w_cl;  %每一个输入乘以对每个input gate的权值 + 每一个input gate对应上一个时刻的所有cell的输出 + 每一个input gate对应上一个时刻所有cell的状态
        b_tl(:,:,t)=Sigmoid(a_tl(:,:,t));
        
        a_tf(:,:,t)=X(:,t)*w_if + b_tc(:,:,t-1)*w_hf + s_tc(:,:,t-1).*w_cf;  %每一个输入乘以对每个forget gate的权值 + 每一个forget gate对应上一个时刻的所有cell的输出 + 每一个forget gate对应上一个时刻所有cell的状态
        b_tf(:,:,t)=Sigmoid(a_tf(:,:,t));
        
        a_tc(:,:,t)=X(:,t)*w_ic + b_tc(:,:,t-1)*w_hc;  %每一个输入乘以对每个cell的权值 + 每一个cell对应上一个时刻的所有cell的输出
        s_tc(:,:,t)=b_tf(:,:,t).*s_tc(:,:,t-1) + b_tl(:,:,t).*Sigmoid2(a_tc(:,:,t));  %每一个forget gate的输出乘以上一个时刻cell的状态 + 每一个input gate的输出乘以通过g函数的每一个时刻的cell的输入
        
        a_tw(:,:,t)=X(:,t)*w_iw + s_tc(:,:,t).*w_cw + b_tc(:,:,t-1)*w_hw;  %每一个输入乘以对应每个output gate的权值 + 每一个output gate对应所有cell的状态 + 每一个output gate对应所有cell上一个时刻的输出
        b_tw(:,:,t)=Sigmoid(a_tw(:,:,t));
        
        b_tc(:,:,t)=b_tw(:,:,t).*Sigmoid3(s_tc(:,:,t));  %h函数
        
        a_tk(:,:,t)=b_tc(:,:,t)*w_ck;
        b_tk(:,:,t)=Sigmoid(a_tk(:,:,t));
        
    end
    
end
    
        
end

