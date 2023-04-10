function dynamicSummaryCSV(subject_id, path, dates, amp_all, nmrFit_ppm, rf_excitation)
% Output CSV file.
% Inputs:
%     subject_id: subject_id string
%     path: output directory
%     dates: dates struct
%     amp_all: amplitude struct
%     nmrFit_ppm: spectroscopy fit struct
%     rf_excitation: RF excitation integer in ppm

% Write a message
disp('Saving Values of Interest to Summary Spreadsheet...')
csvfilepath = fullfile(path, ['Subject ', subject_id, '_', ...
    num2str(round(rf_excitation)),'ppm Spectroscopy Summary.csv']);
C_header = {'subject_id', 'scan_date', 'process_date', 'rbcamp_date',...
    'rbcm', 'rbc_shift', 'rbc_fwhm', 'rbc_fwhmg',...
    'rbc_phase', 'rbc_5fid_snr_sine',...
    'rbc_5fid_snr_peaks', 'mem_intensity','mem_shift',...
    'mem_fwhm', 'mem_fwhmg', 'mem_phase',...
    'mem_5fid_snr_sine', 'mem_5fid_snr_peaks',...
    'osc_amp_sine', 'osc_amp_peaks', 'osc_chemical_shift_sine',...
    'osc_chemical_shift_peaks', 'osc_linewidth_sine',...
    'osc_linewidth_peaks', 'osc_phase_sine', 'osc_phase_peaks', ...
    'hr_sine', 'hr_peaks', 'snr_sine',...
    'snr_peaks', 'rf_excitation'
    };
C_content = {subject_id, dates.scan, dates.dyn_fit, dates.rbc_fit,...
    nmrFit_ppm.area(1), nmrFit_ppm.freq(1), nmrFit_ppm.fwhm(1), '---', ...
    nmrFit_ppm.phase(1), nmrFit_ppm.SNRresid(1), nmrFit_ppm.SNRsnf(1), ...
    nmrFit_ppm.area(2), nmrFit_ppm.freq(2), nmrFit_ppm.fwhm(2), '---', ...
    nmrFit_ppm.phase(2), nmrFit_ppm.SNRresid(2), nmrFit_ppm.SNRsnf(2), ...
    amp_all.sine.area*100, amp_all.peaks.area*100, amp_all.sine.freq, ...
    amp_all.peaks.freq, amp_all.sine.fwhm, amp_all.peaks.fwhm,...
    amp_all.sine.phase, amp_all.peaks.phase, amp_all.sine.hr, ...
    amp_all.peaks.hr, amp_all.sine.snr, amp_all.peaks.snr, rf_excitation
    };
C = [C_header; C_content];
writecell(C, csvfilepath);
end