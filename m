From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 1/4] pwm: sunxi: Code switched to regmap
 API instead of iomem.
Date: Thu, 16 Feb 2017 18:59:52 +0100
Message-ID: <20170216175952.34qn72pi47epma37@lukather>
References: <1487189167-32486-1-git-send-email-lis8215@gmail.com>
 <1487189167-32486-2-git-send-email-lis8215@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5q4w4pliiml6hgs"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBKXNTLCQKGQEPKFRDJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1487189167-32486-2-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--j5q4w4pliiml6hgs
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi, 

On Wed, Feb 15, 2017 at 11:06:04PM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> sun6i PWM has different register map in comparison to sun4i compatible
> SoCs. But bit map of the registers and behavior are very similar.
> 
> This patch introduces a uniform way to access PWM registers.
> 
> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

In order to be easier to review (and bisect if needed), could you
split that patch into one to convert to the regmap API, without any
change but to replace the sun4i_pwm_readl/sun4i_pwm_writel calls by
their regmap equivalent, and then convert to the regmap fields the
registers that need to?

> ---
>  drivers/pwm/Kconfig     |   2 +-
>  drivers/pwm/pwm-sun4i.c | 263 ++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 191 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 2d0cfaa..6b4dc1a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -416,7 +416,7 @@ config PWM_STMPE
>  config PWM_SUN4I
>  	tristate "Allwinner PWM support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on HAS_IOMEM && COMMON_CLK
> +	depends on REGMAP_MMIO && COMMON_CLK
>  	help
>  	  Generic PWM framework driver for Allwinner SoCs.
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index b0803f6..7291000 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -9,7 +9,7 @@
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> -#include <linux/io.h>
> +#include <linux/regmap.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -26,25 +26,56 @@
>  #define PWM_CH_PRD(ch)		(PWM_CH_PRD_BASE + PWM_CH_PRD_OFFSET * (ch))
> 
>  #define PWMCH_OFFSET		15
> -#define PWM_PRESCAL_MASK	GENMASK(3, 0)
> -#define PWM_PRESCAL_OFF		0
> -#define PWM_EN			BIT(4)
> -#define PWM_ACT_STATE		BIT(5)
> -#define PWM_CLK_GATING		BIT(6)
> -#define PWM_MODE		BIT(7)
> -#define PWM_PULSE		BIT(8)
> -#define PWM_BYPASS		BIT(9)
> +
> +#define PWM_PRESCAL_LSB		0
> +#define PWM_PRESCAL_MSB		3
> +#define PWM_PRESCAL_MASK	GENMASK(PWM_PRESCAL_MSB - PWM_PRESCAL_LSB, 0)
> +
> +#define PWM_EN_BIT		4
> +#define PWM_ACT_STATE_BIT	5
> +#define PWM_CLK_GATING_BIT	6
> +#define PWM_MODE_BIT		7
> +#define PWM_PULSE_BIT		8
> +#define PWM_BYPASS_BIT		9
> 
>  #define PWM_RDY_BASE		28
>  #define PWM_RDY_OFFSET		1
> -#define PWM_RDY(ch)		BIT(PWM_RDY_BASE + PWM_RDY_OFFSET * (ch))
> +#define PWM_RDY_BIT(ch)		(PWM_RDY_BASE + PWM_RDY_OFFSET * (ch))
> 
>  #define PWM_PRD(prd)		(((prd) - 1) << 16)
>  #define PWM_PRD_MASK		GENMASK(15, 0)
> 
>  #define PWM_DTY_MASK		GENMASK(15, 0)
> 
> -#define BIT_CH(bit, chan)	((bit) << ((chan) * PWMCH_OFFSET))
> +#define BIT_CH(bit, chan)	((bit) + ((chan) * PWMCH_OFFSET))
> +
> +#define FIELD_PRESCALER		0
> +#define FIELD_POLARITY		1
> +#define FIELD_CLK_GATING	2
> +#define FIELD_READY		3
> +#define NUM_FIELDS		4
> +
> +#define MAX_CHANNELS		2
> +
> +#define SUN4I_REGMAP_FIELDS(chan) {\
> +	[FIELD_PRESCALER] = \
> +		REG_FIELD(PWM_CTRL_REG, \
> +			  BIT_CH(PWM_PRESCAL_LSB, chan), \
> +			  BIT_CH(PWM_PRESCAL_MSB, chan)), \
> +	[FIELD_POLARITY] = \
> +		REG_FIELD(PWM_CTRL_REG, \
> +			  BIT_CH(PWM_ACT_STATE_BIT, chan), \
> +			  BIT_CH(PWM_ACT_STATE_BIT, chan)), \
> +	[FIELD_CLK_GATING] = \
> +		REG_FIELD(PWM_CTRL_REG, \
> +			  BIT_CH(PWM_CLK_GATING_BIT, chan), \
> +			  BIT_CH(PWM_CLK_GATING_BIT, chan)), \
> +	[FIELD_READY] = \
> +		REG_FIELD(PWM_CTRL_REG, \
> +			  PWM_RDY_BIT(chan), \
> +			  PWM_RDY_BIT(chan)), \
> +}
> +

This is not correct, unfortunately. If someone calls that macro with
chan++ or chan--, it will be modified four times instead of one as the
caller would expect.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--j5q4w4pliiml6hgs--
