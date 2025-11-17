function [fs, f, filename, lim, phase_shift, f_fig] = setParams(selected_freq, del, show_sin)
    phase_shift = 0;
    phase_shift_del = 0;

    switch selected_freq
        case 250
            fs = 3543.3;
            f = 250;
            filename = 'txts\test250';
            fs_del = 777.5;
            
            T = 1/f;
            lim = 5*T;
            phase_shift = 0.00045;
            phase_shift_del = 0.0017;
        case 500
            fs = 3540.5;
            f = 500;
            filename = 'txts\test500';
            fs_del = 777.8;

            T = 1/f;
            lim = 5*T;
            phase_shift = 0.0011;
            phase_shift_del = 0.00045;
        case 1000
            fs = 3541.1;
            f = 1000;
            filename = 'txts\test1000';
            fs_del = 778.3;

            T = 1/f;
            lim = 5*T;
            phase_shift = 0.0002;
            phase_shift_del = 0.00045;
        case 2000
            fs = 3559.6;
            f = 2000;
            filename = 'txts\test2000';
            fs_del = 775.7;

            T = 1/f;
            lim = 5*T;
        case 10000
            fs = 3554.7;
            f = 10000;
            filename = 'txts\test10k';
            fs_del = 776.3;

            lim = 0.0065;
        case 20000
            fs = 3524.2;
            f = 20000;
            filename = 'txts\test20k';
            fs_del = 776.5;

            lim = 0.006;
    end
    f_fig = f;
    if del
        fs = fs_del;
        filename = [filename 'del1'];
        lim = lim + 0.01;
        phase_shift = phase_shift_del;
    end

    if ~show_sin
        f_fig = 0;
    end
end
