Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH RFC 3/7] pinctrl: sh-pfc: Rollback to mux if requires when the gpio is freed
Date: Mon,  8 Jul 2019 18:07:44 +0900
Message-Id: <1562576868-8124-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

R-Car PWM controller requires the gpio to output zero duty,
this patch allows to roll it back from gpio to mux when the gpio
is freed.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 7e5aca2..bc29066 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -26,6 +26,7 @@
 #include "../pinconf.h"
 
 struct sh_pfc_pin_config {
+	unsigned int mux_mark;
 	bool mux_set;
 	bool gpio_enabled;
 };
@@ -353,6 +354,15 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
 	spin_lock_irqsave(&pfc->lock, flags);
 
 	for (i = 0; i < grp->nr_pins; ++i) {
+		int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
+		struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
+
+		/*
+		 * This doesn't assume the order which gpios are enabled
+		 * and then mux is set.
+		 */
+		WARN_ON(cfg->gpio_enabled);
+
 		ret = sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION);
 		if (ret < 0)
 			goto done;
@@ -364,6 +374,7 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
 		struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
 
 		cfg->mux_set = true;
+		cfg->mux_mark = grp->mux[i];
 	}
 
 done:
@@ -417,6 +428,9 @@ static void sh_pfc_gpio_disable_free(struct pinctrl_dev *pctldev,
 
 	spin_lock_irqsave(&pfc->lock, flags);
 	cfg->gpio_enabled = false;
+	/* If mux is already set, this configure it here */
+	if (cfg->mux_set)
+		sh_pfc_config_mux(pfc, cfg->mux_mark, PINMUX_TYPE_FUNCTION);
 	spin_unlock_irqrestore(&pfc->lock, flags);
 }
 
-- 
2.7.4
