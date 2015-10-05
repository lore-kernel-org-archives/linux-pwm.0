From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC] pwm: core: unsigned or signed ints for pwm_config
Date: Mon, 5 Oct 2015 12:00:44 +0200
Message-ID: <20151005100044.GC30219@ulmo>
References: <560A3B7F.30803@schinagl.nl>
 <20150929074552.GA3648@ulmo>
 <560D7F93.1030609@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37997 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbbJEKAr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Oct 2015 06:00:47 -0400
Content-Disposition: inline
In-Reply-To: <560D7F93.1030609@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver+list@schinagl.nl>
Cc: linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2015 at 08:46:43PM +0200, Olliver Schinagl wrote:
> Hey Thierry,
>=20
> On 29-09-15 09:45, Thierry Reding wrote:
> >On Tue, Sep 29, 2015 at 09:19:27AM +0200, Olliver Schinagl wrote:
> >>Hey Thierry, list
> >>
> >>I'm going over the pwm core and notice that in the pwm header, duty_ns =
and
> >>period_ns is internally stored as an unsigned int.
> >>
> >>struct pwm_device {
> >>     const char *label;
> >>     unsigned long flags;
> >>     unsigned int hwpwm;
> >>     unsigned int pwm;
> >>     struct pwm_chip *chip;
> >>     void *chip_data;
> >>
> >>     unsigned int period;
> >>     unsigned int duty_cycle;
> >>     enum pwm_polarity polarity;
> >>};
> >>
> >>However, pwm_config takes signed ints
> >>int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns);
> >>
> >>So digging a little deeper in the PWM core, I see that pwm_config dissa=
llows
> >>negative ints, so having them unsigned has no benefit (and technically =
is
> >>illegal)
> >>     if (!pwm  || duty_ns < 0|| period_ns=3D 0 || duty_ns > period_ns)
> >>         return -EINVAL;
> >>
> >>and because (after the check) we cram the signed int into an unsigned o=
ne:
> >>
> >>     pwm->duty_cycle =3D duty_ns;
> >>     pwm->period =3D period_ns;
> >>
> >>This could end up badly when using any unsigned int larger then INT_MAX=
 and
> >>thus ending up with a negative duty/period.
> >I don't think this is problematic because we're rejecting negative input
> >values and store the non-negative ones in an unsigned int, so we can
> >never store anything that would overflow the internal representation.
> >
> >>I haven't checked deeper if this
> >>is accounted for later, but would it be worth my time to convert all in=
ts to
> >>unsigned ints? Since negative period and duty cycles are really not pos=
sible
> >>anyway?
> >The reason for storing them as unsigned internally is precisely because
> >they can never be negative. The reason why pwm_config() has plain ints
> >is historic. It's always been on my TODO list to convert them over to a
> >unsigned variant, but never high priority enough. It's also problematic
> >because doing so needs to modify a public API and hence requires
> >auditing all consumers and providers to make sure nothing breaks.
> >
> >I'm not sure if it's worth spending this effort now. Boris Brezillon
> >posted patches a few weeks ago to introduce an "atomic" API and that's
> >going to require updating all users anyway. The new API also uses the
> >correct types, so any effort should probably go into testing and
> >migrating to the new API.
> Thanks for saving me from doing  alot of work herin ;)
>=20
> Are Boris his patches merged in some dev tree of yours? I'm working on so=
me
> pwm stuff too and would love to work 'with'.

I'm hoping to get around to applying Boris' patches to my for-next
branch this week.

Thierry

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEkpJAAoJEN0jrNd/PrOh3CcP/RimOSWXGyY1KopDNqKu/FAq
0BQgfdYX/PyGDBw/qoyAA/F8528tRNjg+ueUGixoCrE6jO6PIe5yMjWZKQ4Kp5U3
UgSvAKj8oYcblSCRUBDkaVGFrIR+2RyupVEHN4AVtPNOcgK2wPuUrKKp8o3hxXeA
FwOVCzw/3etbawcugeeEriCu6O9X+Lx0nAixWBhZnULiBEQqEKef5iOkZnas3DRZ
xG9wZZKKwNA4Q8iO/ekBuO8tGAonFbJoqT9fvm1wgnB3Myil7rrjRuK/DOSnyQfh
TmkvAn3TxxpFe1VpjGjWu6fLexSmXTGofbXNjrHfmc4ebXjWm65MqgmCU2GM+yit
0VbIIsl17LT+/JkopAPwJ9/RAhrYphXmsbP8aG/04cP0jaFT2Vc112BZ4c+VlcT0
KomEocnv2Ea9ntZ6+RSkQhG93EHYsyq8ErK3juYsOKnx0WSmcUOg8iHI9+X+r7dS
FmWOtP2Ix4nSs+PEPDWvbjSX8ikE7naJNm+Lagylu3xslrMTaRr2sIUNc0szP+An
s7SAFaJ9ZPsHT8G8K88EuQA3wAUMnJTtqKbTfybQSFv+6CGmr9V6rIM4BnEtNFNu
cM+FSldjEETHY4V8w9Cz39AcsYNAbySeC2NBOBPNSEw2FABf5u1iT0R6zx7g6soc
rqRsd/Hw5Q7V1Hi3Awyp
=9laa
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
