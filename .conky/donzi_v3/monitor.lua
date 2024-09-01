require 'cairo'

width = 310;
height = 900;

cols = {90, 180}
rows = {100, 250, 400, 550, 700, 850}

fg_alpha = 0.5;
mg_alpha = 0.15;
bg_alpha = 0.1;
fg_rgba = {1.0, 1.0, 1.0, fg_alpha};
mg_rgba = {1.0, 1.0, 1.0, mg_alpha};
bg_rgba = {1.0, 1.0, 1.0, bg_alpha};
red_rgb = {1.0, 0.0, 0.0};
amber_rgb = {1.0, 1.0, 0};
yellow_rgb = {1.0, 1.0, 1.0};

font_size = 20;
arc_thickness = 10;
line_thickness = 1;
graph_height = 25;
text_gap = arc_thickness * 7;
margin = 1;
radius_1 = 40;
radius_2 = radius_1 - arc_thickness - margin;
radius_3 = radius_2 - arc_thickness - margin;
radius_4 = radius_3 - arc_thickness - margin;
radii = {radius_1, radius_2, radius_3, radius_4};
start_angle = math.pi/2;
end_angle = math.pi*1.75;
label_org = radii[3] / 1.141;
gradient = 50
x_scale = 30;
y_scale = 6.25;

x = 1;
y = 2;
name = 3;
label = 3;
length = 3;
var = 4;
arg = 5;
max_value = 6;
ring = 7;
duration = 7;
red_value = 8;
data = 8;
amber_value = 9;
graph_scale = 9;
yellow_value = 10;
units = 11;
scale = 12;

system = {cols[2], rows[1], "System"};
storage = {cols[2], rows[2], "Storage"};
network = {cols[2], rows[3], "Network"};
cpu = {cols[2], rows[4], "Processor"};
gpu = {cols[2], rows[5], "Graphics"};
mbo = {cols[2], rows[6], "Mainboard"};

load_data = {};
memory_data = {};
root_data = {};
data_data = {};
down_data = {};
up_data = {};
cpu_tmp_data = {};
cpu_fan_data = {};
gpu_tmp_data = {};
gpu_fan_data = {};
mbo_tmp_data = {};
mbo_fan_data = {};

system_axis = {system[x], system[y], 90};
storage_axis = {storage[x], storage[y], 90};
network_axis = {network[x], network[y], 90};
cpu_axis = {cpu[x], cpu[y], 90};
gpu_axis = {gpu[x], gpu[y], 90};
mbo_axis = {mbo[x], mbo[y], 90};

axis = {system_axis, storage_axis, network_axis, cpu_axis, gpu_axis, mbo_axis};

load_graph={system_axis[x], system_axis[y], "load", "cpu", "cpu0", 100, system_axis[length], load_data, "P"};
memory_graph = {system_axis[x], system_axis[y], "mem", "memperc", "", 100, system_axis[length], memory_data, "P"};
root_graph = {storage_axis[x], storage_axis[y], "root", "diskio", "sdd", 10, storage_axis[length], root_data, "L"};
data_graph = {storage_axis[x], storage_axis[y], "data", "diskio", "sda", 10, storage_axis[length], data_data, "L"};
down_graph = {network_axis[x], network_axis[y], "down", "downspeed", "enp5s0", 10, network_axis[length], down_data, "L"}
up_graph = {network_axis[x], network_axis[y], "up", "upspeed", "enp5s0", 10, network_axis[length], up_data, "L"}
cpu_tmp_graph={cpu_axis[x], cpu_axis[y], "temp", "hwmon 3", "temp 1", 100, cpu_axis[length], cpu_tmp_data, "P"};
cpu_fan_graph={cpu_axis[x], cpu_axis[y], "fan", "hwmon 2", "fan 2", 2500, cpu_axis[length], cpu_fan_data, "P"};
gpu_tmp_graph={gpu_axis[x], gpu_axis[y], "temp", "hwmon 1", "temp 1", 100, gpu_axis[length], gpu_tmp_data, "P"};
gpu_fan_graph={gpu_axis[x], gpu_axis[y], "fan", "hwmon 1", "fan 1", 2500, gpu_axis[length], gpu_fan_data, "P"};
mbo_tmp_graph={mbo_axis[x], mbo_axis[y], "temp", "hwmon 2", "temp 3", 100, mbo_axis[length], mbo_tmp_data, "P"};
mbo_fan_graph={mbo_axis[x], mbo_axis[y], "fan", "hwmon 2", "fan 1", 2500, mbo_axis[length], mbo_fan_data, "P"};

graphs = {load_graph, memory_graph, root_graph, data_graph, down_graph, up_graph, cpu_tmp_graph, cpu_fan_graph, gpu_tmp_graph, gpu_fan_graph, mbo_tmp_graph, mbo_fan_graph};

