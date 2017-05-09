From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] extends PWM framework to support PWM dead-times
Date: Tue, 9 May 2017 11:19:48 +0300
Message-ID: <1494317990-9131-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi all,

Please give feedback on these patches which extends PWM framework
in order to support PWM dead-times.
Since I didn't receive any inputs on RFC series I'm resending it as
normal patch series.

For a PWM controller with more than one output signals per PWM channel
dead-times are the delays introduced between the edges of the output
signals and the original signal introduced in dead-time generator
engine.
E.g. consider a PWM controller with a dead-time engine as in the following
diagram:

                        -----------------
                       |                 |---> PWMH
        PWM signal --->| Dead-time engine|
                       |                 |---> PWML
                        -----------------

With no dead-time configured, the PWMH and PWML signals will be
complementary signals (rising and falling edges of PWMH and PWML
have opposite leves, same duration and same starting time) as
follows:

                      ____0    D____P     ____      ____      ____
        PWM signal __|    |____|    |____|    |____|    |____|    |___
                      ____      ____      ____      ____      ____
              PWMH __|    |____|    |____|    |____|    |____|    |___
                   __      ____      ____      ____      ____      ___
              PWML   |____|    |____|    |____|    |____|    |____|

Where - 0 is the starting point of the signal
      - D is the starting point of the duty-cycle
      - P is the signal period

Based on the above diagram:
- rising edge dead-time - is the delay introduced in one of the
dead-time engine output signals; the delay is introduced after
rising edge of the original PWM signal
- falling edge dead-time - is the delay introduced in one of the
dead-time engine output signals; the delay is introduced after
the end of falling edge of the original PWM signal

The following diagram explain how PWM dead-times falls on some signals:

                      ____0    D____P     ____      ____      ____
        PWM signal __|    |____|    |____|    |____|    |____|    |___
                        __        __        __        __        __
              PWMH ____|  |____re|  |______|  |______|  |______|  |___
                   __        __        __        __        __        __
              PWML   |______|  |____fe|  |______|  |______|  |______|

In the upper diagram:
- re = rising edge = the delay between D point of the original PWM signal
(rising edge) and the starting point of the next edge of one of the PWM
dead-time engine output
- fe = falling edge = the delay between P point of the original PWM signal
(falling edge) and the starting point of the next edge of one of the PWM
dead-time engine output

To configure the PWM dead-times new inputs were added to sysfs,
in PWM subsystem, one for rising edge dead-time, one for falling
edge deadtime.

root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/pwmchip0/pwm2# ls -l
-r--r--r--    1 root     root          4096 Feb 10 10:00 capture
-rw-r--r--    1 root     root          4096 Feb 10 10:01 deadtime_fe
-rw-r--r--    1 root     root          4096 Feb 10 10:02 deadtime_re
-rw-r--r--    1 root     root          4096 Feb 10 10:00 duty_cycle
-rw-r--r--    1 root     root          4096 Feb 10 10:00 enable
-rw-r--r--    1 root     root          4096 Feb 10 10:00 period
-rw-r--r--    1 root     root          4096 Feb 10 10:00 polarity
drwxr-xr-x    2 root     root             0 Feb 10 10:00 power
-rw-r--r--    1 root     root          4096 Feb 10 10:00 uevent

The PWM dead-times are used in half bridge converters applications.

Thank you,
Claudiu Beznea

Changes since v1:
- fixed compilation warning

Changes since RFC patches:
- corrected the Documentation/pwm.txt
- in atmel-pwm.c check atmel_pwm->regs->dt before computing
dead-times or setting specific registers since the driver is
used by controllers witch supports dead-time configuration and
controller which does not.

Claudiu Beznea (2):
  drivers: pwm: core: implement pwm dead-times
  drivers: pwm: pwm-atmel: implement pwm dead-times

 Documentation/pwm.txt   | 55 ++++++++++++++++++++++++++++++++++++
 drivers/pwm/core.c      | 10 ++++++-
 drivers/pwm/pwm-atmel.c | 62 ++++++++++++++++++++++++++++++++++++++---
 drivers/pwm/sysfs.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h     | 36 ++++++++++++++++++++++++
 5 files changed, 232 insertions(+), 5 deletions(-)

-- 
2.7.4
