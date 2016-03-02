From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/6] pwm: pwm-img: test clock rate to avoid division by 0
Date: Wed,  2 Mar 2016 23:33:34 +0100
Message-ID: <1456958018-7849-4-git-send-email-wsa@the-dreams.de>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Should go individually via subsystem tree.

 drivers/pwm/pwm-img.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 8a029f9bc18cb0..2fb30deee34570 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -237,6 +237,11 @@ static int img_pwm_probe(struct platform_device *pdev)
 	}
 
 	clk_rate = clk_get_rate(pwm->pwm_clk);
+	if (!clk_rate) {
+		dev_err(&pdev->dev, "pwm clock has no frequency\n");
+		ret = -EINVAL;
+		goto disable_pwmclk;
+	}
 
 	/* The maximum input clock divider is 512 */
 	val = (u64)NSEC_PER_SEC * 512 * pwm->data->max_timebase;
-- 
2.7.0
