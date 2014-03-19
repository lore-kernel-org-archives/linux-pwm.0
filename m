From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 08/16] backlight: pwm_bl: set pwm polarity when using platform
 data
Date: Wed, 19 Mar 2014 14:03:21 +0100
Message-ID: <1395234209-15546-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bryan Wu <cooloney@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-pwm@vger.kernel.org

Set inversed polarity when .pwm_active_low is set in the platform_data. With
device tree, this is taken care of by of_pwm_xlate_with_flags(), called from
of_pwm_get().

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/video/backlight/pwm_bl.c | 8 ++++++++
 include/linux/pwm_backlight.h    | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index b75201ff46f6..ffdd3b2b2742 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -309,6 +309,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (data->pwm_period_ns > 0)
 		pwm_set_period(pb->pwm, data->pwm_period_ns);
 
+	/*
+	 * The DT case is taking care of polarity in of_pwm_get(). For the
+	 * non-DT case, set the polarity from platform data.
+	 */
+	if (data->pwm_active_low)
+		if (pwm_set_polarity(pb->pwm, PWM_POLARITY_INVERSED))
+			dev_err(&pdev->dev, "impossible to invert polarity\n");
+
 	pb->period = pwm_get_period(pb->pwm);
 	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);
 
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index 2de2e275b2cb..b924fce5c97a 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -15,6 +15,7 @@ struct platform_pwm_backlight_data {
 	unsigned int dft_brightness;
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
+	bool pwm_active_low;
 	unsigned int *levels;
 	int enable_gpio;
 	unsigned long enable_gpio_flags;
-- 
1.8.3.2
