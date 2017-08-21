From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 6/6] pwm: mediatek: add MT2712/MT7622 support
Date: Mon, 21 Aug 2017 10:05:11 +0200
Message-ID: <20170821080511.GP18996@ulmo>
References: <1498802721-32455-1-git-send-email-zhi.mao@mediatek.com>
 <1498802721-32455-7-git-send-email-zhi.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34523 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdHUIFO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 04:05:14 -0400
Content-Disposition: inline
In-Reply-To: <1498802721-32455-7-git-send-email-zhi.mao@mediatek.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Zhi Mao <zhi.mao@mediatek.com>
Cc: john@phrozen.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, yt.shen@mediatek.com, sean.wang@mediatek.com, zhenbao.liu@mediatek.com


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 02:05:21PM +0800, Zhi Mao wrote:
> 1. support multiple chip(MT2712, MT7622, MT7623)
> 2. add mtk_pwm_com_reg for match the registers of MT2712 pwm8
>    the register offset address of pwm8 for MT2712 is not fixed 0x40
>    and they are not the same as pwm0~6.
>=20
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/pwm/pwm-mediatek.c |   55 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 44 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 1d78ab1..2c9ce24 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/clk.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/slab.h>
> @@ -40,11 +41,19 @@ enum {
>  	MTK_CLK_PWM3,
>  	MTK_CLK_PWM4,
>  	MTK_CLK_PWM5,
> +	MTK_CLK_PWM6,
> +	MTK_CLK_PWM7,
> +	MTK_CLK_PWM8,
>  	MTK_CLK_MAX,
>  };
> =20
> -static const char * const mtk_pwm_clk_name[] =3D {
> -	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5"
> +static const char * const mtk_pwm_clk_name[MTK_CLK_MAX] =3D {
> +	"main", "top", "pwm1", "pwm2", "pwm3", "pwm4",
> +	"pwm5", "pwm6", "pwm7", "pwm8"

You're wrapping these lines at arbitrary boundaries. Make sure to use
all of the 80 columns at your disposal.

> +};
> +
> +struct mtk_com_pwm_data {

What does the _com stand for in the above?

> +	unsigned int pwm_nums;
>  };

Maybe name this num_pwms for consistency with other drivers?

> =20
>  /**
> @@ -57,6 +66,11 @@ struct mtk_pwm_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;
>  	struct clk *clks[MTK_CLK_MAX];
> +	const struct mtk_com_pwm_data *data;
> +};
> +
> +static const unsigned long mtk_pwm_com_reg[] =3D {

There's another of these _com that I don't understand what it means.
Also since these are all fairly small offsets, these can simply be
unsigned int.

> +	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
>  };
> =20
>  static inline struct mtk_pwm_chip *to_mtk_pwm_chip(struct pwm_chip *chip)
> @@ -103,14 +117,14 @@ static void mtk_pwm_clk_disable(struct pwm_chip *ch=
ip, struct pwm_device *pwm)
>  static inline u32 mtk_pwm_readl(struct mtk_pwm_chip *chip, unsigned int =
num,
>  				unsigned int offset)
>  {
> -	return readl(chip->regs + 0x10 + (num * 0x40) + offset);
> +	return readl(chip->regs + mtk_pwm_com_reg[num] + offset);
>  }
> =20
>  static inline void mtk_pwm_writel(struct mtk_pwm_chip *chip,
>  				  unsigned int num, unsigned int offset,
>  				  u32 value)
>  {
> -	writel(value, chip->regs + 0x10 + (num * 0x40) + offset);
> +	writel(value, chip->regs + mtk_pwm_com_reg[num] + offset);
>  }
> =20
>  static int mtk_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -194,23 +208,28 @@ static int mtk_pwm_probe(struct platform_device *pd=
ev)
>  	if (!pc)
>  		return -ENOMEM;
> =20
> +	pc->data =3D of_device_get_match_data(&pdev->dev);
> +
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pc->regs =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(pc->regs))
>  		return PTR_ERR(pc->regs);
> =20
> -	for (i =3D 0; i < MTK_CLK_MAX; i++) {
> +	for (i =3D 0; i < pc->data->pwm_nums + 2; i++) {
>  		pc->clks[i] =3D devm_clk_get(&pdev->dev, mtk_pwm_clk_name[i]);
> -		if (IS_ERR(pc->clks[i]))
> +		if (IS_ERR(pc->clks[i])) {
> +			dev_err(&pdev->dev, "[PWM] clock: %s fail: %ld\n",
> +				mtk_pwm_clk_name[i], PTR_ERR(pc->clks[i]));

Why include the "[PWM] " prefix in the above message?

>  			return PTR_ERR(pc->clks[i]);
> +		}
>  	}
> =20
> -	platform_set_drvdata(pdev, pc);
> -
>  	pc->chip.dev =3D &pdev->dev;
>  	pc->chip.ops =3D &mtk_pwm_ops;
>  	pc->chip.base =3D -1;
> -	pc->chip.npwm =3D 5;
> +	pc->chip.npwm =3D pc->data->pwm_nums;
> +
> +	platform_set_drvdata(pdev, pc);

No need to move the location of the platform_set_drvdata() call. It's
needless churn.

>  static const struct of_device_id mtk_pwm_of_match[] =3D {
> -	{ .compatible =3D "mediatek,mt7623-pwm" },
> -	{ }
> +	{.compatible =3D "mediatek,mt2712-pwm", .data =3D &mt2712_pwm_data},
> +	{.compatible =3D "mediatek,mt7622-pwm", .data =3D &mt7622_pwm_data},
> +	{.compatible =3D "mediatek,mt7623-pwm", .data =3D &mt7623_pwm_data},
> +	{},

Spaces after { and before }, please.

Thierry

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmalDYACgkQ3SOs138+
s6F1UxAAs7dPLBLVhPaJD6btazF9emgTfCat4T9vEyJzRzPgKgHF8Fmf4aXSXCYs
st0JALRGoSWWnTNbV2ghLxouihU7jAumSdaJTWY8Haa+63ynnf/SANaMAE+DEaBE
otF4F8hlkPZGJDT0xrp18zUtI232qq/RhYdE41f/jGpIRiLLMAYzlKjxOGGimxJm
CSaY8/c70VnOoB0VJh2H8juYH2gwcTXd3Mp4KMbA3MREr1/KKE+Ej2uieMfLPTn/
mOXxHGgv+Tq0tnzGNcagHIZSowpJU6mk39KNp4V0GupaLNkS/vJ+Yn2Yzy5Myjmw
HgCc1WGR6fgNwWULZzccwJjT2XUIk2nPg2BQlEj9scMMEydTHJ5zUl/OPrmhPevs
tEvEz1B6u9IO2dsniHjT7mFrbSUtexfpqs1cTl0u28ARMr7VgzjhL8ZJPiICFUsA
mSNJQa3puplHtHfSa4pKN74ovAaDImiJIFXn+2qBwl+GXZ2jQ/5JUt+CrlLxnL9W
A36z9gew9XxZcDJ9k5sCDxqcVm4+c1U4fttc+LsZpyDGyKka8z5+AtBsFkF7UTP0
GF8hFMigiEPokrbj/oQ4ka10pQNCYeuAEi1CIPG3E5GKosAvW/0/ZaMy5KT9Zfxh
LNmvuw+x4lZoSiWOheyiLTnvXTd1scG79WZo+2LMXBSUCoY12Ic=
=onfv
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--
