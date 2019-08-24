From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 1/3] pwm: bcm2835: suppress error message for invalid period_ns
Date: Sat, 24 Aug 2019 09:07:23 +0200
Message-ID: <1566630445-4599-2-git-send-email-wahrenst@gmx.net>
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

The PWM config can be triggered via sysfs, so we better suppress the
error message in case of an invalid period to avoid kernel log spamming.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 drivers/pwm/pwm-bcm2835.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index f6fe0b9..5276306 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -72,11 +72,8 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,

 	scaler = DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);

-	if (period_ns <= MIN_PERIOD) {
-		dev_err(pc->dev, "period %d not supported, minimum %d\n",
-			period_ns, MIN_PERIOD);
+	if (period_ns <= MIN_PERIOD)
 		return -EINVAL;
-	}

 	writel(DIV_ROUND_CLOSEST(duty_ns, scaler),
 	       pc->base + DUTY(pwm->hwpwm));
--
2.7.4
