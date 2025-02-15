function chirpSignal = createChirpFcn(opts)

% returns a structure with a linear chirp signal and time vector for user
% defined inputs

arguments
    opts.startFreq_Hz    (1, 1) double   = 5
    opts.endFreq_Hz      (1, 1) double   = 20
    opts.offset_nd       (1, 1) double   = 0
    opts.magnitude_nd    (1, 1) double   = 1
    opts.ts_s            (1, 1) double   = 0.001
    opts.timeDuration_s  (1, 1) double   = 10
    opts.isShowPlot      (1, 1) logical  = false
    opts.isPlaySoud      (1, 1) logical  = false
end

assert(1/opts.ts_s >= 20 * opts.endFreq_Hz, ...
    "End (high) frequency too high for given time step !!! " + ...
    "Suggested time step = %.6f s", 1/(20 * opts.endFreq_Hz))

time_s = (0:  opts.ts_s : opts.timeDuration_s)';

% initialize outputs
chirpSignal.signal = 0 * time_s;
chirpSignal.time_s = 0 * time_s;

% Generate chirp signal
chirpSignal.signal = opts.offset_nd + opts.magnitude_nd * chirp(time_s, opts.startFreq_Hz, opts.timeDuration_s, opts.endFreq_Hz, 'linear');
chirpSignal.time_s = time_s;

if opts.isShowPlot
    % Plot the chirp signal
    figure;
    plot(time_s, chirpSignal);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(compose("Linear Chirp Signal %.2f - %.2f Hz", opts.startFreq_Hz, opts.endFreq_Hz));
    grid on;
end

if opts.isPlaySoud
    % Play the sound
    sound(chirpSignal, 1/opts.ts_s);
end
end