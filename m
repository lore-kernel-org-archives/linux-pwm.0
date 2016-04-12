From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 08/11] pwm: sti: Add support for PWM Capture IRQs
Date: Tue, 12 Apr 2016 12:35:21 +0200
Message-ID: <20160412103521.GD18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35452 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbcDLKfY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Apr 2016 06:35:24 -0400
Content-Disposition: inline
In-Reply-To: <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 03:32:06PM +0000, Lee Jones wrote:
[...]
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> +static irqreturn_t sti_pwm_interrupt(int irq, void *data)
> +{
> +	struct sti_pwm_chip *pc =3D data;
> +	struct device *dev =3D pc->dev;
> +	struct sti_cpt_data *d;
> +	int channel;
> +	int cpt_int_stat;
> +	int reg;
> +	int ret =3D IRQ_NONE;
> +
> +	ret =3D regmap_field_read(pc->pwm_cpt_int_stat, &cpt_int_stat);
> +	if (ret)
> +		return ret;
> +
> +	while (cpt_int_stat) {
> +		channel =3D ffs(cpt_int_stat) - 1;
> +
> +		d =3D pc->cpt_data[channel];
> +
> +		/*
> +		 * Capture input:
> +		 *    _______                   _______
> +		 *   |       |                 |       |
> +		 * __|       |_________________|       |________
> +		 *   ^0      ^1                ^2
> +		 *
> +		 * Capture start by the first available rising edge
> +		 * When a capture event occurs, capture value (CPT_VALx)
> +		 * is stored, index incremented, capture edge changed.
> +		 *
> +		 * After the capture, if the index > 1, we have collected
> +		 * the necessary data so we signal the thread waiting for it
> +		 * and disable the capture by setting capture edge to none
> +		 *
> +		 */

How do you deal with the situation where someone will stop the PWM
signal half-way in? That is, suppose you've got events for the first and
second snapshots (0 and 1) and then someone stops the PWM and the event
for snapshot 2 never happens, how does the code recover?

> +
> +		regmap_read(pc->regmap,
> +			    PWM_CPT_VAL(channel), &d->snapshot[d->index]);
> +
> +		switch (d->index) {
> +		case 0:
> +		case 1:
> +			regmap_read(pc->regmap, PWM_CPT_EDGE(channel), &reg);
> +			reg ^=3D PWM_CPT_EDGE_MASK;
> +			regmap_write(pc->regmap, PWM_CPT_EDGE(channel), reg);
> +
> +			d->index++;
> +			break;
> +		case 2:
> +			regmap_write(pc->regmap,
> +				     PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> +			wake_up(&d->wait);
> +			break;
> +		default:
> +			dev_err(dev, "Internal error\n");
> +		}
> +
> +		clear_bit(channel, (unsigned long int *)&cpt_int_stat);

clear_bit() is a little unusual to use on regular data types, as
evidenced by the need for the goofy cast here.

> +
> +		ret =3D IRQ_HANDLED;
> +	}
> +
> +	/* Just ACK everything */
> +	regmap_write(pc->regmap, PWM_INT_ACK, PWM_INT_ACK_MASK);
> +
> +	return ret;
> +}
> +
>  static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  {
>  	struct device *dev =3D pc->dev;
> @@ -354,6 +425,11 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
>  	if (IS_ERR(pc->pwm_cpt_int_en))
>  		return PTR_ERR(pc->pwm_cpt_int_en);
> =20
> +	pc->pwm_cpt_int_stat =3D devm_regmap_field_alloc(dev, pc->regmap,
> +						reg_fields[PWM_CPT_INT_STAT]);
> +	if (IS_ERR(pc->pwm_cpt_int_stat))
> +		return PTR_ERR(pc->pwm_cpt_int_stat);
> +
>  	return 0;
>  }
> =20
> @@ -371,7 +447,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
>  	struct sti_pwm_chip *pc;
>  	struct resource *res;
>  	unsigned int chan;
> -	int ret;
> +	int ret, irq;
> =20
>  	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
>  	if (!pc)
> @@ -392,6 +468,19 @@ static int sti_pwm_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(pc->regmap))
>  		return PTR_ERR(pc->regmap);
> =20
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> +		return -ENODEV;
> +	}

I think you need to propagate the return value of platform_get_irq()
here.

> +
> +	ret =3D devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt,
> +			       0, pdev->name, (void *) pc);

No need for the explicit cast to void *.

Thierry

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDM9pAAoJEN0jrNd/PrOhZo0P/2EEXe1oI3Hz3TKK5UdFx4w4
xfm6aYT2klYus4b8Sjpf6mjhcP3sEXChubh6xBtJ8w0IH6SXu6rzVVEu+9vuLOUB
HwLaqpaHdMSwSWYoo7uc+0+PpZqikrSwBvpVwbBvAhoy6SFflJAXbzCMdC3YCl4L
beFf0MfIXY43bwS3dW5ddm7Vo5zQnAgeBagRmc7zPkmoAzuDTEvn7qUhUziLXFfj
zi84jYdDyhsqPzQDpfv0WDAXwKt/gu2W/vVz+CVK4wfru4FRwZmt70b70UxjnGQp
X0gsWrPVWiz7T9ErB/QqXoe3S+nhcuQys4JRoSk8/S+RhALBJmvaaXhfFw2Wox0g
9AMzEny82nqCA+lqItOlEavoXXTdPNwHch9JzGaLUOTKV4HM86M9IqXo7csekkAi
5PCdj5vnQ8b6Csc0ndMOgMkEvB12QlohmnHR7rpusjfrc8D/XvGL3oFh+yG6z2TU
cGpnAL8hrJbQPrWhsRbiOTOg++qmHXyeGJF2Ns6QATA6QGf1EjlTwvIPGahwtUpM
kS8mheaKgSbtAfXHkzZ3UtHlOhxloCcUiKcwv9IAYpl4qBkr1wvf9wviOYu+lRDA
3ioJRqFOE2+ZNG4bj/KyHi5Wq2tI03tpNH2N6oUnXwSEfmOBqLLjNWHmo3GhPhxa
hOMvpxFWlT59nGNPgKtY
=Os7N
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
