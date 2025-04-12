
## The 'summary' shell command

 This tools allow to compact listings, log ouputs, tables... in a more concise way, more approchable for humans.

 It is a mix between your trusted head, tail, grep unix commands.

 **The project is young. Options maybe be added (or change if required) based on feedback.**
 ```
  $ nixos-rebuild list-generations | summary --header=1 --count --count-skipped
 Generation   Build-date           NixOS version              Kernel  Configuration Revision  Specialisation
 338 current  2025-04-11 22:00:00  24.11.716906.f9ebe33a928b  6.6.86                          *
 337          2025-04-10 21:52:39  24.11.716868.60e405b241ed  6.6.86                          *
 336          2025-04-09 00:29:19  24.11.716793.a880f49904d6  6.6.85                          *
 335          2025-04-06 21:50:31  24.11.716716.7819a0d29d1d  6.6.85                          *
 334          2025-04-04 22:08:41  24.11.716687.bdb91860de2f  6.6.85                          *
 333          2025-04-02 20:56:53  24.11.716471.02f2af8c8a8c  6.6.85                          *
 332          2025-03-31 23:06:28  24.11.716438.7ffe0edc685f  6.6.85                          *
 331          2025-03-30 21:28:53  24.11.716389.c570c1f53044  6.6.85                          *
 330          2025-03-30 09:15:32  24.11.716389.c570c1f53044  6.6.85                          *
 329          2025-03-27 21:23:14  24.11.716288.d02d88f8de5b  6.6.84                          *
 ... 27 entries skipped
 301          2025-01-19 10:36:42  24.11.713321.6a3ae7a5a12f  6.6.72                          *
 300          2025-01-17 18:13:23  24.11.713184.e24b4c09e963  6.6.71                          *
 299          2025-01-15 18:25:22  24.11.713159.9c6b49aeac36  6.6.71                          *
 298          2025-01-14 22:04:40  24.11.713099.67e9c8808988  6.6.71                          *
 297          2025-01-08 19:32:45  24.11.712512.3f0a8ac25fb6  6.6.69                          *
 42 entries found

 ```

## Installation

 The whole program is a single file python script, using only trivial packages.

 So installing it is only a simple copy of the summary file where ever needed.

## Contributions

 Any feedback is greatly appreciated.

 Usually improvements, additional features should be discussed via github 'issues'.

 In case of bug reports, please try to produce a reduced test case so it can be added to tests.
