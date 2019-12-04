From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Date: Wed, 4 Dec 2019 11:09:25 +0100
Message-ID: <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
 <1575451330-11112-2-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575451330-11112-2-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>
Cc: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 04, 2019 at 09:24:39AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> platform_irq_count() is the more generic way (independent of
> device trees) to determine the count of available interrupts. So
> use this instead.
> 
> As platform_irq_count() might return an error code (which
> of_irq_count doesn't) some additional handling is necessary.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Use %pe

Great. Note that with %pe there is a dependency on commit 57f5677e535b
("printf: add support for printing symbolic error names") which was
applied during the current merge window.

> V2:
>  Update commit log, and add err handling
>  Not tested, just code inspection
> 
> 
>  drivers/gpio/gpio-bcm-kona.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index 4122683eb1f9..baee8c3f06ad 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -19,7 +19,6 @@
>  #include <linux/io.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/of_device.h>
> -#include <linux/of_irq.h>
>  #include <linux/init.h>
>  #include <linux/irqdomain.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -586,11 +585,18 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>  
>  	kona_gpio->gpio_chip = template_chip;
>  	chip = &kona_gpio->gpio_chip;
> -	kona_gpio->num_bank = of_irq_count(dev->of_node);
> -	if (kona_gpio->num_bank == 0) {
> +	ret = platform_irq_count(pdev);
> +	if (!ret) {
>  		dev_err(dev, "Couldn't determine # GPIO banks\n");
>  		return -ENOENT;
> +	} else if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Couldn't determine GPIO banks: (%pe)\n",
> +				ERR_PTR(ret));

I'd say drop either the colon or the parenthesis.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
