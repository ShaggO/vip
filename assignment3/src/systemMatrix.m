function M = systemMatrix(ncurve, alpha, beta, tau)

    % Compute system matrix components
    A = tau * beta;
    B = -tau * (alpha + 4 * beta);
    C = 1 + tau * (2 * alpha + 6 * beta);

    % Initialize system matrix
    M = toeplitz([C, B, A, zeros(1,ncurve-5), A, B]);
end
