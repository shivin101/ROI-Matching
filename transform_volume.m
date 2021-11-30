function [vol_out] = transform_volume(vol_out,vol_params,tform)
    vol_out.gp_vals=transform_linear(vol_out.gp_vals,vol_params.vol_sz*vol_params.vres,tform);
    vol_out.gp_nuc = transform_linear(vol_out.gp_nuc,vol_params.vol_sz*vol_params.vres,tform);
    vol_out.gp_soma = transform_linear(vol_out.gp_soma,vol_params.vol_sz*vol_params.vres,tform);
    vol_out.bg_proc = transform_linear(vol_out.bg_proc,vol_params.vol_sz*vol_params.vres,tform);
    
    vol_out.neur_ves = transform_2d(vol_out.neur_ves,tform);
    vol_out.neur_vol = transform_2d(vol_out.neur_vol,tform);
    vol_out.neur_ves_all = transform_2d(vol_out.neur_ves_all,tform);
   
    vol_out.locs =  transform_locs(vol_out.locs,vol_params.vol_sz*vol_params.vres,tform);
    
    
end