From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] pwm: meson: consider 128 a valid pre-divider
Date: Wed, 3 Apr 2019 13:19:41 +0200
Message-ID: <c8b6856c-3d2c-c59a-b3e6-5cfacc44d0e9@baylibre.com>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
 <20190401181817.11999-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401181817.11999-2-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com
List-Id: linux-pwm@vger.kernel.org

On 01/04/2019 20:18, Martin Blumenstingl wrote:
> The pre-divider allows configuring longer PWM periods compared to using
> the input clock directly. The pre-divider is 7 bit wide, meaning it's
> maximum value is 128 (the register value is off-by-one: 0x7f or 127).
> 
> Change the loop to also allow for the maximum possible value to be
> considered valid.
> 
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index f6e738ad7bd9..4b708c1fcb1d 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -188,7 +188,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  	do_div(fin_ps, fin_freq);
>  
>  	/* Calc pre_div with the period */
> -	for (pre_div = 0; pre_div < MISC_CLK_DIV_MASK; pre_div++) {
> +	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
>  		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
>  					    fin_ps * (pre_div + 1));
>  		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
> @@ -197,7 +197,7 @@ static int meson_pwm_calc(struct meson_pwm *meson,
>  			break;
>  	}
>  
> -	if (pre_div == MISC_CLK_DIV_MASK) {
> +	if (pre_div > MISC_CLK_DIV_MASK) {
>  		dev_err(meson->chip.dev, "unable to get period pre_div\n");
>  		return -EINVAL;
>  	}
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
