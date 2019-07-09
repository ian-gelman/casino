% Casino algorithm - Ian Gelman
% pull out game when lol?

iter = 100;                                             % # of rounds to simulate
start_bread = 800;                                      % Starting with $800
shove_pct = 7/8;                                        % Pctage of current money you 
                                                        % take home every round

pocket_bread = zeros(1,iter);                           % Money you currently have

pocket_bread(1) = start_bread - (start_bread*shove_pct);  % Init pocket bread
takehome_bread = zeros(1,iter);                         % Money you are taking home
takehome_bread(1) = start_bread - pocket_bread(1);        % Init takehome bread
the_game = rand(1,iter)-.5;                             % 2 to 1 odds

for i = 1:iter-1
    if the_game(i) < 0  % if you lose, take the shove percentage from your stash,      
        pocket_bread(i+1) = (1-shove_pct)*takehome_bread(i); %stay in the game, and deduct it from your takehome
        takehome_bread(i+1) = takehome_bread(i)-((1-shove_pct)*takehome_bread(i));                                                
    else % payout 1:1, and keep going.
        pocket_bread(i+1) = (2*pocket_bread(i))*(1-shove_pct);
        takehome_bread(i+1) = takehome_bread(i)+(shove_pct*2*pocket_bread(i));
    end
    if takehome_bread(i+1) <= 1 % if you're taking home less than a dollar
        disp('you lost all your money')
        break;
    end
end

plot(pocket_bread)
hold on
plot(takehome_bread)
hold off
title('What happens if you always bet on black? (Shoving 87.5%)')
xlabel('Round #')
ylabel('Money ($)')
legend('Money to bet with', 'Money to keep')
