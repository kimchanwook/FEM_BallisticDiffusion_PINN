function write_case_summary(filename, summary)
%WRITE_CASE_SUMMARY Write a simple key-value case summary.
fid = fopen(filename, 'w');
if fid < 0; error('Could not open %s for writing.', filename); end
fields = fieldnames(summary);
for i = 1:numel(fields)
    val = summary.(fields{i});
    if isnumeric(val) && isscalar(val)
        fprintf(fid, '%s: %.12e\n', fields{i}, val);
    elseif ischar(val) || isstring(val)
        fprintf(fid, '%s: %s\n', fields{i}, string(val));
    else
        fprintf(fid, '%s: [non-scalar value]\n', fields{i});
    end
end
fclose(fid);
end
