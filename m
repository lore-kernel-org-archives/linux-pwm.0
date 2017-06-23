From: Zhi Mao <zhi.mao@mediatek.com>
Subject: [PATCH v2 5/6] pwm: mediatek: add PWM_CLK_DIV_MAX
Date: Fri, 23 Jun 2017 13:08:24 +0800
Message-ID: <1498194505-30930-6-git-send-email-zhi.mao@mediatek.com>
References: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498194505-30930-1-git-send-email-zhi.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: john@phrozen.org, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, zhi.mao@mediatek.com, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com
List-Id: linux-pwm@vger.kernel.org

Replace "7" with "PWM_CLK_DIV_MAX" in function:mtk_pwm_config()
to improve the code readablity.

Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 554a042..e5f6425 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -30,6 +30,8 @@
 #define PWMDWIDTH		0x2c
 #define PWMTHRES		0x30
 
+#define PWM_CLK_DIV_MAX		7
+
 enum {
 	MTK_CLK_MAIN = 0,
 	MTK_CLK_TOP,
@@ -130,8 +132,10 @@ static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		clkdiv++;
 	}
 
-	if (clkdiv > 7)
+	if (clkdiv > PWM_CLK_DIV_MAX) {
+		dev_err(chip->dev, "period %d not supported\n", period_ns);
 		return -EINVAL;
+	}
 
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
 	mtk_pwm_writel(pc, pwm->hwpwm, PWMDWIDTH, period_ns / resolution);
-- 
1.7.9.5
