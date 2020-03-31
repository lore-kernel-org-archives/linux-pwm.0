From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v11 06/12] pwm: imx27: Use 64-bit division macro and
 function
Date: Tue, 31 Mar 2020 22:49:29 +0200
Message-ID: <20200331204929.GC2954599@ulmo>
References: <cover.1584667964.git.gurus@codeaurora.org>
 <5aae102e21c0e63ad2588ae1e174b48b06d25e96.1584667964.git.gurus@codeaurora.org>
 <CAK8P3a0qUMMMDmbp2FM-7D-U0Ys_zv0paYguFeyifafZurndEw@mail.gmail.com>
 <20200330204359.GB5107@codeaurora.org>
 <CAK8P3a1VC6+0Tydm=BoK2NvHB1ZCPjE1Gfi-sTE5O-xnu3Ya3A@mail.gmail.com>
 <20200331202058.GB25781@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37638 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUtj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 16:49:39 -0400
Content-Disposition: inline
In-Reply-To: <20200331202058.GB25781@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux PWM List <linux-pwm@vger.kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 01:20:58PM -0700, Guru Das Srinagesh wrote:
> On Tue, Mar 31, 2020 at 05:24:52PM +0200, Arnd Bergmann wrote:
> > On Mon, Mar 30, 2020 at 10:44 PM Guru Das Srinagesh
> > <gurus@codeaurora.org> wrote:
> > >
> > > On Fri, Mar 20, 2020 at 06:09:39PM +0100, Arnd Bergmann wrote:
> > > > On Fri, Mar 20, 2020 at 2:42 AM Guru Das Srinagesh <gurus@codeauror=
a.org> wrote:
> > > >
> > > > > @@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> > > > >
> > > > >         period_cycles /=3D prescale;
> > > > >         c =3D (unsigned long long)period_cycles * state->duty_cyc=
le;
> > > > > -       do_div(c, state->period);
> > > > > -       duty_cycles =3D c;
> > > > > +       duty_cycles =3D div64_u64(c, state->period);
> > > > >
> > > >
> > > > This change looks fine, but I wonder if the code directly above it
> > > >
> > > >         c =3D clk_get_rate(imx->clk_per);
> > > >         c *=3D state->period;
> > > >         do_div(c, 1000000000);
> > > >         period_cycles =3D c;
> > > >
> > > > might run into an overflow when both the clock rate and the period
> > > > are large numbers.
> > >
> > > Hmm. Seems to me like addressing this would be outside the scope of t=
his
> > > patch series.
> >=20
> > I think it should be part of the same series, addressing bugs that
> > were introduced
> > by the change to 64-bit period. If it's not getting fixed along with
> > the other regressions,
> > I fear nobody is going to go back and fix it later.
>=20
> Makes sense, I agree. Would this be an acceptable fix?
>=20
> Instead of multiplying c and state->period first and then dividing by
> 10^9, first divide state->period by 10^9 and then multiply the quotient
> of that division with c and assign it to period_cycles. Like so:
>=20
> 	c =3D clk_get_rate(imx->clk_per);
> 	c *=3D div_u64(state->period, 1000000000);
> 	period_cycles =3D c;
>=20
> This should take care of overflow not happening because state->period is
> converted from nanoseconds to seconds early on and so becomes a small
> number.

Doesn't that mean that anything below a 1 second period will be clamped
to just 0?

Thierry

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6DrNkACgkQ3SOs138+
s6F2rRAArLSEhXAhgvFqFz7p1Jyl3a2QkW2gk0K5vu5cqJQzOMB/CGTnJlkpte4r
OPEsS/IrnNJjMNvLMLZQ/92OqmWdK1ve0y8aFlhLAhGn5KdelcOcnf8Id/rxV2YJ
BV7oMSVS9dZa5+gNJaFARNkYs+5dWAFQoKKvSxpaTMBMMMzN9TgoKZKa0W7xZQmh
CbJve7ZWx/MsubZTneoudgf3Vi+SYak6kFEHhw/rqE9lFWb5pfKXwyVxpPHqW0uk
ooJ1g5VkQxKPnaUtz3N2EK4+K4gUlh87myfPiH0k35FCJ9N+ENOIe9vtepJ33+u9
UFD/GJUtPimSBDHKAcZyc0Gtvw4Cka4dmDeAgIMe+QviRjEd/pvI4MS+s8KCAYKk
kn4AG2KDeC0w5bufJQnlXuziYw95gUYQ2nrRPFgI0yJMtdwvd+Pch5skoklz6GSZ
2Q7Ao5wGRoRpV/cXb28lBNOgD4w0R1upufK/7I4lSwTRMBWXzBK57ItEXfeTO7V7
2HEiAXYXt6oqM27RxedshqKGe9d5gwvdGLIy6NjfnQkJ4QySu13nLTas4yPlz3Lx
ZTv+Cl8EElQnC7n2erxOjTcCPQaM14MslHRFhk+wtacQ3+Escb2lPndAzD8lQinS
ncFajYcMWrIYy3l0rK0o6juMpEqV2vxl7Y8x04xvV/vr88q9OKY=
=Ht11
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
