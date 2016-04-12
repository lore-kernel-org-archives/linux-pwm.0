From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
Date: Tue, 12 Apr 2016 12:53:14 +0200
Message-ID: <20160412105314.GE18882@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33943 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbcDLKxS (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Apr 2016 06:53:18 -0400
Content-Disposition: inline
In-Reply-To: <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> Once a PWM Capture has been initiated, the capture call
> enables a rising edge detection IRQ, then waits.  Once each
> of the 3 phase changes have been recorded the thread then
> wakes.  The remaining part of the call carries out the
> relevant calculations and passes back a formatted string to
> the caller.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> index 82a69e4..8de9b4a 100644
> --- a/drivers/pwm/pwm-sti.c
> +++ b/drivers/pwm/pwm-sti.c
> @@ -309,7 +309,79 @@ static void sti_pwm_free(struct pwm_chip *chip, stru=
ct pwm_device *pwm)
>  	clear_bit(pwm->hwpwm, &pc->configured);
>  }
> =20
> +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   int channel, char *buf)
> +{
> +	struct sti_pwm_chip *pc =3D to_sti_pwmchip(chip);
> +	struct sti_pwm_compat_data *cdata =3D pc->cdata;
> +	struct sti_cpt_data *d =3D pc->cpt_data[channel];
> +	struct device *dev =3D pc->dev;
> +	unsigned int f, dc;
> +	unsigned int high, low;
> +	bool level;
> +	int ret;
> +
> +	if (channel > cdata->cpt_num_chan - 1) {
> +		dev_err(dev, "Channel %d is not valid\n", channel);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&d->lock);

Should this perhaps reuse the struct pwm_device's ->lock?

> +
> +	/* Prepare capture measurement */
> +	d->index =3D 0;
> +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
> +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> +	ret =3D wait_event_interruptible_timeout(d->wait, d->index > 1, HZ);

The timeout here should make sure callers don't hang forever. But maybe
you can still make sure that when the PWM gets disabled the wait queue
is woken and perhaps return an appropriate error code to let users know
that the operation was interrupted.

Also, how about letting callers choose the value of the timeout? In some
cases they may be interested in long-running signals. In other cases the
whole second timeout may be much too long.

> +
> +	/*
> +	 * In case we woke up for another reason than completion
> +	 * make sure to disable the capture.
> +	 */
> +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);

The comment here is slightly confusing because it implies that disabling
the capture should be done conditionally, whereas it is always disabled.

> +
> +	if (ret =3D=3D -ERESTARTSYS)
> +		goto out;
> +
> +	switch (d->index) {
> +	case 0:
> +	case 1:
> +		/*
> +		 * Getting here could mean :
> +		 *  - input signal is constant of less than 1Hz
> +		 *  - there is no input signal at all
> +		 *
> +		 * In such case the frequency is rounded down to 0
> +		 * level of the supposed constant signal is reported
> +		 * using duty cycle min and max values.
> +		 */
> +		level =3D gpio_get_value(d->gpio);
> +
> +		ret =3D sprintf(buf, "0:%u\n", level ? CPT_DC_MAX : 0);
> +		break;
> +	case 2:
> +		/* We have evertying we need */
> +		high =3D d->snapshot[1] - d->snapshot[0];
> +		low  =3D d->snapshot[2] - d->snapshot[1];
> +
> +		/* Calculate frequency in Hz */
> +		f =3D clk_get_rate(pc->cpt_clk) / (1 * (high + low));

The multiplication by 1 is unnecessary.

Thierry

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNOYAAoJEN0jrNd/PrOh/7kP/1H1sxXnRAzeH5L208y7B5m5
lFF2IQUDL1i18GfAx8FqI5MCtfyytZRUFjeNB24i6Wzf4SIJ2sQEF6Xbw8dakdM7
PnTiicuIGZLMaN5Pmak069NI9GtooJivqwnirGSSM6D3605IkCQYQrQAxw7ZDnJB
0j5CV+uMWohPpLbuFo5oQ2CAsskGtkInny3u7BIioztZl5XWGrgW54Fsjb8qwVpL
Qcvpqy2CAIFx619P/TEoA8vx8dysBKLg7YFfOQb8HGlRWz2klzBQ8XWczMvqX+Ix
0Tivb2BvL3kKab34YSN0RSNZaJo6HiJJMPqsXdXaTAAjkpLDs3gIrMZ9ixHqs+LS
yQfaz/f/c1cTXJeWH4lb+scTe2Ry8lheQd0sNGGuY6TzeZXSmQ9XxyU+L4PmpjSH
0YV9qF7WkbHnk426JHoAIpEMQthKxe3XNW4mBCOU++7Ujq5Rj1kjT7RHCFPZOKVa
wpiXks19bgO485yDhDizHDceb1yaDUA7uRcJJDliIs0GWqzxBln5WxsqXWpfuQw8
+tnx5GeVIkUGFyM8iP0llskNA0mYftyj4cZIwbvNMIfLqpaWu5om9rk+ltYf+5NK
LV2NcWbCsK7LqcjMtI8B0x5+NVaZ4sr3hOZqY9Wjly7A2aQI21mQmWf7n8wFv1lg
bhYFeKLIh0H6hhuQFlaR
=fi1h
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
