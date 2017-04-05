From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RFC PATCH 0/2] extends PWM framework to support PWM dead-times
Date: Wed, 5 Apr 2017 17:02:28 +0300
Message-ID: <1491400950-9857-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com, corbet@lwn.net, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com
Cc: tudor.ambarus@microchip.com, andrei.pistirica@microchip.com, eugen.hristev@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>, cristian.birsan@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi all,

Please give feedback on these patches which extends PWM framework
in order to support PWM dead-times.

For a PWM controller with more than one output signals per PWM channel
dead-times are the delays introduced between the edges of the output
signals and the original signal introduced in dead-time generator
engine.
E.g. consider a PWM controller with with the following diagram:

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
dead-time engine output signal; the delay is introduced after
rising edge of PWM signal
- falling edge dead-time - is the delay introduced in one of the
dead-time engine output signal; the delay is introduced after
the end of falling edge of the PWM signal
The following diagram explain how PWM dead-times falls on some signals:

                      ____0    D____P     ____      ____      ____
        PWM signal __|    |____|    |____|    |____|    |____|    |___
                        __        __        __        __        __
              PWMH ____|  |____re|  |______|  |______|  |______|  |___
                   __        __        __        __        __        __
              PWML   |______|  |____fe|  |______|  |______|  |______|

In the upper diagram:
- re = rising edge = the delay between D point of PWM signal
(rising edge) and the starting point of the next edge
- fe = falling edge = the delay between P point of PWM signal
(falling edge) and the starting point of the next edge

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

Please consider that this series was build on top of following
patch series:
[PATCH v3 0/2] switch to atomic PWM
[PATCH v3 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
[PATCH v3 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2

This patch series is not dependent on the other patch series
I've made for extending PWM framework with PWM mode:
[RFC PATCH 0/2] extend PWM framework to support PWM modes
[RFC PATCH 1/2] drivers: pwm: core: implement pwm mode
[RFC PATCH 2/2] drivers: pwm: pwm-atmel: add support for pwm modes
but, if you consider relevant, and both patch changes are considered
relevant for PWM subsistem, I can combine both of them, if any.

Thanks you,
Claudiu Beznea

Claudiu Beznea (2):
  drivers: pwm: core: implement pwm dead-times
  drivers: pwm: pwm-atmel: implement pwm dead-time

 Documentation/pwm.txt   | 52 ++++++++++++++++++++++++++++++++++
 drivers/pwm/core.c      | 10 ++++++-
 drivers/pwm/pwm-atmel.c | 56 ++++++++++++++++++++++++++++++++++---
 drivers/pwm/sysfs.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h     | 36 ++++++++++++++++++++++++
 5 files changed, 223 insertions(+), 5 deletions(-)

-- 
2.7.4
