syms x y sigma k
G = 1 / (2*pi*sigma^2) * exp(-(x^2+y^2)/(2*sigma^2))
Gk = 1 / (2*pi*(sigma*k)^2) * exp(-(x^2+y^2)/(2*(sigma*k)^2))

fxx = simplify(diff(G,x,x))
fyy = simplify(diff(G,y,y))
fyx = simplify(diff(G,y,x))

fx = simplify(diff(G,x))
fy = simplify(diff(G,y))

dog = simplify(Gk - G)
