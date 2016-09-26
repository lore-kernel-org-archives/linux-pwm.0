From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse
 before disable
Date: Mon, 26 Sep 2016 10:46:25 +0200
Message-ID: <1474879585.6096.33.camel@schinagl.nl>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
         <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
         <20160826221900.GG3165@lukather> <1473145976.731.20.camel@schinagl.nl>
         <20160906195149.GJ9040@lukather> <1473411668.731.75.camel@schinagl.nl>
         <20160924202502.GF16901@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LbZB3/FIZTCVtYeAO9mm"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160924202502.GF16901@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--=-LbZB3/FIZTCVtYeAO9mm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On za, 2016-09-24 at 22:25 +0200, Maxime Ripard wrote:
> Hi Oliver,
>=20
> Sorry for the slow answer.
>=20
> On Fri, Sep 09, 2016 at 11:01:08AM +0200, Olliver Schinagl wrote:
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > *chip, struct pwm_device *pwm)
> > > > > > =C2=A0	spin_lock(&sun4i_pwm->ctrl_lock);
> > > > > > =C2=A0	val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > > > > =C2=A0	val &=3D ~BIT_CH(PWM_EN, pwm->hwpwm);
> > > > > > +	sun4i_pwm_writel(sun4i_pwm, val, PWM_CTRL_REG);
> > > > > > +	spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > > > +
> > > > > > +	/* Allow for the PWM hardware to finish its last
> > > > > > toggle.
> > > > > > The pulse
> > > > > > +	=C2=A0* may have just started and thus we should wait a
> > > > > > full
> > > > > > period.
> > > > > > +	=C2=A0*/
> > > > > > +	ndelay(pwm_get_period(pwm));
> > > > >=20
> > > > > Can't that use the ready bit as well?
> > > > It depends whatever is cheaper. If we disable the pwm, we have
> > > > to
> > > > commit that request to hardware first. Then we have to read
> > > > back
> > > > the
> > > > has ready and in the strange situation it is not, wait for it
> > > > to
> > > > become
> > > > ready?
> > >=20
> > > If it works like you were suggesting, yes.
> > >=20
> > > >=20
> > > >=20
> > > > Also, that would mean we would loop in a spin lock, or keep
> > > > setting/clearing an additional spinlock to read the ready bit.
> > >=20
> > > You're using a spin_lock, so it's not that bad, but I was just
> > > suggesting replacing the ndelay.
> >=20
> > If you say the spin_lock + wait for the ready is just as expensive
> > as
> > the ndelay, or the ndelay is less preferred, then I gladly make the
> > change;
>=20
> For the spin_lock part, I was just comparing it to a
> spin_lock_irqsave, which is pretty expensive since it masks all the
> interrupts in the system, introducing latencies.
so spin_lock is very expensive and we should avoid if we can?
>=20
> >=20
> > but I think we need the ndelay for the else where we do not
> > have the ready flag (A10 or A13 iirc?)
>=20
> Hmmmm, good point. But that would also apply to your second patch
> then, wouldn't it?
yeah, you would have an if/else for the case of !hasready.

this is what i've been dabbling in the train last week, but haven't
thought it through yet, let alone tested it:


+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(sun4i_pwm->data->has_rdy))
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ndelay(pwm_get_period(pwm));
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0do {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock=
(&sun4i_pwm->ctrl_lock);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D s=
un4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlo=
ck(&sun4i_pwm->ctrl_lock);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0} while (!(val & PWM_RDY(pwm->hwpwm)))

Here I assumed the spin_lock is cheap to make, expensive to hold for
long, e.g. reducing the length the spin-lock is active for. the
alternative was to remove the spin_lock here, and remove unlock-lock
before-after this block where you basically get a very long lasting
spin_lock, the alternative.
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock(&sun4i_pwm->ctrl_=
lock);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D sun4i_pwm_readl(sun=
4i_pwm, PWM_CTRL_REG);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sun4i_pwm->data->has_rdy && =
(!(val & PWM_RDY(pwm->hwpwm))))
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_warn(chip->dev, "never became ready\n");

this may be useful for debugging i thought.

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val &=3D ~BIT_CH(PWM_CLK_GA=
TING, pwm->hwpwm);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sun4i_pwm_writel(sun4i_pwm,=
 val, PWM_CTRL_REG);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock(&sun4i_pwm->ctr=
l_lock);

Olliver
>=20
> Maxime
>=20
--=-LbZB3/FIZTCVtYeAO9mm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJX6OBhAAoJEChwBZsDyQQMoPgP/0Vg7ArNF0A/oCEZAbzqFdei
ezg7OD/GiCNwXMMrVYuGOmBWLbMgmytEmNI0i+Xj1FNvn+Z3BYrZTIwaSoKXJCG7
J+eOGYey5cotgKA/KbYUqxXYLx5tIzXq3DAhBSBnmNzmD4k9S1T+YZf4FLn2XKg8
e3+1J3r7lNTV+sV5QDkmFcCvglc+qdqS6XLhnBxp3DLkzbk49bzDr1kRwLQ3gH84
Bhx3t7oZZCVtc/XJiu3YneLIjSoCTqrdtdUHg1d2GF+G3FbqUnZPdmS3NOL8UsQw
ndZ+FGdzCsThmmoI317x2uX87PKJB51UeLNMjdqICUpcQh3/Ppdnu467e665mE9h
D9jMOUoBRWJoZyUxdxQ2OKIderZOCiWbEDcLNAAC0XKDMAWxgi+49aZNKJ+Pgiyg
7A0NoCbjjnH2Mbkk8fqdqqdF9EN2cJGmh5NDuCawcEWLlCNUBmXkdBYzcAE9FBYA
jrdoTptBKj88WG4jyBmWyTZqhMxQGnOnTShjhnsaGXW6z19ii8z4L7+irEyFMXCc
Qt39oWLaMmhuYjlGFGfyTmER29xOp15KwEfeEcxlH7toDbYRzUolN55eHkElZacD
wFEt2/io4ime4wHNWZ0sjf5aKstb96z8GOso9czT5t5BVj5d6kgbX/zVtjJ5sBs/
3T0Q+/FyOeUVUY3/ww4i
=47Jo
-----END PGP SIGNATURE-----

--=-LbZB3/FIZTCVtYeAO9mm--
