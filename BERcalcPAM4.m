function [BER,f] = BERcalcPAM4(A)

refseq = [0 0 0 1 0 0 1 1 0 1 0 1 1 1 1]';              % Pattern used to compare with the tx sequence
V_pulse = A(:,3)*10;
T_pulse = (A(:,2)+abs(A(1,2)));
V = A(:,5);
T = (A(:,4)+abs(A(1,2)));
vlevels4 = [0; 2.6; 5 ; 7.6];                           % Voltage Levels (PAM-4)
blevels = [0; 1; 2; 3];                                 % Bit Level

% Finding the period and frequency of the plot
diff_lowlevel = find(diff(V_pulse)<-1.6);                 % Find falling edges on pulse
highlowstart = diff_lowlevel(1)+1;                      % First high-low on pulse
nextlow = diff_lowlevel(2)+1;                           % Second high-low on pulse
if nextlow - highlowstart < 3
    nextlow = diff_lowlevel(3)+1;
end

period_time = T_pulse(nextlow) - T_pulse(highlowstart); % Period of Output in sec
f = 1/period_time;                                      % Convert to frequency in Hz            
%plot(T,V,'b',T_pulse,V_pulse,'r');

% Finding sampling points (middle of each period)
T_sample = diff_lowlevel+1;
V_sample = zeros(1,length(T_sample));                           % Stores voltages sampled at sampling points
Pulse_sample = zeros(1,length(T_sample));                       % Debug variable to see sample points on pulse
V_level = zeros(1,length(V_sample));                            % Stores closest reference voltage levels to sampled voltages
B_level = zeros(1,length(V_level));                             % Converts reference voltage levels to corresponding bit levels

% Taking Voltage Value at each sampling point
for n = 1:length(T_sample)
    V_sample(n) = V(T_sample(n));
    Pulse_sample(n) = V_pulse(T_sample(n));
end
plot(T,V,'b',T_pulse,V_pulse,'r',T(T_sample),V_sample,'g*',T(T_sample),Pulse_sample,'c*');

% Determining closest accurate voltage level
for i = 1:length(V_sample)
    [decval,decidx] = min(abs(vlevels4 - V_sample(i)));
    V_level(i) = vlevels4(decidx);
end

% Determining corresponding bit level
for m = 1:length(V_level)
    B_level(m) = blevels(find(vlevels4 == V_level(m)));
end 

% Determining sequence from bit levels
txseq = de2bi(B_level);
txseq = txseq(:,end);               % Sequence can be taken from the LSB of the bit level 

% Finding correct sequence
refshift = zeros(length(refseq),1);
for p = 1:length(refshift)
   refshift(p) = sum(abs(txseq(1:15,1)-circshift(refseq,p)),'all'); 
end
rightseq = circshift(refseq,find(refshift == min(refshift)));
rightseq = repmat(rightseq,ceil(length(txseq)/length(refseq)),1);
rightseq(length(txseq)+1:end) = [];
no_errbits = sum(abs(txseq-rightseq),'all');
BER = no_errbits/length(txseq);     % Bit Error Rate Calculation     
end
