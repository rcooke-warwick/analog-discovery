# Simple Pytest to validate that the AD2 drivers and runtime were installed properly
import pytest
import xunitparser
import dwf

# Verify that calls to the Waveforms software can be made
def test_sw_version():
    assert dwf.FDwfGetVersion() == "3.16.3"


print("Opening first device")
dwf_dio = dwf.DwfDigitalIO()

# set DIO 0 to high, and capture with DIO 1
print("Setting DIO pin 0 to output...")
# enable output on pin DIO pin 0
dwf_dio.outputEnableSet(0b00000001)

# set value of 1 to DIO 0
print("Setting DIO pin 0 to high...")
dwf_dio.outputSet(0b00000001)
# fetch digital IO information from the device 
dwf_dio.status()
# read state of all pins, regardless of output enable
dwRead = dwf_dio.inputStatus()

#print dwRead as bitfield (32 digits, removing 0b at the front)
print("Digital IO Pins:  " + bin(dwRead)[2:].zfill(32))

print("Setting DIO pin 0 to low...")
# set value of 0 to DIO 0
dwf_dio.outputSet(0b00000000)
dwf_dio.status()
# read state of all pins, regardless of output enable
dwRead = dwf_dio.inputStatus()

#print dwRead as bitfield (32 digits, removing 0b at the front)
print("Digital IO Pins:  " + bin(dwRead)[2:].zfill(32))

dwf_dio.close()
