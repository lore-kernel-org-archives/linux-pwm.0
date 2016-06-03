From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 00/14] regulator: pwm: various improvements
Date: Fri,  3 Jun 2016 10:22:58 +0200
Message-ID: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Doug Anderson <dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>, Stephen Barber <smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ajit Pal Singh <ajitpal.singh-qxv4g6HH51o@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

This patch series series aims at adding two important features to the
pwm-regulator driver.

The first one is the support for 'smooth handover' between the
bootloader and the kernel. This is mainly solving problems we have when
the PWM is controlling a critical regulator (like the one powering the
DDR chip). Currently, when the PWM regulator acquire the PWM device it
assumes it was off and it's safe to change the configuration before
enabling it, which can generate glitches on the PWM signal which in turn
generated glitches on the output voltage.
To solve that we've introduced support for hardware readout to the
PWM framework, so that the PWM regulator driver can adjust the PWM
a probe time and avoid glitches.
Atomic update is also helping in this regard.

Patch 1 is adding convenient helpers (at the PWM level) that will be
used by the PWM regulator driver.
Patch 2 is just removing the pwm_enable() call from the ->set_voltage()
implementation (pwm_enable() is already called in the reg->enable()
hook).
Patches 3 to 8 are preparing everything on the PWM driver side to make
hardware readout available to all platforms using the PWM regulator
driver (rockchip and sti).
Patches 9 to 12 are making use of the atomic update and hardware readout
features to implement this smooth handover.

The second feature we add to the driver is the capability of using
a sub duty_cycle range in continuous mode. By default the regulator
is assuming that min_uV is achieved with a 0% dutycyle and max_uV
with a 100% dutycycle, but this is not necessarily true.
Moreover, in some cases (when the PWM device does not support
polarity inversion), we might have min_uV at 100% and max_uV at 0%.
Hence the addition of new properties to the existing DT bindings.
The feature is added in patch 13 and 14.

Best Regards,

Boris

Boris Brezillon (14):
  pwm: Add new helpers to create/manipulate PWM states
  regulator: pwm: Drop unneeded pwm_enable() call
  pwm: rockchip: Fix period and duty_cycle approximation
  pwm: rockchip: Add support for hardware readout
  pwm: rockchip: Avoid glitches on already running PWMs
  pwm: rockchip: Add support for atomic update
  pwm: sti: Add support for hardware readout
  pwm: sti: Avoid glitches on already running PWMs
  regulator: pwm: Adjust PWM config at probe time
  regulator: pwm: Switch to the atomic PWM API
  regulator: pwm: properly initialize the ->state field
  regulator: pwm: Retrieve correct voltage
  regulator: pwm: Support extra continuous mode cases
  regulator: pwm: Document pwm-dutycycle-unit and pwm-dutycycle-range

 .../bindings/regulator/pwm-regulator.txt           |  12 ++
 drivers/pwm/pwm-rockchip.c                         | 182 +++++++++++++++------
 drivers/pwm/pwm-sti.c                              |  55 ++++++-
 drivers/regulator/pwm-regulator.c                  | 159 ++++++++++++------
 include/linux/pwm.h                                |  81 +++++++++
 5 files changed, 391 insertions(+), 98 deletions(-)

-- 
2.7.4
