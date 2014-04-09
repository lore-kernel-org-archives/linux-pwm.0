From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: mxs: set pwm_chip can_sleep flag
Date: Wed, 9 Apr 2014 12:46:53 +0200
Message-ID: <20140409104652.GC9527@ulmo>
References: <1396956597-26159-1-git-send-email-shawn.guo@freescale.com>
 <5343FDD3.3070308@i2se.com>
 <20140408175904.GT29751@pengutronix.de>
 <20140408234243.GB13898@piout.net>
 <20140409082341.GV29751@pengutronix.de>
 <20140409100313.GA20704@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:46455 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758351AbaDIKrt (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 06:47:49 -0400
Received: by mail-bk0-f41.google.com with SMTP id d7so2275284bkh.28
        for <linux-pwm@vger.kernel.org>; Wed, 09 Apr 2014 03:47:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140409100313.GA20704@piout.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Stefan Wahren <stefan.wahren@i2se.com>, Shawn Guo <shawn.guo@freescale.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2014 at 12:03:13PM +0200, Alexandre Belloni wrote:
> On 09/04/2014 at 10:23:41 +0200, Uwe Kleine-K=C3=B6nig wrote :
> > > While I had exactly the same issue back in september and wrote the ex=
act
> > > same patch that got rejected. I would agree with Thierry here taht we
> > > need to keep the pwm_disable() there as it potentially allows to save
> > > power.
> > >
> > > However, it seems to not work quite well with PWMs from Freescale (see
> > > the thread from Russell). Or I would say with PWM with an undefined
> > > state when disabled and I believe we are soon to find more.
> > >=20
> > > We could either:
> > >  - add a flag like can_sleep that would allow driver to know that the
> > >    pwm always has to be enable to get sane results.
> > >
> > >  - or introduce functions like prepare/unprepare to be called from pr=
obe
> > >    and remove in the leds-pwm driver and that will enable/disable the
> > > channel in pwm-mxs. pwm_enable/pwm_disable not doing anything.
> > There are a few more options. I repeat your's to get a single list:
> >=20
> >  a) Somehow tell the API users that pwm_disable might not result in a
> >     flat zero after set_duty(0).
> >  a') Anchor in the API that users must not expect anything from the pwm
> >     pin after pwm_disable.
> >  b) Make pwm_enable/pwm_disable noops on i.MX28
> >  c) Make set_duty only return when the new value reached the pin.
> >  d) Make pwm_disable wait to yield the expected result
> >  d') Make pwm_disable wait if the last programmed duty cycle is 0 or
> >     full period.
> >  e) Introduce a new callback that does the waiting, e.g. a .commit
> >     callback
> >  e') Introduce a new callback pwm_config_sync that does wait
> >     appropriatly, keep pwm_config as is.
> >  f) Make the i.MX28 driver switch the pin the gpio mode with the
> >     expected output level in pwm_disable.
> >=20
> > a') is a special case of a); d') is a special case of d), ditto for e')
> > and e).
> >=20
> > a) and e) would result in changes in the pwm API. For c) I'd like to
> > make the API docs more explicit, too. (i.e. demand that the new
> > configuration is already active after pwm_config returns)
> >=20
> > Both e) and a) have the drawback that the API becomes more complicated
> > and users will get it wrong. a) and b) are bad from a power management
> > POV. Maybe c) is what most users expect, but d) and d') are more
> > effective as they result in less waiting and still are good enough. f)
> > is more complicated to implement, also it depends on a gpio being
> > available in hardware. So if we choose f) we still might need a fallback
> > implementation from the other options.
> >=20
> > My series implemented a'), but Thierry didn't like it. I think my
> > favorite is e').
> >=20
>=20
> I think I would actually prefer d'. Doing the synchronisation in d' is
> abstracting it for the user.

My preference would be simply d). Mostly because I don't like special
cases and especially because I don't see an advantage in special casing
0 and full period duty cycles. That doesn't mean of course that drivers
can't special case if they really want or have to.

That said I've also been thinking about adding support for e), which
would allow atomically changing the duty cycle, period and polarity of a
channel. This might become necessary at some point.

The downside of course being that user drivers will need to change. But
I suspect that may not be necessary for existing users since the current
API works for them well enough (except for the case currently under
discussion, of course).

Thierry

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRSUcAAoJEN0jrNd/PrOhybAP/3C/nb2ayRozERUA4Zyi4Jw0
cJwC963rG8Y7AoBQcrkfxGx6BT//3aIaM5677NdM0wVmcRZwgP8rfabakRW2YXju
nRiV4wIeKL0EgOi4l2ybdQ5M+ilKHaTuhOHxVETJmM6jItuzc9RRajWdmboVXSdj
jBE+AIQcxuYPZPME9okss5OsGp8sIzbAB6lEu3f9L9HHx0s5vfukuWQULocyEHs5
UEsitN1ZYjW5/viEvINZNlmeuNBoMrElzxrqq9gvd4yiGBXPNH3Zv657Lz6IZ/oG
VF8lyrKYnKDyrUWubZ/+n7RHCn1DMpE0GuArwywNzEbRoDGzfBYG5VYELP4Ggp0N
2hdBcY1ZExPLdNFUOtaAOiwWpqEcVL7Kh4sT+J3WPHrlvsi6/YLLILGkx9TheLMT
qCye/cmuvrm4LW4fZ0jSXH/SxK/P9x7UY6PfhLEScO+tNAc1+KKJMS7AhvjdsXM8
W+oKAWzmh02vcP/OvF7uGZtri+OtxIy3nGMAnyNpSFh/Xc4UB9yHEjGxMD1Hyyt/
I84ujH7HxqiNl1vcLzNj5waFlAFQT8afl267KqTwV4fHiXiBVQZ47nX2TFLeUVuF
3yQp46UZsfRTzVgvbM7+OfHBJSxO11pPJwmK6rciG/gsrA/+L/jAYIftxYuH5n7l
HA0ImWv38Ui7VT7y0rXW
=/Ubq
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
