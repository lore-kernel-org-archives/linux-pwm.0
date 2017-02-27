From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/9] pwm: sunxi: Use regmap API for
 register access.
Date: Mon, 27 Feb 2017 10:17:18 +0100
Message-ID: <20170227091718.nzjfk67osgntrrd2@lukather>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
 <1487914876-8594-2-git-send-email-lis8215@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q66xxue7mnicpq7j"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBH65Z7CQKGQESZWZW7A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1487914876-8594-2-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--q66xxue7mnicpq7j
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Siarhei,

On Fri, Feb 24, 2017 at 08:41:08AM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The patch replaces iomem register access routines to regmap
> equivalents.
> 
> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/pwm/Kconfig     |   2 +-
>  drivers/pwm/pwm-sun4i.c | 143 ++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 110 insertions(+), 35 deletions(-)
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
> index b0803f6..5565f03 100644
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
> @@ -74,7 +74,7 @@ struct sun4i_pwm_data {
>  struct sun4i_pwm_chip {
>  	struct pwm_chip chip;
>  	struct clk *clk;
> -	void __iomem *base;
> +	struct regmap *regmap;
>  	spinlock_t ctrl_lock;
>  	const struct sun4i_pwm_data *data;
>  };
> @@ -84,18 +84,6 @@ static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
>  	return container_of(chip, struct sun4i_pwm_chip, chip);
>  }
>  
> -static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
> -				  unsigned long offset)
> -{
> -	return readl(chip->base + offset);
> -}
> -
> -static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
> -				    u32 val, unsigned long offset)
> -{
> -	writel(val, chip->base + offset);
> -}
> -
>  static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    int duty_ns, int period_ns)
>  {
> @@ -152,7 +140,11 @@ static int sun4i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	}
>  
>  	spin_lock(&sun4i_pwm->ctrl_lock);
> -	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +	err = regmap_read(sun4i_pwm->regmap, PWM_CTRL_REG, &val);
> +	if (err) {
> +		dev_err(chip->dev, "failed to read from CTL register\n");
> +		goto err_cleanup;
> +	}

I'm not sure you need those error checks. If there's an error when you
write to an MMIO bus, you have much more important issues than your
return code there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--q66xxue7mnicpq7j--
