% black - detect object and draw properties
try
    m_black = iblobs(bl_thresh,'area',[500,50000]);
    m_black.plot_ellipse('edgecolor','k','LineWidth', linewidth);
    m_black.plot('x', 'MarkerSize', markersize, 'MarkerFaceColor','w', 'MarkerEdgeColor','w','LineWidth', linewidth);
    
    % center of first red object
    x_m_bl = m_black(1).uc;
    y_m_bl = m_black(1).vc;
    m_red_center = [ x_m_bl ; y_m_bl ];
    
    % drawing orientation
    x_min = x_m_bl - cos(m_black(1).theta_)*m_black(1).a*or_extension;
    x_max = x_m_bl + cos(m_black(1).theta_)*m_black(1).a*or_extension;
    y_min = y_m_bl - sin(m_black(1).theta_)*m_black(1).a*or_extension;
    y_max = y_m_bl + sin(m_black(1).theta_)*m_black(1).a*or_extension;
    line( [x_min x_max], [y_min y_max], 'Color', 'k', 'LineWidth', linewidth );
    
    disp("Black block found.")
catch ME
    disp("No black block found!")
end