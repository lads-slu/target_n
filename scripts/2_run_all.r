#run all
print(system.time(source('3_load_packages.r')))
print(system.time(source('4_define_functions.r')))
print(system.time(source('5_import_data.r')))
print(system.time(source('6_prepare_data.r')))
print(system.time(source('7_create_vra_map.r')))
print(system.time(source('8_export_data.r')))
