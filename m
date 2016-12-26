From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH v3 RESEND 01/11] pwm: print error messages with pr_err() instead of pr_debug()
Date: Mon, 26 Dec 2016 23:55:51 +0100
Message-ID: <1482792961-12702-2-git-send-email-l.majewski@majess.pl>
References: <1477259146-19167-1-git-send-email-l.majewski@majess.pl>
 <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482792961-12702-1-git-send-email-l.majewski@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

From: Lothar Wassmann <LW@KARO-electronics.de>

Make the messages that are printed in case of fatal errors actually
visible to the user without having to recompile the driver with
debugging enabled.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
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
