From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to
 MISC_CLK_SEL_MASK
Date: Tue, 11 Jun 2019 18:33:18 +0200
Message-ID: <20190611163318.tfb5c4jbekjybj76@pengutronix.de>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-5-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190608180626.30589-5-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello,

[added clk-people to recipients]

On Sat, Jun 08, 2019 at 08:06:16PM +0200, Martin Blumenstingl wrote:
> MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
> a bit-mask. Rename and change the macro to be a bit-mask so that
> conversion is not needed anymore. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

IMHO clk_mux is ugly here. It could easily just take

	.mask = 3 << mux_reg_shifts[i],

as input parameter instead of

	.mask = 3,
	.shift = mux_reg_shifts[i],

. Then the usage would be (IMHO) a bit more natural, the clock mask
could then be defined as:

	#define MISC_CLK_SEL_MASK(i)	GENMASK(5 + 2 * (i), 4 + 2 * (i))

and this value could just be passed to the clk_mux.

(OK, this could be done already now, and then we'd do

	channel->mux.shift = ffs(MISC_CLK_SEL_MASK(i)) - 1;
	channel->mux.mask = MISC_CLK_SEL_MASK(i) >> channel->mux.shift;

.)

Apart from that, I wonder if the pwm-meson driver should better use
clk_register_mux instead of open coding it. (Though there doesn't seem
to exists a devm_ variant of it.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
