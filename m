From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [v2 5/7] pwm: crc: Add Crystalcove (CRC) PWM driver
Date: Mon, 22 Jun 2015 16:46:32 +0530
Message-ID: <5587EE90.2010105@gmail.com>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com> <1434970465-12687-6-git-send-email-shobhit.kumar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1434970465-12687-6-git-send-email-shobhit.kumar@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, Jani Nikula <jani.nikula@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Alexandre Courbot <gnurou@gmail.com>, David Airlie <airlied@linux.ie>, Povilas Staniulis <wdmonster@gmail.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com
List-Id: linux-pwm@vger.kernel.org

Hi Shobhit Kumar,

On 06/22/2015 04:24 PM, Shobhit Kumar wrote:

> The Crystalcove PMIC provides three PWM signals and this driver exports
> one of them on the BYT platform which is used to control backlight for
> DSI panel. This is platform device implementation of the drivers/mfd
> cell device for CRC PMIC.
>
> v2: Use the existing config callback with duty_ns and period_ns(Thierry)
>
> v3: Correct the subject line (Lee jones)
>
> v4: Address comment by Thierry & Paul
>      - Commit message update and fixes for few syntax errors
>      - Add PWM_CRC in Kconfig and Makefile sorted alphabetically
>      - Use the PWM_BASE_CLK as 6000000 for better code readability
>      - Remove the redundant rule of three while calculating pwm level
>      - Use the platform_device in pwm_chip
>      - Use builin_platform_driver
>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Paul Bolle <pebolle@tiscali.nl>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Shobhit Kumar <shobhit.kumar@intel.com>

(...)

> +
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/intel_soc_pmic.h>
> +#include <linux/pwm.h>
> +
> +#define PWM0_CLK_DIV		0x4B
> +#define  PWM_OUTPUT_ENABLE	(1 << 7)

Can't be BIT() macro ?

> +#define  PWM_DIV_CLK_0		0x00 /* DIVIDECLK = BASECLK */
> +#define  PWM_DIV_CLK_100	0x63 /* DIVIDECLK = BASECLK/100 */
> +#define  PWM_DIV_CLK_128	0x7F /* DIVIDECLK = BASECLK/128 */
> +
> +#define PWM0_DUTY_CYCLE		0x4E
> +#define BACKLIGHT_EN		0x51

(...)

> +static int crystalcove_pwm_probe(struct platform_device *pdev)
> +{
> +	struct crystalcove_pwm *pwm;
> +	int retval;
> +	struct device *dev = pdev->dev.parent;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->chip.dev = &pdev->dev;
> +	pwm->chip.ops = &crc_pwm_ops;
> +	pwm->chip.base = -1;
> +	pwm->chip.npwm = 1;
> +
> +	/* get the PMIC regmap */
> +	pwm->regmap = pmic->regmap;
> +
> +	retval = pwmchip_add(&pwm->chip);
> +	if (retval < 0)
> +		return retval;
> +
> +	platform_set_drvdata(pdev, pwm);
> +

If you can change this oder we can simply do something like this:
	
	platform_set_drvdata(pdev, pwm);
	
	return pwmchip_add(&pwm->chip);

> +	return 0;
> +}
> +
> +static int crystalcove_pwm_remove(struct platform_device *pdev)
> +{
> +	struct crystalcove_pwm *pwm = platform_get_drvdata(pdev);
> +	int retval;
> +
> +	retval = pwmchip_remove(&pwm->chip);
> +	if (retval < 0)
> +		return retval;
> +
> +	dev_dbg(&pdev->dev, "crc-pwm driver removed\n");

This debug message may not be required  :-)

you can directly do:

	return pwmchip_remove(&pwm->chip);

> +
> +	return 0;
> +}
> +
> +static struct platform_driver crystalcove_pwm_driver = {
> +	.probe = crystalcove_pwm_probe,
> +	.remove = crystalcove_pwm_remove,
> +	.driver = {
> +		.name = "crystal_cove_pwm",
> +	},
> +};
> +
> +builtin_platform_driver(crystalcove_pwm_driver);


-- 
Best regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
