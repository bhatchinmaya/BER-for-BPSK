% BPSK BER curve 

N = 10.^6;                % number of input BPSK symbols
X = 2*(rand(1,N)>0.5)-1;  % generate N BPSK symbols

snr_db = 0:10;            % snr is varied from 0 to 10 db

for( i = 1:length(snr_db)) 
   
        variance(i) = (1/sqrt(2)) * (10.^-(snr_db(i)/20)); % Calculate the corresponding variance
        noise =  variance(i) * (randn(1,N)+j*randn(1,N));  % generate noise with given variance
        Received_signal = X + noise;                       % adding noise to input signal
        decode_signal = 2*(Received_signal > 0)-1;         
        find_bit_error = abs((X - decode_signal)/2);       % decoding received signal, Threshold is taken as '0'
        bit_error(i) = sum(find_bit_error)/N;              % calculating total error bits
end

h1=plot(bit_error,'*');                       % plot BER from monte-carlo simulations
hold on;
h2=plot(0.5*erfc(sqrt(1./(2*variance.^2))));  % plot theoretical BER for BPSK
legend([h1 h2],'simulation','theory');
title('BER for BPSK with equal input probability');
xlabel('SNR in db');
ylabel('Probability of error');
