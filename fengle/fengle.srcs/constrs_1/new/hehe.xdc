#配置输入开关部分
set_property PACKAGE_PIN V5 [get_ports {A[3]}]
set_property PACKAGE_PIN T4 [get_ports {A[2]}]
set_property PACKAGE_PIN V6 [get_ports {A[1]}]
set_property PACKAGE_PIN T5 [get_ports {A[0]}]
set_property PACKAGE_PIN T6 [get_ports {B[3]}]
set_property PACKAGE_PIN V7 [get_ports {B[2]}]
set_property PACKAGE_PIN R8 [get_ports {B[1]}]
set_property PACKAGE_PIN U9 [get_ports {B[0]}]
set_property PACKAGE_PIN T9 [get_ports Cin]
#配置输出显示灯
set_property PACKAGE_PIN U6 [get_ports {F[3]}]
set_property PACKAGE_PIN R5 [get_ports {F[2]}]
set_property PACKAGE_PIN U7 [get_ports {F[1]}]
set_property PACKAGE_PIN R6 [get_ports {F[0]}]
set_property PACKAGE_PIN R7 [get_ports Cout]

set_property IOSTANDARD LVCMOS18 [get_ports {A[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {A[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {A[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {A[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {B[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {B[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {B[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {B[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {F[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {F[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {F[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {F[0]}]
set_property PULLDOWN true [get_ports {A[3]}]
set_property PULLDOWN true [get_ports {A[2]}]
set_property PULLDOWN true [get_ports {A[1]}]
set_property PULLDOWN true [get_ports {A[0]}]
set_property PULLDOWN true [get_ports {B[3]}]
set_property PULLDOWN true [get_ports {B[2]}]
set_property PULLDOWN true [get_ports {B[1]}]
set_property PULLDOWN true [get_ports {B[0]}]
