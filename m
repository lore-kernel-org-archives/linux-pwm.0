From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v13 00/11] Convert PWM period and duty cycle to u64
Date: Tue, 21 Apr 2020 19:57:12 -0700
Message-ID: <cover.1587523702.git.gurus@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-pwm@vger.kernel.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-fbdev@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Kamil Debski <kamil@wypas.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Atish Patra <atish.patra@wdc.com>, Thierry Reding <thierry.reding@gmail.com>, linux-riscv@lists.infradead.org, Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Guru Das Srinagesh <gurus@codeaurora.org>, Daniel Thompson <daniel.thompson@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>NXP Linux Team <l>
List-Id: linux-pwm@vger.kernel.org

[REQUEST]

Would it be possible for the patches that have already received Acked-by's in
this series to be accepted and applied to the tree? I lost an Acked-by (in
intel-panel.c) because it had a merge conflict with a new change that came in
after I rebased to tip. I wasn't sure earlier about accepting single patches as
opposed to the entire series en masse, but this event has got me thinking.

[COVER LETTER]

Because period and duty cycle are defined in the PWM framework structs as ints
with units of nanoseconds, the maximum time duration that can be set is limited
to ~2.147 seconds. Consequently, applications desiring to set greater time
periods via the PWM framework are not be able to do so - like, for instance,
causing an LED to blink at an interval of 5 seconds.

Redefining the period and duty cycle struct members in the core PWM framework
structs as u64 values will enable larger time durations to be set and solve
this problem. Such a change to the framework mandates that drivers using these
struct members (and corresponding helper functions) also be modified correctly
in order to prevent compilation errors.

This patch series introduces the changes to all the drivers first, followed by
the framework change at the very end so that when the latter is applied, all
the drivers are in good shape and there are no compilation errors.

Changes from v12:
  - Rebased to tip of for-next
  - Collected Acked-by for sun4i
  - Reworked patch for intel-panel.c due to rebase, dropped Jani's Acked-by as
    a result

Changes from v11:
  - Rebased to tip of for-next.
  - Collected "Acked-by:" for v7 (unchanged) of pwm: sifive: [4]
  - Squished stm32-lp.c change with final patch in series
  - sun4i: Used nsecs_to_jiffies()
  - imx27: Added overflow handling logic
  - clps711x: Corrected the if condition for skipping the division
  - clk: pwm: Reverted to v8 version, added check to prevent division-by-zero

Changes from v10:
  - Carefully added back all the "Reviewed-by: " and "Acked-by: " tags received
    so far that had gotten missed in v9. No other changes.

Changes from v9:
  - Gathered the received "Reviewed-by: " tag
  - Added back the clk-pwm.c patch because kbuild test robot complained [3]
    and addressed received review comments.
  - clps711x: Addressed review comments.

Changes from v8:
  - Gathered all received "Acked-by: " and "Reviewed-by: " tags
  - Dropped patch to clk-pwm.c for reasons mentiond in [2]
  - Expanded audience of unreviewed patches

Changes from v7:
  - Changed commit messages of all patches to be brief and to the point.
  - Added explanation of change in cover letter.
  - Dropped change to pwm-sti.c as upon review it was unnecessary as struct
    pwm_capture is not being modified in the PWM core.

Changes from v6:
  - Split out the driver changes out into separate patches, one patch per file
    for ease of reviewing.

Changes from v5:
  - Dropped the conversion of struct pwm_capture to u64 for reasons mentioned
    in https://www.spinics.net/lists/linux-pwm/msg11541.html

Changes from v4:
  - Split the patch into two: one for changes to the drivers, and the actual
    switch to u64 for ease of reverting should the need arise.
  - Re-examined the patch and made the following corrections:
      * intel_panel.c:
	DIV64_U64_ROUND_UP -> DIV_ROUND_UP_ULL (as only the numerator would be
	64-bit in this case).
      * pwm-sti.c:
	do_div -> div_u64 (do_div is optimized only for x86 architectures, and
	div_u64's comment block suggests to use this as much as possible).

Changes from v3:
  - Rebased to current tip of for-next.

Changes from v2:
  - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild test robot
  - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c

Changes from v1:
  - Fixed compilation errors seen when compiling for different archs.

v1:
  - Reworked the change pushed upstream earlier [1] so as to not add an
    extension to an obsolete API. With this change, pwm_ops->apply() can be
    used to set pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/
[2] https://lore.kernel.org/lkml/20200312190859.GA19605@codeaurora.org/
[3] https://www.spinics.net/lists/linux-pwm/msg11906.html
[4] https://www.spinics.net/lists/linux-pwm/msg11986.html

To: Arnd Bergmann <arnd@arndb.de>
To: David Laight <David.Laight@ACULAB.COM>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: David Collins <collinsd@codeaurora.org>
Cc: dri-devel@lists.freedesktop.org
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: intel-gfx@lists.freedesktop.org
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Joe Perches <joe@perches.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Kamil Debski <kamil@wypas.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
Cc: Yash Shah <yash.shah@sifive.com>

Guru Das Srinagesh (11):
  drm/i915: Use 64-bit division macro
  hwmon: pwm-fan: Use 64-bit division macro
  ir-rx51: Use 64-bit division macro
  pwm: clps711x: Cast period to u32 before use as divisor
  pwm: pwm-imx-tpm: Use 64-bit division macro
  pwm: imx27: Use 64-bit division macro and function
  pwm: sifive: Use 64-bit division macro
  pwm: sun4i: Use nsecs_to_jiffies to avoid a division
  backlight: pwm_bl: Use 64-bit division function
  clk: pwm: Use 64-bit division function
  pwm: core: Convert period and duty cycle to u64

 drivers/clk/clk-pwm.c                      |  7 +++-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 +-
 drivers/pwm/core.c                         | 14 ++++----
 drivers/pwm/pwm-clps711x.c                 |  5 ++-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    | 53 +++++++++++++++++++++++++-----
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        |  8 ++---
 drivers/video/backlight/pwm_bl.c           |  3 +-
 include/linux/pwm.h                        | 12 +++----
 14 files changed, 82 insertions(+), 35 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
