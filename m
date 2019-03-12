Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38623 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLLru (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Mar 2019 07:47:50 -0400
Date: Tue, 12 Mar 2019 12:47:46 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190312114746.GK31026@ulmo>
References: <1552360594-21547-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190312092302.2x6zf4imlfsevmkr@pengutronix.de>
 <CAMuHMdUYqk6nFAd2TQ_xM9q3bHskpd8vZXJ8DiF3tFwJQLc=tg@mail.gmail.com>
 <20190312095433.fl2nbbj3jsqxhcny@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <20190312095433.fl2nbbj3jsqxhcny@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: Avoid deadlock warning when removing PWM device
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Phong Hoang <phong.hoang.wz@renesas.com>


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 10:54:33AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Mar 12, 2019 at 10:49:59AM +0100, Geert Uytterhoeven wrote:
> > Hi Uwe,
> >=20
> > On Tue, Mar 12, 2019 at 10:23 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Mar 12, 2019 at 12:16:34PM +0900, Yoshihiro Shimoda wrote:
> > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > index 1581f6a..2fdd6611 100644
> > > > --- a/drivers/pwm/core.c
> > > > +++ b/drivers/pwm/core.c
> >=20
> > > > @@ -368,10 +370,12 @@ int pwmchip_remove(struct pwm_chip *chip)
> > > >
> > > >       free_pwms(chip);
> > > >
> > > > -     pwmchip_sysfs_unexport(chip);
> > > > -
> > > >  out:
> > > >       mutex_unlock(&pwm_lock);
> > > > +
> > > > +     if (!ret)
> > > > +             pwmchip_sysfs_unexport(chip);
> > > > +
> > >
> > > I wonder if this needs to be done before free_pwms is called. Otherwi=
se
> > > the pwmchip is already gone and then something is requested via sysfs.
> >=20
> > The chip itself is not freed, only the pwms array inside, which is not =
needed
> > for matching in pwmchip_sysfs_unexport(), right?
>=20
> OK, then make this:
>=20
> I wonder if pwmchip_sysfs_unexport needs to be done before free_pwms is
> called. Otherwise the PWMs's representation is already gone and then
> something might be requested via sysfs.

Agreed, I think sysfs needs to disappear before the chip does, otherwise
we could have userspace racing with the kernel for access to sysfs while
the PWM chip is already/only halfway gone.

Thierry

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHnGIACgkQ3SOs138+
s6GwEw//dTycZkr5tDV0cVQE4Erh64qAw0R7YJ91zaH9IGscdwfsBe/18QNHq9+O
czS/iBTjj6wy58+4AOwbQYGfdcVBD6PlA6roDQSaqt45xCStCim1NP5D3TzlYlB9
WcIhjMJCI/cKFyzENm8ON2QrxnLdP4yrQ9AHFR6Qr/N2I6SMKYIfq95CvaYqGegj
HIfrJqMxBcj8Tk8uifqxoG9I5ddbjIeZtHCqjgybMhB4ownUHrP8AofQseWL0T3c
uQfEfVnsG5nK+mIbQx2g8IB3pKTwwKdU+2CplKGXaeLBucFGYI0dHk/dRBLSsZLm
OdryDzIyHRvmDnI7PMxSAnyrgXgTDOV+HbrM4M9iFZN3TlzgmnM3OAFb85Kvn5dE
Cv1Ac30I1pyN/fNbyZn9218OmlwFLNswlXGYVFFrmyu8AbcAMruF2zwzbCL102cv
40hIIKd4HNWyMOGYX64BjykGwm71GKsVgna9H/KHq0C61L8OpaFiYEu+AYqUzL1z
4mfLUAq+Yco/fdwa4hnPgQOKMH8ecEjsjbhr2NFP4hD2hxIFFjur48dFzCyQc1Fs
gH7NQj+M6x3vIBGVNF9K+SGPmvvHcyJ3p1AdiNlUv53YCBOe+l27yWkcb2kQoNdO
wbnpogdQIkXBXuNveuMuC5z7AbB8evM542ZsDVwEHiREJGv+fQw=
=IR3j
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
