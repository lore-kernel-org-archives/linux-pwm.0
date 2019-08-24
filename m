From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 2/3] pwm: bcm2835: fix period_ns range check
Date: Sat, 24 Aug 2019 09:07:24 +0200
Message-ID: <1566630445-4599-3-git-send-email-wahrenst@gmx.net>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

The range check for period_ns was written under assumption of a fixed
PWM clock. With clk-bcm2835 driver the PWM clock is a dynamic one.
So fix this by doing the range check on the period register value.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 drivers/pwm/pwm-bcm2835.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 5276306..2c82386 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -21,7 +21,7 @@
 #define PERIOD(x)		(((x) * 0x10) + 0x10)
 #define DUTY(x)			(((x) * 0x10) + 0x14)

-#define MIN_PERIOD		108		/* 9.2 MHz max. PWM clock */
+#define PERIOD_MIN		0x2

 struct bcm2835_pwm {
 	struct pwm_chip chip;
@@ -64,6 +64,7 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
 	unsigned long rate = clk_get_rate(pc->clk);
 	unsigned long scaler;
+	u32 period;

 	if (!rate) {
 		dev_err(pc->dev, "failed to get clock rate\n");
@@ -71,14 +72,14 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}

 	scaler = DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
+	period = DIV_ROUND_CLOSEST(period_ns, scaler);

-	if (period_ns <= MIN_PERIOD)
+	if (period < PERIOD_MIN)
 		return -EINVAL;

 	writel(DIV_ROUND_CLOSEST(duty_ns, scaler),
 	       pc->base + DUTY(pwm->hwpwm));
-	writel(DIV_ROUND_CLOSEST(period_ns, scaler),
-	       pc->base + PERIOD(pwm->hwpwm));
+	writel(period, pc->base + PERIOD(pwm->hwpwm));

 	return 0;
 }
--
2.7.4
