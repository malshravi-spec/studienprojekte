# VHDL-Labor – SIPO-Schieberegister

Das Schieberegister liest Bits seriell ein und gibt sie parallel aus. Die mitgelieferte Testbench setzt die Registerbreite auf vier Bits.

## Simulation mit GHDL

    ghdl -a n_sipo.vhd tb_n_sipo.vhd
    ghdl -e tb_n_sipo
    ghdl -r tb_n_sipo --stop-time=600ns --vcd=sipo.vcd

Die VCD-Datei enthält Takt, Reset, seriellen Eingang und parallelen Ausgang. Für Quartus ist das ursprüngliche Projekt **sipo.qpf** enthalten.
