From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH v1] pwm: pca9685: re-enable active pwm channels on pwm
 period change
Date: Sat, 4 Apr 2020 19:58:36 +0200
Message-ID: <20200404175836.GB55833@workstation.tuxnet>
References: <20200403235324.27437-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.pqgruber.com ([52.59.78.55]:33680 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDR6k (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 4 Apr 2020 13:58:40 -0400
Content-Disposition: inline
In-Reply-To: <20200403235324.27437-1-TheSven73@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 03, 2020 at 07:53:24PM -0400, Sven Van Asbroeck wrote:
> In order to change the pwm period, this chip must be put in sleep
> mode. However, when coming out of sleep mode, the pwm channel
> state is not completely restored: all pwm channels are off by
> default.
> 
> This results in a bug in this driver: when the pwm period is changed
> on a pwm channel, all other pwm channels will be deactivated.
> 
> Fix by clearing the RESTART bit when coming out of sleep mode - this
> will restore all pwm channels to their pre-sleep on/off state.
> 
> Reported-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Clemens Gruber <clemens.gruber@pqgruber.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com/
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
> 
> I no longer have access to pca9685 hardware, so I'm unable to test:
> - if this is indeed a bug
> - if this patch fixes it
> 
> Made against:
> Tree-repo: git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
> Tree-branch: for-next
> Tree-git-id: 9cc5f232a4b6a0ef6e9b57876d61b88f61bdd7c2
> 
>  drivers/pwm/pwm-pca9685.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 76cd22bd6614..0a16f0122e0e 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -59,6 +59,7 @@
>  
>  #define LED_FULL		(1 << 4)
>  #define MODE1_SLEEP		(1 << 4)
> +#define MODE1_RESTART		(1 << 7)
>  #define MODE2_INVRT		(1 << 4)
>  #define MODE2_OUTDRV		(1 << 2)
>  
> @@ -271,6 +272,15 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			/* Wake the chip up */
>  			pca9685_set_sleep_mode(pca, false);
>  
> +			/* If any pwm channels were active when the chip was put
> +			 * in sleep mode, re-activate them.
> +			 */
> +			if (!regmap_read(pca->regmap, PCA9685_MODE1, &reg) &&
> +			    reg & MODE1_RESTART)
> +				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> +						   MODE1_RESTART,
> +						   MODE1_RESTART);
> +
>  			pca->period_ns = period_ns;
>  		} else {
>  			dev_err(chip->dev,
> -- 
> 2.17.1
> 

According to the PCA9685 datasheet revision 4, page 15, the RESTART bit
is not only cleared by writing a 1 to it, but also by other actions like
a write to any of the PWM registers.

This seems to be the reason why I could not reproduce the reported
problem.

If I understand this correctly, clearing the RESTART bit would only be
necessary if we wanted every ON/OFF register to stay the same, but in
.config we might also get a different duty_ns value, so we have to
reprogram the ON/OFF time regs.
(Optimization: We could check if duty_ns to period_ns ratio stayed the
same and if so, clear the RESTART bit and return without reg writes)

Clemens
