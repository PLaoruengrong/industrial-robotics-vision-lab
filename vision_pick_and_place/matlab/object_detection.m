% display image to mark the detected objects
figure; idisp(im, 'title', 'Gripper poses')

% some common drawing properties
markersize = 15;
linewidth = 1.5;
or_extension = 1.5;

% Red - detect object and draw properties
try
    m_red = iblobs(r_thresh,'area',[500,50000]);
    m_red.plot_ellipse('edgecolor','k','LineWidth', linewidth);
    m_red.plot('s', 'MarkerSize', markersize, 'MarkerFaceColor','r', 'MarkerEdgeColor','w','LineWidth', linewidth);
    
    % center of first red object
    x_m_red = m_red(1).uc;
    y_m_red = m_red(1).vc;
    m_red_center = [ x_m_red ; y_m_red ];
    
    % drawing orientation
    x_min = x_m_red - cos(m_red(1).theta_)*m_red(1).a*or_extension;
    x_max = x_m_red + cos(m_red(1).theta_)*m_red(1).a*or_extension;
    y_min = y_m_red - sin(m_red(1).theta_)*m_red(1).a*or_extension;
    y_max = y_m_red + sin(m_red(1).theta_)*m_red(1).a*or_extension;
    line( [x_min x_max], [y_min y_max], 'Color', 'k', 'LineWidth', linewidth );
    
    disp("Red block found.")
catch ME
    disp("No red block found!")
end

% Green - detect object and draw properties
try
    m_green = iblobs(g_thresh,'area',[500,50000]);
    m_green.plot_ellipse('edgecolor','k','LineWidth', linewidth);
    m_green.plot('d', 'MarkerSize', markersize, 'MarkerFaceColor','g', 'MarkerEdgeColor','w', 'LineWidth', linewidth);
    
    % center of first green object
    x_m_green = m_green(1).uc;
    y_m_green = m_green(1).vc;
    m_green_center = [ x_m_green ; y_m_green ];
   
    % drawing orientation
    x_min = x_m_green - cos(m_green(1).theta)*m_green(1).a*or_extension;
    x_max = x_m_green + cos(m_green(1).theta)*m_green(1).a*or_extension;
    y_min = y_m_green - sin(m_green(1).theta)*m_green(1).a*or_extension;
    y_max = y_m_green + sin(m_green(1).theta)*m_green(1).a*or_extension;
    line( [x_min x_max], [y_min y_max], 'Color', 'k', 'LineWidth', linewidth );
    
    disp("Green block found.")
catch ME
    disp("No green block found!")
end

% Blue - detect object and draw properties
try
    m_blue = iblobs(b_thresh,'area',[500,50000]);
    m_blue.plot_ellipse('edgecolor','k','LineWidth', linewidth);
    m_blue.plot('o', 'MarkerSize', markersize, 'MarkerFaceColor','b', 'MarkerEdgeColor','w', 'LineWidth', linewidth);
    
    % center of first blue object
    x_m_blue = m_blue(1).uc;
    y_m_blue = m_blue(1).vc;
    m_blue_center = [ x_m_blue ; y_m_blue ];
    
    % drawing orientation
    x_min = x_m_blue - cos(m_blue(1).theta)*m_blue(1).a*or_extension;
    x_max = x_m_blue + cos(m_blue(1).theta)*m_blue(1).a*or_extension;
    y_min = y_m_blue - sin(m_blue(1).theta)*m_blue(1).a*or_extension;
    y_max = y_m_blue + sin(m_blue(1).theta)*m_blue(1).a*or_extension;
    line( [x_min x_max], [y_min y_max], 'Color', 'k', 'LineWidth', linewidth );
    
    disp("Blue block found.")
catch ME
    disp("No blue block found!")
end