From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to
 MISC_CLK_SEL_MASK
Date: Mon, 27 May 2019 14:26:33 +0200
Message-ID: <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 25/05/2019 20:11, Martin Blumenstingl wrote:
> MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
> a bit-mask. Rename and change the macro to be a bit-mask so that
> conversion is not needed anymore. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pwm/pwm-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index c62a3ac924d0..84b28ba0f903 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -33,7 +33,7 @@
>  #define MISC_A_CLK_DIV_SHIFT	8
>  #define MISC_B_CLK_SEL_SHIFT	6
>  #define MISC_A_CLK_SEL_SHIFT	4
> -#define MISC_CLK_SEL_WIDTH	2
> +#define MISC_CLK_SEL_MASK	0x3

NIT I would have used GENMASK here

>  #define MISC_B_EN		BIT(1)
>  #define MISC_A_EN		BIT(0)
>  
> @@ -463,7 +463,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
>  
>  		channel->mux.reg = meson->base + REG_MISC_AB;
>  		channel->mux.shift = mux_reg_shifts[i];
> -		channel->mux.mask = BIT(MISC_CLK_SEL_WIDTH) - 1;
> +		channel->mux.mask = MISC_CLK_SEL_MASK;
>  		channel->mux.flags = 0;
>  		channel->mux.lock = &meson->lock;
>  		channel->mux.table = NULL;
> 

Anyway, it's still correct :

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
