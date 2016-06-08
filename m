From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 00/13] regulator: pwm: various improvements
Date: Wed,  8 Jun 2016 18:34:35 +0200
Message-ID: <1465403688-17098-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58966 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757843AbcFHQe5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jun 2016 12:34:57 -0400
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Brian Norris <briannorris@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com, Laxman Dewangan <ldewangan@nvidia.com>, Boris Brezillon <boris.brezillon@free-electrons.com>

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
Patches 2 to 7 are preparing everything on the PWM driver side to make
hardware readout available to all platforms using the PWM regulator
driver (rockchip and sti).
Patches 8 to 11 are making use of the atomic update and hardware readout
features to implement this smooth handover.

The second feature we add to the driver is the capability of using
a sub duty_cycle range in continuous mode. By default the regulator
is assuming that min_uV is achieved with a 0% dutycyle and max_uV
with a 100% dutycycle, but this is not necessarily true.
Moreover, in some cases (when the PWM device does not support
polarity inversion), we might have min_uV at 100% and max_uV at 0%.
Hence the addition of new properties to the existing DT bindings.
The feature is added in patch 12 and 13.

Best Regards,

Boris

Changes since v1:
- dropped already applied patches
- added R-b/A-b/T-b tags
- s/readl/readl_relaxed/ in patch 3 (as suggested by Brian)
- fixed pwm-regulator DT binding doc
- added some comments in the code
- replaced pwm_get_state() + if (state.enabled) by if (pwm_is_enabled())

Boris Brezillon (13):
  pwm: Add new helpers to create/manipulate PWM states
  pwm: rockchip: Fix period and duty_cycle approximation
  pwm: rockchip: Add support for hardware readout
  pwm: rockchip: Avoid glitches on already running PWMs
  pwm: rockchip: Add support for atomic update
  pwm: sti: Add support for hardware readout
  pwm: sti: Avoid glitches on already running PWMs
  regulator: pwm: Adjust PWM config at probe time
  regulator: pwm: Switch to the atomic PWM API
  regulator: pwm: Properly initialize the ->state field
  regulator: pwm: Retrieve correct voltage
  regulator: pwm: Support extra continuous mode cases
  regulator: pwm: Document pwm-dutycycle-unit and pwm-dutycycle-range

 .../bindings/regulator/pwm-regulator.txt           |  19 +++
 drivers/pwm/pwm-rockchip.c                         | 178 +++++++++++++++------
 drivers/pwm/pwm-sti.c                              |  52 +++++-
 drivers/regulator/pwm-regulator.c                  | 162 ++++++++++++++-----
 include/linux/pwm.h                                |  81 ++++++++++
 5 files changed, 401 insertions(+), 91 deletions(-)

-- 
2.7.4
