# Digital_Locker
This project implements a multi-user digital locker system using Verilog.
The locker supports 4 users, each with a unique 12-bit hexadecimal password, and includes a security lockout with alarm after continuous incorrect attempts.

# Features

1. 4-user locker system (User = 00, 01, 10, 11)
2. Each user has a hardcoded 12-bit password
3. Password is verified using 3 × 4-bit comparators
4. mod-4 counter tracks incorrect attempts
5. After 3 wrong attempts, the system locks and raises an alarm
6. On correct password → Access = 1
7. Reset clears counter, alarm, and access status