load = {system[x], system[y], "load", "cpu", "cpu", 100, radii[1], 90, 80, 70, "%", "P"};
memory = {system[x], system[y], "mem", "memperc", "", 100, radii[2], 90, 80, 70, "%", "P"};
primary = {storage[x], storage[y], "root", "diskio", "sdd", 10, radii[1], 9.7, 9.4, 8.8, "", "L"};
secondary = {storage[x], storage[y], "data", "diskio", "sda", 10, radii[2], 9.7, 9.4, 8.8, "", "L"};
down = {network[x], network[y], "down", "downspeed", "enp5s0", 10, radii[1], 9.7, 9.4, 8.8, "", "L"}
up = {network[x], network[y], "up", "upspeed", "enp5s0", 10, radii[2], 9.7, 9.4, 8.8, "", "L"}
cpu_tmp = {cpu[x], cpu[y], "temp", "hwmon 3", "temp 1", 100, radii[1], 90, 80, 70, "°C", "P"};
cpu_fan = {cpu[x], cpu[y], "fan", "hwmon 2", "fan 2", 2500, radii[2], 2400, 2300, 2200, " rpm", "P"}
gpu_tmp = {gpu[x], gpu[y], "temp", "hwmon 1", "temp 1", 100, radii[1], 90, 80, 70, "°C", "P"};
gpu_fan = {gpu[x], gpu[y], "fan", "hwmon 1", "fan 1", 2500, radii[2], 2400, 2300, 2200, " rpm", "P"}
mbo_tmp = {mbo[x], mbo[y], "temp", "hwmon 2", "temp 3", 100, radii[1], 90, 80, 70, "°C", "P"};
mbo_fan = {mbo[x], mbo[y], "fan", "hwmon 2", "fan 1", 2500, radii[2], 2400, 2300, 2200, " rpm", "P"}

groups = {system, storage, network, cpu, gpu, mbo};
arcs = {load, memory, primary, secondary, down, up, cpu_tmp, cpu_fan, gpu_tmp, gpu_fan, mbo_tmp, mbo_fan}; 

function conky_setup()

end

function conky_main()

	if conky_window == nil then return end

	local updates = tonumber(conky_parse("${updates}"));
	if updates < 3 then return end	

	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, width, height);
	cr = cairo_create(cs);

	local extents = cairo_text_extents_t:create();
	local text = "";

    for i in pairs(arcs) do
        draw_arc(arcs[i])
    end

    for i in pairs(groups) do
        write_label(groups[i]);
    end

    for i in pairs(axis) do
        draw_axis(axis[i]);
    end

    for i in pairs(graphs) do
        draw_graph(graphs[i]);
    end

    cairo_destroy(cr);
    cairo_surface_destroy(cs);
    cr = nil;
end

function write_label(label_set)
    set_colour(fg_rgba);
	cairo_select_font_face(cr, "Arial", 0 , 0);
	cairo_set_font_size(cr, font_size);

    text = label_set[label];
    label_x = label_set[x] + label_org + arc_thickness;
    label_y = label_set[y] - label_org + arc_thickness;
	cairo_move_to(cr, label_x, label_y);
	cairo_show_text(cr, text);

end

function draw_axis(data_set)
    local z_ = math.sqrt(2) * (radii[3]);
    local x_ = data_set[x] + z_ + arc_thickness;
    local y_ = data_set[y] - z_ ;
    local i = 0;
    while (i <= data_set[length]) do
        draw_line(x_ + i, y_, x_ + i, y_ - graph_height, bg_rgba);
        i = i + x_scale;
    end
    i = 0;
    while (i <= graph_height) do
        draw_line(x_, y_ - i, x_ + data_set[length], y_ - i, bg_rgba);
        i = i + y_scale;
    end
end

function draw_graph(data_set)
    local z_ = math.sqrt(2) * (radii[3]);
    local x_ = data_set[x] + z_ + arc_thickness;
    local y_ = data_set[y] - z_ ;
    local scaler = data_set[max_value] / graph_height;
    local array_length = #data_set[data];
    if array_length < data_set[duration] then
        array_length = array_length + 1;
        data_set[data][array_length] = 0;
    end
    local str = string.format('${%s %s}', data_set[var], data_set[arg]);
    str = conky_parse(str);

    local value = 0;
    local unit_ = "";
    if string.match(str, "%a*") then
        unit_ = string.match(str, "%a+");
    end

    local value_str = string.match(str, "%d*%p*%d*");
    value = tonumber(value_str);

    if string.find(data_set[graph_scale], "L") then
        value = get_log(value);
        if string.find(unit_, "K") then
            value = value + 3;
        end
        if string.find(unit_, "M") then
            value = value + 6;
        end
    end
    for i = array_length, 2, -1 do
        data_set[data][i] = data_set[data][i - 1];
    end
    data_set[data][1] = value / scaler;
    for i = 1, array_length - 1 do
        draw_line(x_ + i, y_ - data_set[data][i], x_ + i + 1, y_ - data_set[data][i + 1], fg_rgba);
    end
