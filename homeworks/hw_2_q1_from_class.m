function name_of_func(user)

% I/O recipe

% 1. Requirements
% addpath('./../FastPeakFind')

% 2. Paths
if strcmp(user, 'tom')
  inDir = fullfile('/Users', 'tomthecollins', 'Shizz',...
    'UMiami', 'Teaching', '511-611', 'fall24', 'homeworks',...
    'hw_2', 'music_data', 'small_dir_audio');
  outDir = fullfile('/Users', 'tomthecollins', 'Shizz',...
    'UMiami', 'Teaching', '511-611', 'fall24', 'homeworks',...
    'hw_2', 'matlab_out');
elseif strcmp(user, 'brandon')
  inDir = fullfile('...');
  outDir = fullfile('...');
end

exist(inDir, 'dir')
% dir(inDir)

% 3. Parameters
nfft = 1024;
win = hamming(nfft);
overlap = 7*nfft/8;
nrows = 100; % = nfft/2


% 4. Set some output variables that will be populated.

% 5. Iterate
files = [...
  dir(fullfile(inDir, '*.wav'));...
  dir(fullfile(inDir, '*.mp3'))
];

for ifile = 1:length(files)
  fprintf('%s', files(ifile).name)
  [sig, Fs] = audioread(...
    fullfile(files(ifile).folder, files(ifile).name)...
  );
  % Example of effect of windowing:
  % plot(sig(441001:442024, 1))
  % figure; plot(win.*sig(441001:442024, 1))
end


% 6. Write as we iterate or write after iteration.
