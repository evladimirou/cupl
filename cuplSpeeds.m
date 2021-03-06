function analysis=cuplSpeeds(analysis)
% CUPLSPEEDS  Calculate speeds
%
%   ANALYSIS = CUPLSPEEDS(ANALYSIS) Calculates speeds for the files specified in
%   ANALYSIS. Returns same structure with results appended.
%
% Copyright (c) 2010 Elina Vladimirou

if nargin<1
    error('No analysis struct supplied.');
end

% Alias analysis.
an = analysis;

% Compute change in sister centre position.
dt = mode(an.time);
delX = diff(an.sisterCentreCoords(:,1:3:end)) / dt;
        
% Mean normal speed.
speeds.dx = nanmean(abs(delX))';
speeds.m_dx = nanmean(speeds.dx);
speeds.s_dx = nanstd(speeds.dx);
speeds.e_dx = nanserr(speeds.dx);

% Store result.
an.speeds.sisters = speeds;

% Record stage.
an.stages = union(an.stages,'speeds');

% Unalias analysis.
analysis = an;

% Save analysis mat.
cuplSaveMat(analysis);
