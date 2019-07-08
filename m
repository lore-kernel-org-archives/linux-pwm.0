Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH RFC 1/7] pinctrl: sh-pfc: add new flags into struct sh_pfc_pin_config
Date: Mon,  8 Jul 2019 18:07:42 +0900
Message-Id: <1562576868-8124-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: linus.walleij@linaro.org, geert+renesas@glider.be, thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

To clean/modify the code up later, this patch just adds new flags
"mux_set" and "gpio_enabled" into the struct sh_pfc_pin_config.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 2824be4..157b257 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -27,6 +27,8 @@
 
 struct sh_pfc_pin_config {
 	u32 type;
+	bool mux_set;
+	bool gpio_enabled;
 };
 
 struct sh_pfc_pinctrl {
@@ -364,7 +366,15 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
 	for (i = 0; i < grp->nr_pins; ++i) {
 		ret = sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION);
 		if (ret < 0)
-			break;
+			goto done;
+	}
+
+	/* All group pins are configurated, mark the pins as mux_set */
+	for (i = 0; i < grp->nr_pins; ++i) {
+		int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
+		struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
+
+		cfg->mux_set = true;
 	}
 
 done:
@@ -405,6 +415,7 @@ static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 	}
 
 	cfg->type = PINMUX_TYPE_GPIO;
+	cfg->gpio_enabled = true;
 
 	ret = 0;
 
@@ -426,6 +437,7 @@ static void sh_pfc_gpio_disable_free(struct pinctrl_dev *pctldev,
 
 	spin_lock_irqsave(&pfc->lock, flags);
 	cfg->type = PINMUX_TYPE_NONE;
+	cfg->gpio_enabled = false;
 	spin_unlock_irqrestore(&pfc->lock, flags);
 }
 
-- 
2.7.4
