From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RFC PATCH 0/2] extend PWM framework to support PWM modes
Date: Wed, 5 Apr 2017 16:58:57 +0300
Message-ID: <1491400739-9618-1-git-send-email-claudiu.beznea@microchip.com>
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
To: thierry.reding@gmail.com, corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com
Cc: tudor.ambarus@microchip.com, andrei.pistirica@microchip.com, eugen.hristev@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>, cristian.birsan@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi all,

Please give feedback on these patches which extends the PWM
framework in order to support multiple PWM signal types.
The current patch series recognize the following PWM
signal types:
- PWM complementary signals
- PWM push-pull signal
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

The PWM push-pull mode could be usefull in applications like
half bridge converters.

This series add support for PWM modes on atmel SAMA5D2 SoC.

Please consider that this series was build on top following
patch series:
[PATCH v3 0/2] switch to atomic PWM
[PATCH v3 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
[PATCH v3 2/2] drivers: pwm: pwm-atmel: enable PWM on sama5d2

This patch series is not dependent on the other patch series
I've made for extending PWM framework with PWM dead-times:
[RFC PATCH 0/2] extends PWM framework to support PWM dead-times
[RFC PATCH 1/2] drivers: pwm: core: implement pwm dead-times
[RFC PATCH 2/2] drivers: pwm: pwm-atmel: implement pwm dead-time
but, if you consider relevant, and both patch changes are considered
relevant for PWM subsistem, I can combine both of them, if any.

Thanks you,
Claudiu Beznea

Claudiu Beznea (2):
  drivers: pwm: core: implement pwm mode
  drivers: pwm: pwm-atmel: add support for pwm modes

 drivers/pwm/core.c            | 13 +++++-
 drivers/pwm/pwm-atmel.c       | 94 +++++++++++++++++++++++++++++--------------
 drivers/pwm/sysfs.c           | 52 ++++++++++++++++++++++++
 include/dt-bindings/pwm/pwm.h |  1 +
 include/linux/pwm.h           | 37 ++++++++++++++++-
 5 files changed, 162 insertions(+), 35 deletions(-)

-- 
2.7.4
