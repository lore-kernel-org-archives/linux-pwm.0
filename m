From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] extend PWM framework to support PWM dead-times
Date: Tue, 9 May 2017 15:15:51 +0300
Message-ID: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: thierry.reding@gmail.com, corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi all,

Please give feedback on these patches which extends the PWM
framework in order to support multiple PWM signal types.
Since I didn't receive any inputs on RFC series I'm resending it as
normal patch series.

The current patch series add the following PWM signal types:
- PWM complementary signals
- PWM push-pull signal

Definition of PWM complementary mode:
For a PWM controllers with more than one outputs per PWM channel,
e.g. with 2 outputs per PWM channels, the PWM complementary signals
have opposite levels, same duration and same starting times,
as in the following diagram:

        __    __    __    __
PWMH __|  |__|  |__|  |__|  |__
     __    __    __    __    __
PWML   |__|  |__|  |__|  |__|
       <--T-->
Where T is the signal period.

Definition of PWM push-pull mode:
For PWM controllers with more than one outputs per PWM channel,
e.g. with 2 outputs per PWM channel, the PWM push-pull signals
have same levels, same duration and are delayed until the begining
of the next period, as in the following diagram:

        __          __
PWMH __|  |________|  |________
              __          __
PWML ________|  |________|  |__
       <--T-->

Where T is the signal period.

These output signals could be configured by setting PWM mode
(a new input in sysfs has been added in order to support this
operation).

root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/pwmchip0/pwm2# ls -l
-r--r--r--    1 root     root          4096 Feb  9 10:54 capture
-rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
-rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
-rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
-rw-r--r--    1 root     root          4096 Feb  9 10:54 period
-rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
-rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent

The PWM push-pull mode could be usefull in applications like
half bridge converters.

This series add support for PWM modes on atmel SAMA5D2 SoC.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  drivers: pwm: core: implement pwm mode
  drivers: pwm: pwm-atmel: add support for pwm modes

 Documentation/pwm.txt         |  24 ++++++++--
 drivers/pwm/core.c            |  13 +++++-
 drivers/pwm/pwm-atmel.c       | 103 +++++++++++++++++++++++++++++-------------
 drivers/pwm/sysfs.c           |  52 +++++++++++++++++++++
 include/dt-bindings/pwm/pwm.h |   1 +
 include/linux/pwm.h           |  37 ++++++++++++++-
 6 files changed, 192 insertions(+), 38 deletions(-)

-- 
2.7.4

