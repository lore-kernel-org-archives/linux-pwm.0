From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
Date: Fri, 15 Apr 2016 16:20:06 +0200
Message-ID: <20160415142006.GD3472@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
 <20160412105314.GE18882@ulmo.ba.sec>
 <20160413102554.GQ8094@x1>
 <20160413152229.GC29509@ulmo.ba.sec>
 <20160415082900.GC3589@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33661 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcDOOUL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 10:20:11 -0400
Content-Disposition: inline
In-Reply-To: <20160415082900.GC3589@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 09:29:00AM +0100, Lee Jones wrote:
> On Wed, 13 Apr 2016, Thierry Reding wrote:
>=20
> > On Wed, Apr 13, 2016 at 11:25:54AM +0100, Lee Jones wrote:
> > > On Tue, 12 Apr 2016, Thierry Reding wrote:
> > >=20
> > > > On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> > > > > Once a PWM Capture has been initiated, the capture call
> > > > > enables a rising edge detection IRQ, then waits.  Once each
> > > > > of the 3 phase changes have been recorded the thread then
> > > > > wakes.  The remaining part of the call carries out the
> > > > > relevant calculations and passes back a formatted string to
> > > > > the caller.
> > > > >=20
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  1 file changed, 72 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > > > index 82a69e4..8de9b4a 100644
> > > > > --- a/drivers/pwm/pwm-sti.c
> > > > > +++ b/drivers/pwm/pwm-sti.c
>=20
> [...]
>=20
> > > > > +	/* Prepare capture measurement */
> > > > > +	d->index =3D 0;
> > > > > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING=
);
> > > > > +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> > > > > +	ret =3D wait_event_interruptible_timeout(d->wait, d->index > 1,=
 HZ);
> > > >=20
> > > > The timeout here should make sure callers don't hang forever. But m=
aybe
> > > > you can still make sure that when the PWM gets disabled the wait qu=
eue
> > > > is woken and perhaps return an appropriate error code to let users =
know
> > > > that the operation was interrupted.
> > >=20
> > > Sure.  I'll look into that.
> > >=20
> > > > Also, how about letting callers choose the value of the timeout? In=
 some
> > > > cases they may be interested in long-running signals. In other case=
s the
> > > > whole second timeout may be much too long.
> > >=20
> > > I'm not opposed to it.  How do you suggest we do that?
> >=20
> > The easiest would probably be to add an unsigned long timeout parameter
> > to the pwm_capture() function and ->capture() callbacks.
> >=20
> > But thinking about this further I'm wondering if it might not be easier
> > and more flexible to move the timeout completely outside of this code
> > and into callers. I suspect that the most simple way to do that would be
> > to add a completion to struct pwm_capture that callers can use to wait
> > for completion of a capture. This would make the whole process
> > asynchronous and allow interesting things like making the sysfs capture
> > file pollable, for example.
>=20
> Okay, so how do you propose we handle this with sysfs?  Perhaps
> another RW file to set it?

I'm unfamiliar with how this is done in other drivers, so I'd have to
look at them first. I suspect that it would be fine for now to simply
redesign the PWM API parts and keep some default timeout in sysfs. It
could be extended with some mechanism to override the default timeout
in the future.

Thierry

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXEPiWAAoJEN0jrNd/PrOhSYoP/AsCJkPSooXckFoNmvA5CgTu
KbNIMc8Ox1e7LKm88KTKFAqZeZOjk/6Kksj+166xrb7RL2IDIS5wB+cKTSTJPZ/5
rNSdjPa0wYkPyVdUI0RqYNK3hx1hP0cbW3p7ghLDlJDVrYTh2aJXqd6eMlUqosBe
Wk9Z+iLMtWgniEEWb0SEm5bJFEGdwlwyhUztMScSa8AfehXfynq6uSx6mdEbnzDY
V7D/6ONoJID5HWwb08DLUzXThc0u6nkZtTAwWeVCJJ5RnxMwKgnSSHkDghbMmd/Z
sOmTtSOjqSNLU1c+q0cYxRebkQltoz/eqk6fAhRf9OCY/U47AkS5/pJNuXuSDS/S
27b5gA3vc4y/n5Axgo9roNXSc/WXlxeOxj/IG7kGH1sm5DL8s+/OKem+P5DH3X8z
zh/KYD/HjElkf0NcNn3kAD349hUV1AQbZufbEVGxbNouJ2Urh+4SL9klACl5HHXl
OZcQwvy5xnWIaWZShGqpPs9c01qrf3kduJ8Lc3vhr29gNKVPDK6YqiGYqU9w0tJT
ppQAT9AAvnQrihR8OTCvQcJO/U+70vXQT0I3vkaCRMJJo3gHVt3bMzI9b0gkNUQl
bPH0XrEj71huFgtWx8gGSfp3f4e3Ceal56y09EYLs/5kKPlQOow3Kesi9wT5RmqL
4DYdFqc5wHHiE5UwUkhw
=dGkL
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
