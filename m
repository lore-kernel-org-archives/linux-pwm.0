From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 08/14] pwm: sti: Avoid glitches on already running PWMs
Date: Fri,  3 Jun 2016 10:23:06 +0200
Message-ID: <1464942192-25967-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-kernel@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, Doug Anderson <dianders@google.com>, Milo Kim <milo.kim@ti.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, kernel@stlinux.com, Boris Brezillon <boris.brezillon@free-electrons.com>, Kumar Gala <galak@codeaurora.org>, Maxime Coquelin <maxime.coquelin@st.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, linux-arm-kernel@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pwm@vger.kernel.org

The current logic will disable the PWM clk even if a PWM was left
enabled by the bootloader (because it's controlling a critical device
like a regulator for example).
Keep the PWM clk enabled if at least one PWM is enabled to avoid any
glitches.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/pwm/pwm-sti.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 6300d3e..8232c5b 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -340,7 +340,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	struct sti_pwm_compat_data *cdata;
 	struct sti_pwm_chip *pc;
 	struct resource *res;
-	int ret;
+	int i, ret;
 
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
@@ -391,7 +391,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	ret = clk_prepare(pc->clk);
+	ret = clk_prepare_enable(pc->clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
 		return ret;
@@ -409,6 +409,19 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Keep the PWM clk enabled if some PWMs appear to be up and
+	 * running.
+	 */
+	for (i = 0; i < pc->chip.npwm; i++) {
+		struct pwm_state state;
+
+		pwm_get_state(&pc->chip.pwms[i], &state);
+		if (state.enabled)
+			clk_enable(pc->clk);
+	}
+	clk_disable(pc->clk);
+
 	platform_set_drvdata(pdev, pc);
 
 	return 0;
-- 
2.7.4
