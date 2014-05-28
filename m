From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 09/15] avr32: MRMT: use generic leds_pwm driver
Date: Thu, 29 May 2014 01:20:12 +0200
Message-ID: <1401319218-16772-10-git-send-email-alexandre.belloni@free-electrons.com>
References: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401319218-16772-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-leds@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-pwm@vger.kernel.org

Switch to the generic leds_pwm driver instead of leds-atmel-pwm.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 arch/avr32/boards/atngw100/mrmt.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
index 1ba09e4c02b1..91146b416cdb 100644
--- a/arch/avr32/boards/atngw100/mrmt.c
+++ b/arch/avr32/boards/atngw100/mrmt.c
@@ -17,6 +17,8 @@
 #include <linux/types.h>
 #include <linux/fb.h>
 #include <linux/leds.h>
+#include <linux/pwm.h>
+#include <linux/leds_pwm.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/atmel_serial.h>
@@ -155,21 +157,28 @@ static struct platform_device rmt_ts_device = {
 
 #ifdef CONFIG_BOARD_MRMT_BL_PWM
 /* PWM LEDs: LCD Backlight, etc */
-static struct gpio_led rmt_pwm_led[] = {
-	/* here the "gpio" is actually a PWM channel */
-	{ .name = "backlight",	.gpio = PWM_CH_BL, },
+static struct pwm_lookup pwm_lookup[] = {
+	PWM_LOOKUP("at91sam9rl-pwm", PWM_CH_BL, "leds_pwm", "ds1",
+		   5000, PWM_POLARITY_INVERSED),
 };
 
-static struct gpio_led_platform_data rmt_pwm_led_data = {
-	.num_leds	= ARRAY_SIZE(rmt_pwm_led),
-	.leds		= rmt_pwm_led,
+static struct led_pwm pwm_leds[] = {
+	{
+		.name = "backlight",
+		.max_brightness = 255,
+	},
+};
+
+static struct led_pwm_platform_data pwm_data = {
+	.num_leds       = ARRAY_SIZE(pwm_leds),
+	.leds           = pwm_leds,
 };
 
-static struct platform_device rmt_pwm_led_dev = {
-	.name		= "leds-atmel-pwm",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &rmt_pwm_led_data,
+static struct platform_device leds_pwm = {
+	.name   = "leds_pwm",
+	.id     = -1,
+	.dev    = {
+		.platform_data = &pwm_data,
 	},
 };
 #endif
@@ -325,7 +334,8 @@ static int __init mrmt1_init(void)
 #ifdef CONFIG_BOARD_MRMT_BL_PWM
 	/* Use PWM for Backlight controls */
 	at32_add_device_pwm(1 << PWM_CH_BL);
-	platform_device_register(&rmt_pwm_led_dev);
+	pwm_add_table(pwm_lookup, ARRAY_SIZE(pwm_lookup));
+	platform_device_register(&leds_pwm);
 #else
 	/* Backlight always on */
 	udelay( 1 );
-- 
1.9.1
