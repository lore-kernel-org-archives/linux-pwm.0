From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: improve args checking in pwm_apply_state()
Date: Thu, 23 Jun 2016 18:55:08 +0200
Message-ID: <20160623165508.GA20051@ulmo.ba.sec>
References: <1464367549-111530-1-git-send-email-briannorris@chromium.org>
 <CAMuHMdUVgwb8QwKcORDuoJUCJJKE7Xmzg3R45S1VdnupAXUx0w@mail.gmail.com>
 <20160621183730.GA130978@google.com>
 <20160622100422.5c34f975@bbrezillon>
 <20160622191658.GA106497@google.com>
 <20160622224114.697c0db5@bbrezillon>
 <20160622204647.GA14996@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34353 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcFWQzS (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jun 2016 12:55:18 -0400
Content-Disposition: inline
In-Reply-To: <20160622204647.GA14996@google.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 01:46:48PM -0700, Brian Norris wrote:
> On Wed, Jun 22, 2016 at 10:41:14PM +0200, Boris Brezillon wrote:
> > On Wed, 22 Jun 2016 12:16:59 -0700
> > Brian Norris <briannorris@chromium.org> wrote:
> > > Notably, you're dropping the 'if (!pwm) { }' safety checks that are p=
art
> > > of pwm_disable() and pwm_set_polarity(). But I don't think there shou=
ld
> > > be any users relying on that.
> >=20
> > Indeed. I can add it back here if you prefer,
>=20
> Nah, that's ok. I just had to say it anyway :)
>=20
> > but honestly, PWM users
> > that are not checking the value returned by pwm_get() should be
> > considered buggy IMHO, and a NULL pointer exception is a good way to
> > make people realize they are not properly using the API :).
>=20
> Seems OK.

I've applied this to my fixes branch, and I'll let it cook in linux-next
for a little while, then send it off to Linus for v4.7-rc6 next week if
no further fallout is caused by this.

Thierry

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXbBRpAAoJEN0jrNd/PrOhTtUQAMLbPd6hFChYXMj/K+zZDKW7
nPk0VV11CmHyffdpcyh38Sfa0woJeye4QqaCEewDffsGgLxBUUqRFaTj43JnMOJe
uJnjAE726KBxV6JVI7GsCuvdWaewY9vCd9VSKX5plqpmSuQbIZ3PjCC/Y604f2uc
fTskP/Mp+aPF14BExwg7ntMhp6C7/7LxmSBjJBOJp3RY9gnbD7IOdMI1EMiUpVIf
3BVlljDyPuhsN8h4jNa3Tjh3ZqGm8lfcSgaB3aEttGNWVF5u8kmaqgozXZfPOng2
4s/yrlJDMT+zeRPyTjFLi/IeK23ZFTmzJ+lhhzISewPAsnA5QQIaAO+xr/GuTckc
IkoAhv5e2UppE80e9DHSE5PWXoMdVd02NIoTnb+0Qi4jpshsCId0+hQqrVbHDhj8
6nkUTm9080jlclsD17CZ3njlD3h6Z0/bWpRM6VBDLEoCV21now2IoFAwQIxeLSGM
fZv1I6y2tKP96cVe/i3/4hf2zrWIuLyzOa+zgmneZXwg5nj2qzjeJsgibC0O/fqc
gZ6sP898601rcGvpelia74YBYuQ8U7j5fMvYyMH+4P65U3hLsKflbbhPhgyDScus
ar7OxjOQOQzlWB4xMcee1wT3mWLj9bP+fwXqsZnG7IJeeifBWQf9jzMKXL9hq2Z9
zGn/Z+20elUEVU8dnhZ6
=lPWi
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
