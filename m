From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/2] pwm-pca9685: Support changing the output frequency
Date: Mon, 20 Jul 2015 11:58:14 +0200
Message-ID: <20150720095813.GU29614@ulmo>
References: <1437381369-8502-1-git-send-email-clemens.gruber@pqgruber.com>
 <1437381369-8502-3-git-send-email-clemens.gruber@pqgruber.com>
 <20150720093011.GQ29614@ulmo>
 <20150720094612.GA20084@pqgruber.com>
 <20150720095054.GB20084@pqgruber.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XSEVMyPRvc8xgDhM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36575 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbGTJ62 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 05:58:28 -0400
Received: by wgbcc4 with SMTP id cc4so33209417wgb.3
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2015 02:58:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150720095054.GB20084@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org


--XSEVMyPRvc8xgDhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 11:50:55AM +0200, Clemens Gruber wrote:
> On Mon, Jul 20, 2015 at 11:46:12AM +0200, Clemens Gruber wrote:
> > On Mon, Jul 20, 2015 at 11:30:22AM +0200, Thierry Reding wrote:
> > > On Mon, Jul 20, 2015 at 10:36:09AM +0200, Clemens Gruber wrote:
> > > > Previously, period_ns and duty_ns were only used to determine the
> > > > ratio of ON and OFF time, the default frequency of 200 Hz was never
> > > > changed.
> > > > The PCA9685 however is capable of changing the PWM output frequency,
> > > > which is expected when changing the period.
> > > >=20
> > > > This patch configures the prescaler accordingly, using the formula
> > > > and notes provided in the PCA9685 datasheet.
> > > > Bounds checking for the minimum and maximum frequencies, last updat=
ed
> > > > in revision v.4 of said datasheet, is also added.
> > > >=20
> > > > The prescaler is only touched if the period changed, because we hav=
e to
> > > > put the chip into sleep mode to unlock the prescale register.
> > > > If it is changed, the PWM output frequency changes for all outputs,
> > > > because there is one prescaler per chip. This is documented in the
> > > > PCA9685 datasheet and in the comments.
> > >=20
> > > I think the reason why the driver doesn't support changing the freque=
ncy
> > > is precisely because it has a per-chip prescaler. So you'd be changing
> > > the frequency from other all other users if one of the channels reque=
sts
> > > to do so. If I remember correctly there had been some discussion back=
 at
> > > the time that this wasn't safe to do.
> > >=20
> > > If you have to do this, I'd think you'd need to at least update the d=
uty
> > > cycle of all other users according to the new period.
> >=20
> > Hi, thanks for your feedback.
> >=20
> > Yes, that's true. You'd have to set the prescaler first and then manual=
ly set
> > all duty cycle values. Although this is a hardware feature, I can under=
stand
> > that this might be confusing.
> >=20
> > I will send a v4 to update the duty cycle of all other users after the =
chip
> > woke up again!
> > (Using the ratio from duty cycle to old period to set the new duty cycl=
e)
> >=20
> > Clemens
>=20
> Do you think it would be a good idea to print something to the kernel log=
 when
> changing the prescaler frequency? At the moment I only print an error whe=
n it is
> out of bounds.
> To notify the users that the frequency of all channels changed and the du=
ty
> cycle values have been adjusted?

None of the users would actually notice the kernel log entry, so I don't
think it makes much sense. One problem I see with this is that we might
start to see some sort of ping-pong happening between various users of
the PWMs of the same chip.

I guess it depends a bit on what the typical use-cases are for this
chip. Is it usually used only for LEDs (the register names suggest it)?
If so, how likely is it that people will want to drive them at different
periods? If it's reasonable to require the same period for all of them,
maybe it would be worth adding some sort of WARN_ON() or dev_warn() or
something to notify integrators of this fact.

Thierry

--XSEVMyPRvc8xgDhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrMYyAAoJEN0jrNd/PrOhEPcP/RL28+W+eT4ytbZbauug4X5O
7C+5v1SKvy06cTvyTcw0VEBeYYvDuteJxJn6Ks1JtRYqOyQ6hVK67smCxOl1i2Qf
naUh2q1nGw9gdHGBl26IRDkgJFD8MmMQUuIKTwp7hf4TJkszjJjWe6Q3p6BOs/Mo
tan7LS86Y03TdRF0nJMw5eDPH4/m1QUndgoGKPDNVsBDBK1ZcQ5SFAjWinYB2AvF
axQbtmFATDhDytKLsNw4Zm0cRDws2y4ehunNaL+Bhc3TWsFcC+wz2gtQZWzOXzjx
2Oa2G/Cyl+rNhG1NGsYZW+SjDjqqbwGU4W8f0WK74rK5TzXSzhIN9lr/Kis+0Dt3
ygYxfGKkQpDo0uqVXGUop/kXPkF1VIiYnZ6i7MYV5QszS0VLUDKfxPiHk/pkARVK
TkeNSU0957eZAA8Wzl6xPIfiiCWXrvivvW+a1RKq03RjrzdN9GFLNlYpB8G9F4Ia
49I7lTNLikQhegZeC9unMo8c3ESYtYiGDpSdZt2MsfreJlxvJ45xObf1eBD9j+3d
TLjwT0/UEjpvni8hx6tiWysTggr89jCaXwXQXftcK7rhjiVprZTKoGNLZaftyUqM
9DxrUk8QKkwe5ftkBBk0fquuGG4qxbbvq90ubdps9qa78dDmHD4ChhMP2Za7j07/
24w9jxlSSgeY3T6OhZ3n
=Ic8V
-----END PGP SIGNATURE-----

--XSEVMyPRvc8xgDhM--
