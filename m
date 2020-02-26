From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/4] pwm: pca9685: initialize all LED registers during
 probe
Date: Wed, 26 Feb 2020 16:00:51 +0100
Message-ID: <20200226150051.sbopz7uzbdhtccba@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56983 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgBZPAy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 10:00:54 -0500
Content-Disposition: inline
In-Reply-To: <20200226135229.24929-3-matthias.schiffer@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 02:52:28PM +0100, Matthias Schiffer wrote:
> Initialize all ON delays to 0 during probe, rather than doing it in
> pca9685_pwm_enable.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 393ab92aa945..370691b21107 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -289,13 +289,6 @@ static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct pca9685 *pca = to_pca(chip);
>  
> -	/*
> -	 * The PWM subsystem does not support a pre-delay.
> -	 * So, set the ON-timeout to 0
> -	 */
> -	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
> -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
> -
>  	/*
>  	 * Clear the full-off bit.
>  	 * It has precedence over the others and must be off.
> @@ -388,6 +381,13 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
>  
> +	/*
> +	 * The PWM subsystem does not support a pre-delay.
> +	 * So, set the ON-timeout to 0
> +	 */
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> +

What is a pre-delay: Something like:
          _________                   ______
    _____/         \_________________/
    ^                           ^

Where ^ marks the period start and then the time between period start
and the rising signal is the pre-delay?

If so, the IMHO more right approach is to keep the pre-delay until a new
setting is applied and in .get_state ignore the pre-delay. This way you
don't modify the output in .probe() which sounds right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
