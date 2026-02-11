# Digital_Locker
This project implements a clocked, programmable, multi user access control system using Verilog HDL.
Each user has a password that can be updated at runtime, and an alarm is triggered after three consecutive failed login attempts.

# Features

1. Supports 4 users (2 bit user select)
2. 12 bit programmable password
3. Synchronous design using clock and reset
4. Access granted on correct password
5. Alarm activated on 3rd failed attempt
6. Failed attempt counter
7. Password update using SET_MODE
8. Fully verified with a clocked testbench
