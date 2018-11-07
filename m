From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/2] pwm: bcm-kona: apply pwm settings on enable
Date: Wed,  7 Nov 2018 10:36:13 +0100
Message-ID: <20181107093613.26734-2-peron.clem@gmail.com>
References: <20181107093613.26734-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107093613.26734-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Suji Velupillai <suji.velupillai@broadcom.com>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: linux-pwm@vger.kernel.org

From: Suji Velupillai <suji.velupillai@broadcom.com>

When pwm_bl framework calls enable, a call to pwm_is_enabled(pwm) still
return false, this prevents the backlight being turn on at boot time.

Signed-off-by: Suji Velupillai <suji.velupillai@broadcom.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-bcm-kona.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 09a95aeb3a70..d991d53c4b38 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -108,8 +108,8 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 	ndelay(400);
 }
 
-static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+static int __pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			 int duty_ns, int period_ns, bool pwmc_enabled)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
 	u64 val, div, rate;
@@ -155,7 +155,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * always calculated above to ensure the new values are
 	 * validated immediately instead of on enable.
 	 */
-	if (pwm_is_enabled(pwm)) {
+	if (pwm_is_enabled(pwm) || pwmc_enabled) {
 		kona_pwmc_prepare_for_settings(kp, chan);
 
 		value = readl(kp->base + PRESCALE_OFFSET);
@@ -173,6 +173,12 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	return __pwmc_config(chip, pwm, duty_ns, period_ns, false);
+}
+
 static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				  enum pwm_polarity polarity)
 {
@@ -216,8 +222,8 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	ret = kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
-			       pwm_get_period(pwm));
+	ret = __pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
+			    pwm_get_period(pwm), true);
 	if (ret < 0) {
 		clk_disable_unprepare(kp->clk);
 		return ret;
-- 
2.19.1
