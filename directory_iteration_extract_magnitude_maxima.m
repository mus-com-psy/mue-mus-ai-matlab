function directory_iteration_extract_magnitude_maxima(user)

% Copyright Tom Collins 28/1/2024

% Compute spectrogram maxima for a directory of audio files.

% Individual user paths
if strcmp(user, 'tom')
  inDir = fullfile('/Users', 'tomthecollins', 'Shizz',...
    'UMiami', 'Teaching', '511-611', 'spring24', 'homeworks',...
    'hw_2', 'music_data', 'small_dir_audio');
  outDir = fullfile('/Users', 'tomthecollins', 'Shizz',...
     'UMiami', 'Teaching', '511-611', 'spring24', 'homeworks',...
     'hw_2', 'matlab_out');
elseif strcmp(user, 'anotherUser')
  % inDir = ...
  % outDir = ...
end

% Parameters
nfft = 8192;
win = hann(nfft);
overlap = 7*nfft/8; % 87.5% overlap between adjacent spectra.
% step = nfft - overlap;
% Given above params, this value of nrows would mean the analysis considers
% frequency components in the range 0-2.7 kHz (=500*44100/8192)
nrows = 500;

% Import and analyse the audio files.
% Obtain details of all the WAV and MP3 files in inDir.
inWavs = fullfile(inDir, '*.wav');
inMp3s = fullfile(inDir, '*.mp3');
fnams = [dir(inWavs); dir(inMp3s)];
naud = length(fnams);

% Iterate.
for i=1:naud
  fprintf('Processing file %d of %d.\n', i, naud);
  % Import audio file.
  [sig, Fs] = audioread(fullfile(fnams(i).folder, fnams(i).name));
  % Spectrogram
  % Just left channel. Could do both or take the mean instead.
  [s, w, t] = spectrogram(sig(:, 1), win, overlap, nfft);
  sa = abs(s(1:nrows, :));
  % Alternative with stft()
  % [u, f, ta] = stft(...
  %   sig(:, 1), Fs, Window = win, OverlapLength = overlap, FFTLength = nfft...
  % );
  % ua = abs(u(nfft/2:nfft/2 + nrows - 1, :));

  % Show spectrogram.
  % close all; imagesc(-s); colormap 'gray'; axis xy
  % xlabel('Time (Spectrogram Increment)', 'FontSize', 18);
  % ylabel('Frequency (Spectrogram Increment)', 'FontSize', 18);

  % Calculate maxima and indices of maxima.
  [c, idx] = max(sa);
  fnams(i).maxidx = idx;
  
  % Plot/visualize.
  % plot(idx)
  
  % Write output to file.
  outfnam = fullfile(outDir, [fnams(i).name '.json']); 
  fid = fopen(outfnam, 'w');
  encodedJson = jsonencode(fnams(i));
  fprintf(fid, encodedJson);
  fclose(fid);
end
