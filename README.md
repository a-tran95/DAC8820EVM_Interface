# FPGA-Interfaced DAC

This repository contains code used in my final year project: an FPGA-interfaced Optical Communications Transmitter Testbench. The code is a user interface that allows users to select the frequency clock and PAM level for a PRBS output from the FPGA to the GPIO pins.

![FPGAblockdiagram](https://user-images.githubusercontent.com/57032069/121774981-436c4980-cbc8-11eb-9534-de9c3b80cf43.png)

## Components Used
- Altera DE2 FPGA Development and Education Board
- Texas Instruments DAC8820EVM Evaluation Board

## Usage
Users can use the pushbuttons to cycle through preset frequencies and through PAM types. This information is displayed on the 7-segment display and Greed LEDs above the pushbuttons. There is also a pushbutton that allows the user to output zero as long as the button is held down.
