From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] gpio: bcm-kona: use platform_irq_count
Date: Tue, 3 Dec 2019 07:57:51 +0100
Message-ID: <20191203065751.w23dypag4745qv7i@pengutronix.de>
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575352925-17271-2-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>
Cc: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>
List-Id: linux-pwm@vger.kernel.org

On Tue, Dec 03, 2019 at 06:04:27AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use platform_irq_count to replace of_irq_count
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  Code inspection, not tested
> 
>  drivers/gpio/gpio-bcm-kona.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index 4122683eb1f9..c50721980a7c 100644
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
> @@ -586,7 +585,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>  
>  	kona_gpio->gpio_chip = template_chip;
>  	chip = &kona_gpio->gpio_chip;
> -	kona_gpio->num_bank = of_irq_count(dev->of_node);
> +	kona_gpio->num_bank = platform_irq_count(pdev);

of_irq_count returns 0 or a positive int while platform_irq_count might
return a negative error code. This needs handling. Also I wonder why
platform_irq_count() is better than of_irq_count() which would be good
to describe in the commit log.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
