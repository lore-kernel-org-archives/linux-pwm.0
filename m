From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Sat, 24 Sep 2016 22:25:02 +0200
Message-ID: <20160924202502.GF16901@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <1473145976.731.20.camel@schinagl.nl>
 <20160906195149.GJ9040@lukather>
 <1473411668.731.75.camel@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473411668.731.75.camel@schinagl.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

Sorry for the slow answer.

On Fri, Sep 09, 2016 at 11:01:08AM +0200, Olliver Schinagl wrote:
> > > > > *chip, struct pwm_device *pwm)
> > > > > =A0	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > > =A0	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > > =A0	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > > +
> > > > > +	/* Allow for the PWM hardware to finish its last
> > > > > toggle.
> > > > > The pulse
> > > > > +	=A0* may have just started and thus we should wait a
> > > > > full
> > > > > period.
> > > > > +	=A0*/
> > > > > +	ndelay(pwm_get_period(pwm));
> > > >=20
> > > > Can't that use the ready bit as well?
> > > It depends whatever is cheaper. If we disable the pwm, we have to
> > > commit that request to hardware first. Then we have to read back
> > > the
> > > has ready and in the strange situation it is not, wait for it to
> > > become
> > > ready?
> >=20
> > If it works like you were suggesting, yes.
> >=20
> > >=20
> > > Also, that would mean we would loop in a spin lock, or keep
> > > setting/clearing an additional spinlock to read the ready bit.
> >=20
> > You're using a spin_lock, so it's not that bad, but I was just
> > suggesting replacing the ndelay.
>
> If you say the spin_lock + wait for the ready is just as expensive as
> the ndelay, or the ndelay is less preferred, then I gladly make the
> change;

For the spin_lock part, I was just comparing it to a
spin_lock_irqsave, which is pretty expensive since it masks all the
interrupts in the system, introducing latencies.

> but I think we need the ndelay for the else where we do not
> have the ready flag (A10 or A13 iirc?)

Hmmmm, good point. But that would also apply to your second patch
then, wouldn't it?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5uEeAAoJEBx+YmzsjxAgJYsP/1iNdzFALMXDryMvt0+KTJJ2
MJ4ZJDG/GdwhwFroSzcGyygm4dKKc23Ha0OX98FlJRS8qoBEQpA9CTQPpUkWH8wp
+MNXy+Hgdqdla2PWHqRXSgiaSsetCbdlzmw1MJz+itlz5516D4kQ00pWC2VSm1BS
Dyj/a892iHoqyIxIRBLalyfFQzU2o+D0qjQ2d5K/idITKAmCX8CMr9pow1CfuCZh
QLoGGKwFNzKcyCh/OtpdlCLVX9XCY5Ft4Wepxxs9lUAFYNxpMdjTz85mXcWZ5pJm
dzE4yuoGpflO6l1/C9ehMO/2DlewmnUUdlWqZacJUNNPepNwJjOh4Fa5z3+KaDQn
KtH63zqWXbaKNUVNFH8hTN4XtG0W/NGA5gJ2D29JgdipH4iEsO6hgJy6s5vXLl96
h4wiLMDT5e0IGbu6T8f4OaHRIQ65cWHK/CkasiZzIVtJYNj2SRYdRRgJyuON0XwD
8pBBgSzk3ayqUrBm3c1UOjBE5TIdNFzRPrLpN8DoN9zltLwzNhE95n2Ap6/s6/Sp
5lJwM1kZo1AY6bdJqT2UlaTqapvjpDzC+ohChoFBxY6LsYp5eCEcnUmQhG4mBH7h
D74uRJqSMk91UzilEz6Vm4SGST/pCSgbjCHLpVL9B0B0gyVoEfc+ZwZyLhWXNgHO
ttGgcwBFTnBKGc7IGdL6
=ff/R
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
