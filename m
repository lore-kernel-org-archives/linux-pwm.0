From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Add CLPS711X PWM support
Date: Mon, 6 Jan 2014 17:12:35 +0100
Message-ID: <20140106161233.GB6721@ulmo.nvidia.com>
References: <1388547821-10029-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:39062 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbaAFQOm (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jan 2014 11:14:42 -0500
Content-Disposition: inline
In-Reply-To: <1388547821-10029-1-git-send-email-shc_work@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 01, 2014 at 07:43:41AM +0400, Alexander Shiyan wrote:
> Add a new driver for the PWM controllers on the CLPS711X platform
> based on the PWM framework.

I think you can drop the last part ("based on the PWM framework") of
that sentence. Perhaps a good idea would be to mention some of the
peculiarities of this controller (supports two channels, only 4 bits
specifying the duty-cycle, fixed period, ...).

> diff --git a/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
> new file mode 100644
> index 0000000..4caf819
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/cirrus-clps711x-pwm.txt
> @@ -0,0 +1,16 @@
> +* Cirris Logic CLPS711X PWM controller
> +
> +Required properties:
> +- compatible: Should be "cirrus,clps711x-pwm".
> +- reg: Physical base address and length of the controller's registers.
> +- clocks: Phandle to the PWM source clock.

"phandle"

> +- #pwm-cells: Should be 1. See pwm.txt in this directory for a description of
> +  the cells format.

Perhaps in this case it would be easier to simply mention that the cell
specifies the index of the channel. pwm.txt isn't explicit about what a
specifier of size 1 looks like (although it is sort of implied).

> diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
[...]
> +struct clps711x_chip {
> +	struct pwm_chip	chip;
> +	struct clk	*clk;
> +	void __iomem	*pmpcon;
> +	spinlock_t	lock;
> +};

I'd prefer this to not use this artificial alignment using tabs. Simply
a single space after the type is good enough.

> +static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct clps711x_chip *priv =
> +		container_of(chip, struct clps711x_chip, chip);

This should be wrapped into a static inline function to make it shorter:

	static inline to_clps711x(struct pwm_chip *chip)
	{
		return container_of(chip, struct clps711x_chip, chip);
	}

> +	unsigned int period, freq = clk_get_rate(priv->clk);
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	/* Calculate and store constant period value */
> +	period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
> +	pwm_set_period(pwm, period);
> +	pwm_set_chip_data(pwm, (void *)(uintptr_t)period);

Why store this in chip data again if it can be retrieved directly from
the PWM device using pwm_get_period()?

> +static int clps711x_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	/* Do nothing */
> +	return 0;
> +}
> +
> +static void clps711x_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	/* Do nothing */
> +}

I think it would be better if this would set the duty field to 0 to stop
any potential toggling of the PWM signal. .enable() can later restore
the proper value.

The reason for this is that pwm_disable() is supposed to stop the PWM
output from toggling and if you simply ignore it you don't conform to
the API specification.

> +static const struct pwm_ops clps711x_pwm_ops = {
> +	.request	= clps711x_pwm_request,
> +	.config		= clps711x_pwm_config,
> +	.enable		= clps711x_pwm_enable,
> +	.disable	= clps711x_pwm_disable,
> +	.owner		= THIS_MODULE,
> +};

Please drop the alignment here as well.

> +static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {

I don't think there's concensus on the proper placement, but I prefer
__maybe_unused to be at the very end of the declaration.

> +static struct platform_driver clps711x_pwm_driver = {
> +	.driver	= {
> +		.name		= "clps711x-pwm",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= of_match_ptr(clps711x_pwm_dt_ids),
> +	},
> +	.probe	= clps711x_pwm_probe,
> +	.remove	= clps711x_pwm_remove,
> +};
> +module_platform_driver(clps711x_pwm_driver);

And again, no alignment of the fields here, please.

Thierry

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSytXxAAoJEN0jrNd/PrOhCcsQAJ0oZnSg+HrXAslfNswzlDnQ
QuCbYOsmUG4on0PfJZ/fEs+uuueaVPpohlWaJ73xSdRHqJU35tKXmstohHADcl6k
VkKtZZs4PqG7iHRBrIJo+HoGrDfqCW3gmkqtXzG9SKWgq36cYv5MJr7QFZpWb9Qr
5iwxbJzHwjireX+8JBH/Q/FcDtAJw5V9IckZVpwPeJRdPpDeGhN0fsfGj6j/EzTi
5YmZq6nuJlzuLMej5NfDUm2dABJ6kVZvFNysKNeFwERjIGas9PlypfTxBuB+Vh63
nq+wMyGYOkH095UF/Thv4uyKrvpg5d0UvTqyD/rTFshAT/cIkpIMpSmUIO1zxO7h
eGlS25vD+83Y24q+DR6xiaO+C484t056NRqNOKH9drt2fjZBAgC3ml4b1tBdEiPZ
wszN5ofiK4wtpprleixUdZl7mMAsyn5wcE5fMhlDFZ9p0cQKZGsW11yk8YrhySOw
GzDIsWczWRKBxNpjg1gOIcyDJzMhydUwB7ZbKoS53ktDuX8WoxK2hZEMRABFj5fI
z/hSN+ZIUXPBWcubdE2QFS5CSVZTASQHoWTrqD34IREOl1/JYpH7jon580lbEX1H
x4jcV+jQa67633rF5IyMTYxvxULVV+XzsO6xlPk6Bd3H2pX1UEoVsVpBu3GPPsmu
fRCyd416PeqTPKdwMPhB
=coKs
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
