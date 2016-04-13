From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
Date: Wed, 13 Apr 2016 17:22:29 +0200
Message-ID: <20160413152229.GC29509@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
 <20160412105314.GE18882@ulmo.ba.sec>
 <20160413102554.GQ8094@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33879 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbcDMPWf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2016 11:22:35 -0400
Content-Disposition: inline
In-Reply-To: <20160413102554.GQ8094@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 11:25:54AM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
>=20
> > On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> > > Once a PWM Capture has been initiated, the capture call
> > > enables a rising edge detection IRQ, then waits.  Once each
> > > of the 3 phase changes have been recorded the thread then
> > > wakes.  The remaining part of the call carries out the
> > > relevant calculations and passes back a formatted string to
> > > the caller.
> > >=20
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 72 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > index 82a69e4..8de9b4a 100644
> > > --- a/drivers/pwm/pwm-sti.c
> > > +++ b/drivers/pwm/pwm-sti.c
> > > @@ -309,7 +309,79 @@ static void sti_pwm_free(struct pwm_chip *chip, =
struct pwm_device *pwm)
> > >  	clear_bit(pwm->hwpwm, &pc->configured);
> > >  }
> > > =20
> > > +static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > > +			   int channel, char *buf)
> > > +{
> > > +	struct sti_pwm_chip *pc =3D to_sti_pwmchip(chip);
> > > +	struct sti_pwm_compat_data *cdata =3D pc->cdata;
> > > +	struct sti_cpt_data *d =3D pc->cpt_data[channel];
> > > +	struct device *dev =3D pc->dev;
> > > +	unsigned int f, dc;
> > > +	unsigned int high, low;
> > > +	bool level;
> > > +	int ret;
> > > +
> > > +	if (channel > cdata->cpt_num_chan - 1) {
> > > +		dev_err(dev, "Channel %d is not valid\n", channel);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	mutex_lock(&d->lock);
> >=20
> > Should this perhaps reuse the struct pwm_device's ->lock?

That was actually a stupid suggestion by me, because that lock is being
removed in an unrelated patch series.

> > > +	/* Prepare capture measurement */
> > > +	d->index =3D 0;
> > > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
> > > +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> > > +	ret =3D wait_event_interruptible_timeout(d->wait, d->index > 1, HZ);
> >=20
> > The timeout here should make sure callers don't hang forever. But maybe
> > you can still make sure that when the PWM gets disabled the wait queue
> > is woken and perhaps return an appropriate error code to let users know
> > that the operation was interrupted.
>=20
> Sure.  I'll look into that.
>=20
> > Also, how about letting callers choose the value of the timeout? In some
> > cases they may be interested in long-running signals. In other cases the
> > whole second timeout may be much too long.
>=20
> I'm not opposed to it.  How do you suggest we do that?

The easiest would probably be to add an unsigned long timeout parameter
to the pwm_capture() function and ->capture() callbacks.

But thinking about this further I'm wondering if it might not be easier
and more flexible to move the timeout completely outside of this code
and into callers. I suspect that the most simple way to do that would be
to add a completion to struct pwm_capture that callers can use to wait
for completion of a capture. This would make the whole process
asynchronous and allow interesting things like making the sysfs capture
file pollable, for example.

> > > +	/*
> > > +	 * In case we woke up for another reason than completion
> > > +	 * make sure to disable the capture.
> > > +	 */
> > > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> >=20
> > The comment here is slightly confusing because it implies that disabling
> > the capture should be done conditionally, whereas it is always disabled.
>=20
> Not really.  We do it unconditionally for reason explained.
>=20
> It says:
>=20
>   "disable the capture just in case X happens"
>=20
> rather than
>=20
>   "disable the capture if X happens".
>=20
> Perhaps the language is too subtle.  I can reword for clarity.

I'd be okay with just dropping the comment altogether, it seems rather
obvious to me. But clarifying is okay with me, too.

Thierry

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDmQ1AAoJEN0jrNd/PrOh028QAMGH3pE0JWnXBSSUIyn6yOIQ
EvPnyVKzbDTX+AGe/9/ZuQtZTF8p985iAqHMALk57doXennzhzP8DAdi4Iz+XRZM
G5wsPRWytQUkANW18L2V9LRDieSwHLfOsFRr82lRfCfuu7XS+rvGShCo8FTw5rq6
c+dXbMCSRt5K4dK4qKvJbW6oUolkUhZKeFfUynvZwkiAZ6q5GGirV0YXTIJ2X/OG
NAJdiW9rIVfddq8vSsLTlVJKcvXNMqL6G1PDnKR+M+s6IAvUAzNWvt23Aiy7v/0B
o5h2n8p6bALP8KkSeioUUIrOBs12LktMrvmWK3bh3cnNQp2/wPKr+vxS3WW25+yx
s9lvZ2Pb8rk2oIjP+BsTCThMa9FIpZXEKGPHkYdombSsl3FOHz9LPB/SnMHqQUmk
vwNdHkOJ58O7OHLoSETAJCLHvhsXiNZSSSHSyxPZwyf5Arw3LzXipuISXdjUWZbT
MY08VpHu4VZQMGVQC+3iGkIHPNQEDU5B6Q2ZEzqRofEbOVlrHh6haYeRGOQh05JH
MQmAbEzJLLoQ5ha3k5CPvPUEYH304RmbZOfgUic1udnshdLJDjctgFuwOFrAnu8h
W7Bf5IxaMdfPlaRAU+t6prO2ozz/KiUTMe9xrd0zks/QmcrXyO+BQaFJ1IZC5MxT
kT/taYMQjpriH2tlDZXz
=Ya8z
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
