function [  w_il_grad,w_hl_grad,w_cl_grad,w_if_grad,w_hf_grad,w_cf_grad,w_ic_grad,w_hc_grad,w_iw_grad,w_hw_grad,w_cw_grad,w_ck_grad ] = LSTM_Backpropagate(  w_cl, w_cf, w_hc, w_cw, w_ck, ... 
 a_tl,b_tl,a_tf,b_tf,a_tc,s_tc,a_tw,b_tw,b_tc,a_tk,b_tk,X,z )
%后向传播  
I=size(X,1);
H=size(w_ck,1);
K=size(w_ck,2);

T=size(X,2);

delta_tk = zeros(I,K,T);
e_tc     = zeros(I,H,T);
delta_tw = zeros(I,H,T);
e_ts     = zeros(I,H,T);
delta_tc = zeros(I,H,T);
delta_tf = zeros(I,H,T);
delta_tl = zeros(I,H,T);

w_il_grad = zeros(I,H);
w_hl_grad = zeros(H,H);
w_cl_grad = zeros(1,H);

w_if_grad = zeros(I,H);
w_hf_grad = zeros(H,H);
w_cf_grad = zeros(1,H);

w_ic_grad = zeros(I,H);
w_hc_grad = zeros(H,H);

w_iw_grad = zeros(I,H);
w_hw_grad = zeros(H,H);
w_cw_grad = zeros(1,H);

w_ck_grad = zeros(H,K);

for t = size(X,2):-1:1
  if (t == size(X,2))
      
      delta_tk(:,:,t) = SigmoidGradient(a_tk(:,:,t))*(b_tk(:,:,t) - z(:,t));  %输出残差
    
      e_tc(:,:,t) = delta_tk(:,:,t) * w_ck'; %对应每一个cell
    
      delta_tw(:,:,t) = SigmoidGradient(a_tw(:,:,t)) .* (Sigmoid3(s_tc(:,:,t)) .* e_tc(:,:,t)); %output gate残差 h函数
    
      e_ts(:,:,t) = b_tw(:,:,t) .* SigmoidGradient3(s_tc(:,:,t)) .* e_tc(:,:,t) + delta_tw(:,:,t).* w_cw; %对应每一个cell
    
      delta_tc(:,:,t) = b_tl(:,:,t) .* SigmoidGradient2(a_tc(:,:,t)) .* e_ts(:,:,t); %cell残差 g函数导数 
    
      delta_tf(:,:,t) = SigmoidGradient(a_tf(:,:,t)) .* (s_tc(:,:,t-1) .* e_ts(:,:,t)); %forget gate残差
    
      delta_tl(:,:,t) = SigmoidGradient(a_tl(:,:,t)) .* (Sigmoid2(a_tc(:,:,t)) .* e_ts(:,:,t)); %input gate残差
  else 
      delta_tk(:,:,t) = SigmoidGradient(a_tk(:,:,t))*(b_tk(:,:,t) - z(:,t));  %输出残差
    
      e_tc(:,:,t) = delta_tk(:,:,t) * w_ck' + delta_tl(:,:,t+1).* w_cl + ...
      delta_tf(:,:,t+1).* w_cf + delta_tc(:,:,t+1) * w_hc' + delta_tw(:,:,t+1).* w_cw;   %这里！！！！w_hc要不要转置？？？？？？
    
      delta_tw(:,:,t) = SigmoidGradient(a_tw(:,:,t)) .* (Sigmoid3(s_tc(:,:,t)) .* e_tc(:,:,t));
    
      e_ts(:,:,t) = b_tw(:,:,t) .* SigmoidGradient3(s_tc(:,:,t)) .* e_tc(:,:,t) + b_tf(:,:,t+1) .* e_ts(:,:,t+1) + delta_tl(:,:,t + 1).* w_cl + delta_tf(:,:,t+1).* w_cf + delta_tw(:,:,t).* w_cw;                       %h函数导数
    
      delta_tc(:,:,t) = b_tl(:,:,t) .* SigmoidGradient2(a_tc(:,:,t)) .* e_ts(:,:,t);   %g函数导数
    
    if (t == 1)
      delta_tf(:,:,t) = 0;
    else
      delta_tf(:,:,t) = SigmoidGradient(a_tf(:,:,t)) .* (s_tc(:,:,t-1) .* e_ts(:,:,t));
    end
    
      delta_tl(:,:,t) = SigmoidGradient(a_tl(:,:,t)) .* (Sigmoid2(a_tc(:,:,t)) .* e_ts(:,:,t)); %g函数
  end
end
  
for t = 1:size(X,2)
  if (t == 1)
    w_il_grad = w_il_grad + X(:,t) * delta_tl(:,:,t);
    w_hl_grad = w_hl_grad + 0;
    w_cl_grad = w_cl_grad + 0;
    
    w_if_grad = w_if_grad + X(:,t) * delta_tf(:,:,t);
    w_hf_grad = w_hf_grad + 0;
    w_cf_grad = w_cf_grad + 0;
    
    w_ic_grad = w_ic_grad + X(:,t) * delta_tc(:,:,t);
    w_hc_grad = w_hc_grad + 0;
    
    w_iw_grad = w_iw_grad + X(:,t) * delta_tw(:,:,t);
    w_hw_grad = w_hw_grad + 0;
    w_cw_grad = w_cw_grad + s_tc(:,:,t).* delta_tw(:,:,t);
    
    w_ck_grad = w_ck_grad + b_tc(:,:,t)' * delta_tk(:,:,t);
  else
    w_il_grad = w_il_grad + X(:,t) * delta_tl(:,:,t);
    w_hl_grad = w_hl_grad + b_tc(:,:,t-1)' * delta_tl(:,:,t);
    w_cl_grad = w_cl_grad + s_tc(:,:,t-1).* delta_tl(:,:,t);
    
    w_if_grad = w_if_grad + X(:,t) * delta_tf(:,:,t);
    w_hf_grad = w_hf_grad + b_tc(:,:,t-1)' * delta_tf(:,:,t);
    w_cf_grad = w_cf_grad + s_tc(:,:,t-1).* delta_tf(:,:,t);
    
    w_ic_grad = w_ic_grad + X(:,t) * delta_tc(:,:,t);
    w_hc_grad = w_hc_grad + b_tc(:,:,t-1)' * delta_tc(:,:,t);
    
    w_iw_grad = w_iw_grad + X(:,t) * delta_tw(:,:,t);
    w_hw_grad = w_hw_grad + b_tc(:,:,t-1)' * delta_tw(:,:,t);
    w_cw_grad = w_cw_grad + s_tc(:,:,t).* delta_tw(:,:,t);
    
    w_ck_grad = w_ck_grad + b_tc(:,:,t)' * delta_tk(:,:,t);
  end
end
end

