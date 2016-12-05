From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCH] pwm: pca9685: Fix misuse of regmap_update_bits
Date: Mon, 5 Dec 2016 17:34:02 +0100
Message-ID: <20161205163402.GA14964@archie.localdomain>
References: <1480438970-15317-1-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480438970-15317-1-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Florian Vaussard <florian.vaussard@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 29, 2016 at 06:02:50PM +0100, Florian Vaussard wrote:
> Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
> and k greater than 0 is wrong. Indeed, _regmap_update_bits will perform
> (mask & 1), which results in 0 if LSB of mask is 0. Thus the call
> regmap_update_bits(..., mask, 1) is in reality equivalent to
> regmap_update_bits(..., mask, 0).
> 
> In such a case, the correct use is regmap_update_bits(..., mask, mask).
> 
> This driver is performing such a mistake with the MODE1_RESTART mask,
> which equals (1 << 6). Fix the driver to make it consistent with the
> API. Please note that this change is untested, as I do not have this
> piece of hardware. Testers are welcome!
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  drivers/pwm/pwm-pca9685.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 117fccf..6b9ff6c 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -124,7 +124,8 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			 */
>  			if (duty_ns == pca->duty_ns) {
>  				regmap_update_bits(pca->regmap, PCA9685_MODE1,
> -						   MODE1_RESTART, 0x1);
> +						   MODE1_RESTART,
> +						   MODE1_RESTART);
>  				return 0;
>  			}
>  		} else {
> -- 
> 2.5.5

Good catch!
During testing your change however, I noticed that this whole
conditional for duty_ns == pca->duty_ns (which I added) is bogus:
Restarting the chip means using the same ON and OFF times as before, so
the duty cycle "ratio" stays the same, relative to the period.
Here we are checking for an equal duty cycle in nanoseconds though..

Instead we would have to check if the ratio changed and only if it did
not, set the RESTART bit.

Or we could just remove that conditional. This is only an optimization
for the special case of changing both period_ns and duty_ns at the same
time but with the same ratio as before.

Clemens
