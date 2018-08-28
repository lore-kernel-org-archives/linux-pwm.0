From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH v5 7/9] pwm: add push-pull mode support
Date: Tue, 28 Aug 2018 16:01:24 +0300
Message-ID: <1535461286-12308-8-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, shc_work@mail.ru, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-pwm@vger.kernel.org

Add push-pull mode support. In push-pull mode the channels' outputs have
same polarities and the edges are complementary delayed for one period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/core.c  | 1 +
 include/linux/pwm.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 59a9df9120de..5fde2e685ca7 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -348,6 +348,7 @@ const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
 		"invalid",
 		"normal",
 		"complementary",
+		"push-pull",
 	};
 
 	if (!pwm_mode_valid(pwm, mode))
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a4ce4ad7edf0..eb170e2ab431 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -29,11 +29,14 @@ enum pwm_polarity {
  * PWM modes capabilities
  * @PWMC_MODE_NORMAL_BIT: PWM has one output
  * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
+ * @PWMC_MODE_PUSH_PULL_BIT: PWM has 2 outputs with same polarities and the
+ * edges are complementary delayed for one period
  * @PWMC_MODE_CNT: PWM modes count
  */
 enum {
 	PWMC_MODE_NORMAL_BIT,
 	PWMC_MODE_COMPLEMENTARY_BIT,
+	PWMC_MODE_PUSH_PULL_BIT,
 	PWMC_MODE_CNT,
 };
 
-- 
2.7.4
