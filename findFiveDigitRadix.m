% The "base prime" number system has a problem: How does one represent a
% number such as 2^10, where we don't have a digit to represent 10
% (note that 10_p would simply be 3^1 * 2^0 = 3). We could use A to
% represent 10 and extend our number writing system, like hexadecimal, but
% we'd still run out. I have this "registry" of what symbols to use for
% digits which is iterated through.

global registry;
registry = '0123456789';
% registry = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

% Given a number abcde_p, find the radix of equivalency
function radix = fiveDigitRadix(a,b,c,d,e)
    % where abc_p = abc_r
    syms r
    eqn = (2^e) * (3^d) * (5^c) * (7^b) * (11^a) == a*r^4 + b*r^3 + c*r^2 + d*r + e;
    radix = solve(eqn, r, 'MaxDegree', 4, 'Real', true);
end

% Takes a number and returns its digit as a string w/ the registry
function str = stringify(n)
    % array indices start at 1 :(
    global registry;
    str = registry(n + 1);
end

% Function just for printing results
function printFiveDigitResult(l,m,n,o,p,radix)
    val = 2^p * 3^o * 5^n * 7^m * 11^l;
    disp(append(stringify(l), stringify(m), stringify(n), stringify(o), stringify(p), "_p is equivalent in base ", string(radix), ", which in decimal is ", string(val)))
end

% Iterate through lmnop for all values 0 to max value from registry
for l = 0:(length(registry) - 1)
    for m = 0:(length(registry) - 1)
        disp("SEARCHING THE " + stringify(l) + stringify(m) + "000s...")
        for n = 0:(length(registry) - 1)
            for o = 0:(length(registry) - 1)
                for p = 0:(length(registry) - 1)
                    radix = fiveDigitRadix(l,m,n,o,p);
                    if isInteger(radix) | floor(radix) == radix
                        printFiveDigitResult(l,m,n,o,p,radix)
                    end
                end
            end
        end
    end
end
