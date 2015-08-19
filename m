From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 2/2] pwm: Add support for R-Car PWM Timer
Date: Wed, 19 Aug 2015 12:07:33 +0200
Message-ID: <20150819100732.GC26627@ulmo>
References: <1439957639-4816-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1439957639-4816-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33813 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbHSKIj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2015 06:08:39 -0400
Content-Disposition: inline
In-Reply-To: <1439957639-4816-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 01:13:59PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for R-Car SoCs PWM Timer. The PWM timer of
> R-Car H2 has 7 channels. So, we can use the channels if we describe
> device tree nodes.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/pwm/Kconfig    |  11 ++
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-rcar.c | 265 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rcar.c

Found a couple more things. No need to respin for any of these, I can
make the changes when applying, but I'd like confirmation on a couple
of things below.

[...]
> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
[...]
> +static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int d=
uty_ns,
> +				int period_ns)
> +{
> +	unsigned long long one_cycle, tmp;	/* 0.01 nanoseconds */

I'm not quite sure why you need the extra multiplication and division by
100 here. Is this for extra accuracy?

> +	unsigned long clk_rate =3D clk_get_rate(rp->clk);
> +	u32 cyc, ph;
> +
> +	one_cycle =3D (unsigned long long)NSEC_PER_SEC * 100ULL * (1 << div);
> +	do_div(one_cycle, clk_rate);
> +
> +	tmp =3D period_ns * 100ULL;
> +	do_div(tmp, one_cycle);
> +	cyc =3D (tmp << RCAR_PWMCNT_CYC0_SHIFT) & RCAR_PWMCNT_CYC0_MASK;
> +
> +	tmp =3D duty_ns * 100ULL;
> +	do_div(tmp, one_cycle);
> +	ph =3D tmp & RCAR_PWMCNT_PH0_MASK;
> +
> +	/* Avoid prohibited setting */
> +	if (cyc !=3D 0 && ph !=3D 0) {
> +		rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
> +		return 0;
> +	} else {
> +		return -EINVAL;
> +	}

I think the ordering here is unintuitive, better would be:

	if (cyc =3D=3D 0 || ph =3D=3D 0)
		return -EINVAL;

	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);

	return 0;

> +static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)
> +{
> +	struct rcar_pwm_chip *rp =3D to_rcar_pwm_chip(chip);
> +	int div =3D rcar_pwm_get_clock_division(rp, period_ns);
> +	int ret;
> +
> +	if (div < 0)
> +		return div;
> +
> +	/* Let the core driver set pwm->period if disabled and duty_ns =3D=3D 0=
 */
> +	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
> +		return 0;
> +
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> +	ret =3D rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
> +	rcar_pwm_set_clock_control(rp, div);
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);

Just making sure: is it correct to execute the above two lines even if
ret < 0?

> +static int rcar_pwm_probe(struct platform_device *pdev)
> +{
> +	struct rcar_pwm_chip *rcar_pwm;
> +	struct resource *res;
> +	int ret;
> +
> +	rcar_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
> +	if (rcar_pwm =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rcar_pwm->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rcar_pwm->base))
> +		return PTR_ERR(rcar_pwm->base);
> +
> +	rcar_pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(rcar_pwm->clk)) {
> +		dev_err(&pdev->dev, "cannot get clock\n");
> +		return PTR_ERR(rcar_pwm->clk);
> +	}
> +
> +	platform_set_drvdata(pdev, rcar_pwm);
> +
> +	rcar_pwm->chip.dev =3D &pdev->dev;
> +	rcar_pwm->chip.ops =3D &rcar_pwm_ops;
> +	rcar_pwm->chip.of_xlate =3D of_pwm_xlate_with_flags;

This seems to be missing a:

	rcar_pwm->chip.of_pwm_n_cells =3D 3;

?

Thierry

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV1FVhAAoJEN0jrNd/PrOh32cP/ROFq1aDJ0F9X02hr/hDvdc1
6TnIHKRWKj8dk6wAS6lpDp0FQUj69x2xxAq3rj5E9bRi9JQgK88fWYlC8tkDxzdQ
DHfst/q5OBlGNxoAv1f7cRxyrFyh5d0MNtBTLmxBwCzAcCd0rsAM7PhZ8m/sMZs/
gsbfYfNJIhgTlHJ8y5QbjsyrG9IZm49Hiw0PH+ImLNm4QQZO6MF2Gyl35d/g845/
UYWNYWRo+qI37OMJUTcISNttgKDTuIcbv+YRFObSLbe95zo88Y29XT2dEcnfRwvI
vJMjzNAFXnmpcFnysWjxw0HgCpuIu6E2Ig1CWl5wrJG7A0dDwUxG/uvSUcJE4/+5
tUwIq/xeVoqKAPtGLTmKKRAxG6Ue8MUMsktZENg+77nfxXh945kf7lDnV2hj8XMT
w05vAIVqHsA4NmguWwlu8eRnSlDjFjnfYFqQiwrSQbvXaHXK5j5gtX97hodYaJuH
OfYYKOHzZZ71jou1AYVuVhC2L2UYxKEZiVqxTSHlg5c0i4aLkhJ0npBCLcIMnt38
EpuTldcll9HaaNjjf0r6Tsgq3P8kdJwwjVEh/2uY1VZ6fGWSDdd1v4gq+wK3G5rn
GsVYKbe6PpcRGcZiOYUnAezj3ynGanOxxhREpKAkKiDYqdJeI44tufjP4Ywl/fgt
65J9aCuYu9iS9HLfad6t
=YxoN
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
