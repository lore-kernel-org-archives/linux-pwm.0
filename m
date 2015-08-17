From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: Add support for R-Car PWM Timer
Date: Mon, 17 Aug 2015 16:15:35 +0200
Message-ID: <20150817141533.GB6891@ulmo.nvidia.com>
References: <1434359324-2964-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1434359324-2964-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36098 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbHQOQl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 10:16:41 -0400
Content-Disposition: inline
In-Reply-To: <1434359324-2964-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry for taking an awful long time to get around to this. The driver
looks generally okay, but I have a few minor comments...

On Mon, Jun 15, 2015 at 06:08:44PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for R-Car SoCs PWM Timer.

This could be a little more verbose. You could say for example how many
channels the driver exposes, or mention typical use-cases (if any).

> diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
[...]
> +static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
> +{
> +	int div;

Can be unsigned int.

> +	unsigned long clk_rate = clk_get_rate(rp->clk);
> +	unsigned long long max;	/* max cycle / nanoseconds */
> +
> +	if (!clk_rate)

I prefer it when these are explicit: clk_rate == 0. This goes for
numerical comparisons. For booleans, or NULL pointer comparisons the
!expression is fine.

> +static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int duty_ns, int period_ns)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +	int div = rcar_pwm_get_clock_division(rp, period_ns);
> +	int ret;
> +
> +	if (div < 0)
> +		return div;
> +
> +	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
> +	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
> +		return 0;
> +
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
> +	ret = rcar_pwm_set_counter(rp, div, duty_ns, period_ns);
> +	rcar_pwm_set_clock_control(rp, div);
> +	rcar_pwm_bit_modify(rp, RCAR_PWMCR_SYNC, 0, RCAR_PWMCR);
> +
> +	return ret;
> +}
> +
> +static int rcar_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
> +	u32 pwmcnt;
> +
> +	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
> +	pwmcnt = rcar_pwm_read(rp, RCAR_PWMCNT);
> +	if (!(pwmcnt & RCAR_PWMCNT_CYC0_MASK) ||
> +	    !(pwmcnt & RCAR_PWMCNT_PH0_MASK))
> +		return -EINVAL;

This looks wrong. Any errors in configuration should've been caught by
the ->config() implementation. Why can't you return -EINVAL on this
condition in ->config()? ->enable() failing should only be the case if
truly the PWM can't be enabled, not if it's badly configured.

> +static struct platform_driver rcar_pwm_driver = {
> +	.probe		= rcar_pwm_probe,
> +	.remove		= rcar_pwm_remove,
> +	.driver		= {
> +		.name	= "pwm-rcar",
> +		.of_match_table = of_match_ptr(rcar_pwm_of_table),
> +	}
> +};

This doesn't need the artificial padding. A single space around = is
enough.

Thierry

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0eyDAAoJEN0jrNd/PrOhu9kQAKeVWAhzWKmp/ZwizHZAVa+b
8AbjrzTU4RQHA9DdahmSQN9ozcPD2J6oTPmums7zDZtV0+YFrSEmpd0uZODgnbER
+z9N0KsAKrotXGynW8s7cM21ZGMsnLvuP5WAXrRHA+6pmyt9W2O7JkJqBEb1JKtk
dSkuNQ2o+d+/i+paHnnZ5MfWn92bbbFOtUBii317a5h7Kdipx+2Yfd7E3LXBHYOk
09SqLM7N2lCB+vTEeTFkaRER1jTmzWAb09L9MA2KZ9jQraO9oOaCWQ2BQ3jmiaOW
BZOodbVGXo233zB4HnQqEAlchvKyvfZtVGN/cS/zCrYfa7t5fFlHVzZMxvn3OTQU
8reg8s39z3pXi2ZBwKeNyr5Lsu/DGBMeahp3twjSedcKh4JWpJd75ioujqhBdAKw
C+FYbVtTZj66kKMxyfTMtB5BBh39jAQN00NuR7qbwKTjtldXQ+UO2LyF9gpJqzFB
7VkxiHhL4vOVQ6vFT91dHE+AxhSpLPLq3WrS5aLtKuWCquaV6+kD0wefIwEYlBOi
fJ7E0IDRXhLKv2fsrWsg9fFFoKoTp8e4Zfo7A6f2z8cdANqWRflqRqTz8x5TIIbG
7rB8RUQuG2oAPowHxE1h0xd6oWV1PGqZlM8DjN/eSxFGHGr0xP/MJrZ99jHrfg+4
LbQmIrtaLJxNKfhkOLTn
=PMw+
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
