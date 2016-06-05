function [ w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,tmp_b_tc,tmp_s_tc ] = LSTM_Train( trainX,trainY,learning_rate,I,H,K )
%初始化参数
w_il=rand(I,H)*2 - 1;  %输入到input gate权值
w_hl=rand(H,H)*2 - 1;  %cell输出到input gate权值
w_cl=rand(1,H)*2 - 1;  %cell到input gate权值

w_if=rand(I,H)*2 - 1;  %输入到forget gate权值
w_hf=rand(H,H)*2 - 1;  %cell输出到forget gate权值
w_cf=rand(1,H)*2 - 1;  %cell到forget gate权值

w_ic=rand(I,H)*2 - 1;  %输入到cell权值
w_hc=rand(H,H)*2 - 1;  %cell输出到cell权值

w_iw=rand(I,H)*2 - 1;  %输入到output gate权值
w_hw=rand(H,H)*2 - 1;  %cell输出到output gate权值
w_cw=rand(1,H)*2 - 1;  %cell到output gate权值

w_ck=rand(H,K)*2 - 1;  %cell输出到输出权值

tmp_b_tc=zeros(I,H);
tmp_s_tc=zeros(I,H);

for i=1:1000 
    %前向传播
    [a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk,tmp_b_tc,tmp_s_tc] = LSTM_Forward( w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,trainX,tmp_b_tc,tmp_s_tc);
    %后向传播
    [w_il_grad,w_hl_grad,w_cl_grad,w_if_grad,w_hf_grad,w_cf_grad,w_ic_grad,w_hc_grad,w_iw_grad,w_hw_grad,w_cw_grad,w_ck_grad] = LSTM_Backpropagate(  w_cl, w_cf, w_hc, w_cw, w_ck, ... 
 a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk,trainX,trainY);
    %更新权值
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