end

function draw_arc(data_set)
    local function get_angle(value_)
        return (end_angle - start_angle) * value_ / data_set[max_value] + start_angle;
        end
    local str, value = '', 0;
    local x_, y_ = data_set[x], data_set[y];
    local radius = data_set[ring];
    str = string.format('${%s %s}', data_set[var], data_set[arg]);
    str = conky_parse(str)
    local value = 0;
    local unit_ = "";
    if string.match(str, "%a*") then
        unit_ = string.match(str, "%a+");
    end

    value_str = string.match(str, "%d*%p*%d*");
    value = tonumber(value_str);

    if string.find(data_set[scale], "L") then
        value = get_log(value);
        if string.find(unit_, "K") then
            value = value + 3;
        end
        if string.find(unit_, "M") then
            value = value + 6;
        end
    end

    cairo_set_line_width(cr, arc_thickness);
	cairo_move_to(cr, x_, y_ + radius);
    cairo_arc(cr, x_, y_, radius,  start_angle, end_angle);
    set_colour(bg_rgba);
    cairo_stroke(cr);

    local white_max = get_angle(data_set[yellow_value]);
    local yellow_max = get_angle(data_set[amber_value]);
    local amber_max = get_angle(data_set[red_value]);
    local grad_angle = (end_angle - yellow_max) / gradient
    local draw_angle = yellow_max
    local r_ = 1.0
    local g_ = 1.0
    local b_ = 1.0
    local dec_ = 1.0 / gradient

    set_colour(fg_rgba);

    if string.find(data_set[scale], "-") then

        if value > data_set[yellow_value] then
            set_colour(fg_rgba);
        elseif value > data_set[amber_value] then
            set_colour(yellow_rgb);
        elseif value > data_set[red_value] then
            set_colour(amber_rgb);
        else
            set_colour(red_rgb);
        end
        cairo_arc(cr, x_, y_, radius,  start_angle, get_angle(value));
        cairo_stroke(cr);

    else

        if value < data_set[amber_value] then
            cairo_arc(cr, x_, y_, radius,  start_angle, get_angle(value));
            cairo_stroke(cr);
        else
            cairo_arc(cr, x_, y_, radius,  start_angle, yellow_max);
            cairo_stroke(cr);
            local value_angle = get_angle(value);
            local start_ = draw_angle
            while (draw_angle < value_angle) and (draw_angle < end_angle)
            do
                g_ = g_ - dec_;
                b_ = b_ - (dec_ * 3);
                cairo_set_source_rgba(cr, r_, g_, b_, fg_rgba[4]);
                start_ = draw_angle;
                draw_angle = draw_angle + grad_angle;
                cairo_arc(cr, x_, y_, radius, start_, draw_angle);
                cairo_stroke(cr);
            end
        end
    end

    write_two_columns(x_ + margin*5, y_ + radius + arc_thickness/2, data_set[name], str..data_set[units], 35)

end

function write_two_columns(tx, ty, first, second, gap)
    cairo_move_to(cr, tx, ty)
    set_colour(fg_rgba);
	cairo_set_font_size(cr, arc_thickness);
    text = first;
	cairo_show_text(cr, text);
    cairo_move_to(cr, tx + gap, ty)
    text = second;
	cairo_show_text(cr, text);
end

function set_colour(colour)
    if colour == fg_rgba then
        cairo_set_source_rgba(cr, fg_rgba[1], fg_rgba[2], fg_rgba[3], fg_rgba[4]);
    end
    if colour == bg_rgba then
        cairo_set_source_rgba(cr, bg_rgba[1], bg_rgba[2], bg_rgba[3], bg_rgba[4]);
    end
    if colour == red_rgb then
        cairo_set_source_rgba(cr, red_rgb[1], red_rgb[2], red_rgb[3], fg_rgba[4]);
    end
    if colour == amber_rgb then
        cairo_set_source_rgba(cr, amber_rgb[1], amber_rgb[2], amber_rgb[3], fg_rgba[4]);
    end
    if colour == yellow_rgb then
        cairo_set_source_rgba(cr, yellow_rgb[1], yellow_rgb[2], yellow_rgb[3], fg_rgba[4]);
    end
end

function draw_line(from_x, from_y, to_x, to_y, line_colour)
    cairo_set_line_width(cr, line_thickness);
    cairo_move_to(cr, from_x, from_y);
    set_colour(line_colour);
    cairo_line_to(cr, to_x, to_y);
    cairo_stroke(cr);
end

function get_log(number)
    local log_ = 0;
    local k = {10, 3.16, 1.77, 1.33, 1.15, 1.07, 1.03};
    local p = {1, 0.5, 0.25, 0.125, 0.063, 0.031, 0.016};
    local i = 1;
    while i < 8 do
        while number > k[i] do
            log_ = log_ + p[i];
            number = number / k[i]
        end
        i = i + i;
    end
    return log_;
end