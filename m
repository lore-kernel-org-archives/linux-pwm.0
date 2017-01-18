From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [pwm:for-4.11/drivers 1/3] drivers/pwm/pwm-pca9685.c:171:15:
 error: 'offset' redeclared as different kind of symbol
Date: Wed, 18 Jan 2017 17:32:11 +0200
Message-ID: <20170118153211.GR2023@lahna.fi.intel.com>
References: <201701182217.IBub4l8v%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20039 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752141AbdARPcm (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Jan 2017 10:32:42 -0500
Content-Disposition: inline
In-Reply-To: <201701182217.IBub4l8v%fengguang.wu@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Wed, Jan 18, 2017 at 10:43:20PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-4.11/drivers
> head:   9a8be0b9496a69ac30a2b2529104459d944d6d6c
> commit: aba48949e7d5f83dcf08924ce09dd8951b419222 [1/3] pwm: pca9685: Allow any of the 16 PWMs to be used as a GPIO
> config: x86_64-randconfig-x014-201703 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout aba48949e7d5f83dcf08924ce09dd8951b419222
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pwm/pwm-pca9685.c: In function 'pca9685_pwm_gpio_set':
> >> drivers/pwm/pwm-pca9685.c:171:15: error: 'offset' redeclared as different kind of symbol
>      unsigned int offset;
>                   ^~~~~~
>    drivers/pwm/pwm-pca9685.c:166:71: note: previous definition of 'offset' was here
>     static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
>                                                                           ^~~~~~

This was due to the stylistic changes, I think. The original patch did
compile ;-)

Here is the fixup. Let me know if you prefer an incremental patch
instead.

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 019d0cc95d10..bbf408c332fa 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -168,17 +168,17 @@ static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
 {
 	struct pca9685 *pca = gpiochip_get_data(gpio);
 	struct pwm_device *pwm = &pca->chip.pwms[offset];
-	unsigned int offset;
+	unsigned int reg;
 
 	/* Clear both OFF registers */
-	offset = LED_N_OFF_L(pwm->hwpwm);
-	regmap_write(pca->regmap, offset, 0);
-	offset = LED_N_OFF_H(pwm->hwpwm);
-	regmap_write(pca->regmap, offset, 0);
+	reg = LED_N_OFF_L(pwm->hwpwm);
+	regmap_write(pca->regmap, reg, 0);
+	reg = LED_N_OFF_H(pwm->hwpwm);
+	regmap_write(pca->regmap, reg, 0);
 
 	/* Set the full ON bit */
-	offset = LED_N_ON_H(pwm->hwpwm);
-	regmap_write(pca->regmap, offset, value ? LED_FULL : 0);
+	reg = LED_N_ON_H(pwm->hwpwm);
+	regmap_write(pca->regmap, reg, value ? LED_FULL : 0);
 }
 
 static int pca9685_pwm_gpio_get_direction(struct gpio_chip *chip,
