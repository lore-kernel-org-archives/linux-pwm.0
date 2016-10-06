From: Lukasz Majewski <l.majewski@majess.pl>
Subject: [PATCH] pwm: core: Use pwm->args.polarity to setup
 PWM_POLARITY_INVERSED
Date: Thu,  6 Oct 2016 08:49:54 +0200
Message-ID: <1475736594-23028-1-git-send-email-l.majewski@majess.pl>
References: <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, stefan@agner.ch
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, l.majewski@samsung.com, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, thierry.reding@gmail.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@KARO-electronics.de>
List-Id: linux-pwm@vger.kernel.org

The pwm_set_polarity() function finally calls pwm_apply_state(), which
in turn requires state->duty_cycle and state->period properly set.

In the moment when polarity is set, the PWM is disabled and not configured.
For that reason both above variables are set to 0 and the polarity is not
set.

To be sure that polarity is setup, one needs to set pwm->args.polarity, which
controls MX3_PWMCR_POUTC bit setting at imx_pwm_config_v2().

Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
---
This patch should be applied on top of:

"[v2,2/6] pwm: core: make the PWM_POLARITY flag in DTB optional"

http://patchwork.ozlabs.org/patch/677330/

---
 drivers/pwm/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1f62668..6cd6004 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -153,13 +153,11 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const struct of_phandle_args *args)
 		return pwm;
 
 	pwm->args.period = args->args[1];
+	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args_count > 2) {
+	if (args->args_count > 2)
 		if (args->args[2] & PWM_POLARITY_INVERTED)
-			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
-		else
-			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
-	}
+			pwm->args.polarity = PWM_POLARITY_INVERSED;
 
 	return pwm;
 }
-- 
2.1.4
