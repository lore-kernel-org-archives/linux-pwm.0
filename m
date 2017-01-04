From: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v4 01/11] pwm: print error messages with pr_err() instead of pr_debug()
Date: Thu,  5 Jan 2017 00:36:44 +0100
Message-ID: <1483573014-13185-2-git-send-email-lukma@denx.de>
References: <1483573014-13185-1-git-send-email-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483573014-13185-1-git-send-email-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

From: Lothar Wassmann <LW@KARO-electronics.de>

Make the messages that are printed in case of fatal errors actually
visible to the user without having to recompile the driver with
debugging enabled.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
Changes for v4:
- None

Changes for v3:
- None
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 172ef82..ec7179f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -663,13 +663,13 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
 					 &args);
 	if (err) {
-		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
+		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
 		return ERR_PTR(err);
 	}
 
 	pc = of_node_to_pwmchip(args.np);
 	if (IS_ERR(pc)) {
-		pr_debug("%s(): PWM chip not found\n", __func__);
+		pr_err("%s(): PWM chip not found\n", __func__);
 		pwm = ERR_CAST(pc);
 		goto put;
 	}
-- 
2.1.4
