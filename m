From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/4] pwm: mediatek: Provide missing kerneldoc description for 'soc' arg
Date: Mon, 29 Jun 2020 13:47:51 +0100
Message-ID: <20200629124752.1018358-4-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, John Crispin <blogic@openwrt.org>, Zhi Mao <zhi.mao@mediatek.com>, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Kerneldoc syntax is used, but not complete.

Descriptions are required for all arguments.

Fixes the following W=1 build warning:

 drivers/pwm/pwm-mediatek.c:57: warning: Function parameter or member 'soc' not described in 'pwm_mediatek_chip'

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Zhi Mao <zhi.mao@mediatek.com>
Cc: linux-pwm@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-mediatek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index b94e0d09c300f..ab001ce55178e 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -46,6 +46,7 @@ struct pwm_mediatek_of_data {
  * @clk_main: the clock used by PWM core
  * @clk_pwms: the clock used by each PWM channel
  * @clk_freq: the fix clock frequency of legacy MIPS SoC
+ * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
 	struct pwm_chip chip;
-- 
2.25.1
