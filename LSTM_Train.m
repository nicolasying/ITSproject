function [ w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,tmp_b_tc,tmp_s_tc ] = LSTM_Train( trainX,trainY,learning_rate,I,H,K )
%��ʼ������
w_il=rand(I,H)*2 - 1;  %���뵽input gateȨֵ
w_hl=rand(H,H)*2 - 1;  %cell�����input gateȨֵ
w_cl=rand(1,H)*2 - 1;  %cell��input gateȨֵ

w_if=rand(I,H)*2 - 1;  %���뵽forget gateȨֵ
w_hf=rand(H,H)*2 - 1;  %cell�����forget gateȨֵ
w_cf=rand(1,H)*2 - 1;  %cell��forget gateȨֵ

w_ic=rand(I,H)*2 - 1;  %���뵽cellȨֵ
w_hc=rand(H,H)*2 - 1;  %cell�����cellȨֵ

w_iw=rand(I,H)*2 - 1;  %���뵽output gateȨֵ
w_hw=rand(H,H)*2 - 1;  %cell�����output gateȨֵ
w_cw=rand(1,H)*2 - 1;  %cell��output gateȨֵ

w_ck=rand(H,K)*2 - 1;  %cell��������Ȩֵ

tmp_b_tc=zeros(I,H);
tmp_s_tc=zeros(I,H);

for i=1:1000 
    %ǰ�򴫲�
    [a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk,tmp_b_tc,tmp_s_tc] = LSTM_Forward( w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,trainX,tmp_b_tc,tmp_s_tc);
    %���򴫲�
    [w_il_grad,w_hl_grad,w_cl_grad,w_if_grad,w_hf_grad,w_cf_grad,w_ic_grad,w_hc_grad,w_iw_grad,w_hw_grad,w_cw_grad,w_ck_grad] = LSTM_Backpropagate(  w_cl, w_cf, w_hc, w_cw, w_ck, ... 
 a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk,trainX,trainY);
    %����Ȩֵ
    w_ck =  w_ck - learning_rate * w_ck_grad;
  
    w_il =  w_il - learning_rate * w_il_grad;
    w_hl =  w_hl - learning_rate * w_hl_grad;
    w_cl =  w_cl - learning_rate * w_cl_grad;
  
    w_if =  w_if - learning_rate * w_if_grad;
    w_hf =  w_hf - learning_rate * w_hf_grad;
    w_cf =  w_cf - learning_rate * w_cf_grad;
  
    w_ic =  w_ic - learning_rate * w_ic_grad;
    w_hc =  w_hc - learning_rate * w_hc_grad;
  
    w_iw =  w_iw - learning_rate * w_iw_grad;
    w_hw =  w_hw - learning_rate * w_hw_grad;
    w_cw =  w_cw - learning_rate * w_cw_grad;
   
end


end

