From: Gaetan Hug <ghug@induct.be>
Subject: Found bug in pwm-mxs.c
Date: Tue, 27 Jan 2015 14:37:42 +0100
Message-ID: <54C794A6.3040805@induct.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-am1on0145.outbound.protection.outlook.com ([157.56.112.145]:51552
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752056AbbA0OJU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 27 Jan 2015 09:09:20 -0500
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Armadeus Forum ML <armadeus-forum@lists.sourceforge.net>, linux-pwm@vger.kernel.org

Hello folks,

   I found a bug in the pwm-mxs.c driver for the i.MX28 platform.

   The driver computes from the desired period which clock divider it 
should be using. This computation assumes that the link between the 
register value and the actual divider value is raising 2 to the power of 
the registry value.

    div = 1 << regvalue

   This is true only for the first 5 values out of 8. Next values are 
64, 256 and, 1024.
   This affects only the user only if he requests a period > 0.04369s.
   I solved this by replacing the computation of the divider value with 
a lookup table.

   If I should provide it in a different manner for it to be included in 
the kernel, please let me know.

Best regards

Gaetan Hug

------

diff --git i/drivers/pwm/pwm-mxs.c w/drivers/pwm/pwm-mxs.c
index c2c5a4f..cb89f7e 100644
--- i/drivers/pwm/pwm-mxs.c
+++ w/drivers/pwm/pwm-mxs.c
@@ -51,16 +51,17 @@ static int mxs_pwm_config(struct pwm_chip *chip, 
struct pwm_device *pwm,
         unsigned int period_cycles, duty_cycles;
         unsigned long rate;
         unsigned long long c;
+       unsigned const int cdiv[PERIOD_CDIV_MAX] = {1, 2, 4, 8, 16, 64, 
256, 1024};

         rate = clk_get_rate(mxs->clk);
         while (1) {
-               c = rate / (1 << div);
+               c = rate / cdiv[div];
                 c = c * period_ns;
                 do_div(c, 1000000000);
                 if (c < PERIOD_PERIOD_MAX)
                         break;
                 div++;
-               if (div > PERIOD_CDIV_MAX)
+               if (div >= PERIOD_CDIV_MAX)
                         return -EINVAL;
         }



