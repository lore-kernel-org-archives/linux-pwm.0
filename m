From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v3 03/14] pwm: rockchip: Fix period and duty_cycle
 approximation
Date: Tue, 14 Jun 2016 11:13:11 +0200
Message-ID: <1465895602-31008-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Milo Kim <milo.kim@ti.com>, Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@st.com>, Laxman Dewangan <ldewangan@nvidia.com>, kernel@stlinux.com, Boris Brezillon <boris.brezillon@free-electrons.com>, Brian Norris <briannorris@chromium.org>, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Doug Anderson <dianders@google.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ajit Pal Singh <ajitpal.singh@st.com>
List-Id: linux-pwm@vger.kernel.org

The current implementation always round down the duty and period
values, while it would be better to round them to the closest integer.

These changes are needed in preparation of atomic update support to
prevent a period/duty cycle drift when executing several time the
'pwm_get_state() / modify / pwm_apply_state()' sequence.

Say you have an expected period of 3.333 us and a clk rate of
112.666667 MHz -- the clock frequency doesn't divide evenly,
so the period (stashed in nanoseconds) shrinks when we convert to
the register value and back, as follows:

  pwm_apply_state(): register = period * 112666667 / 1000000000;
  pwm_get_state(): period = register * 1000000000 / 112666667;

or in other words:

  period = period * 112666667 / 1000000000 * 1000000000 / 112666667;

which yields a sequence like:

  3333 -> 3328
  3328 -> 3319
  3319 -> 3310
  3310 -> 3301
  3301 -> 3292
  3292 -> ... (etc) ...

With this patch, we'd see instead:

  period = div_round_closest(period * 112666667, 1000000000) *
	   1000000000 / 112666667;

which yields a stable sequence:

  3333 -> 3337
  3337 -> 3337
  3337 -> ... (etc) ...

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/pwm/pwm-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 7d9cc90..68d72ce 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -114,12 +114,11 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * default prescaler value for all practical clock rate values.
 	 */
 	div = clk_rate * period_ns;
-	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
-	period = div;
+	period = DIV_ROUND_CLOSEST_ULL(div,
+				       pc->data->prescaler * NSEC_PER_SEC);
 
 	div = clk_rate * duty_ns;
-	do_div(div, pc->data->prescaler * NSEC_PER_SEC);
-	duty = div;
+	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
 
 	ret = clk_enable(pc->clk);
 	if (ret)
-- 
2.7.4
