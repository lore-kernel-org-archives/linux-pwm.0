From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] pwm: sunxi: allow the pwm to finish its pulse before
 disable
Date: Tue, 27 Sep 2016 22:16:28 +0200
Message-ID: <20160927201628.GB9084@lukather>
References: <1472147411-30424-1-git-send-email-oliver@schinagl.nl>
 <1472147411-30424-2-git-send-email-oliver@schinagl.nl>
 <20160826221900.GG3165@lukather>
 <1473145976.731.20.camel@schinagl.nl>
 <20160906195149.GJ9040@lukather>
 <1473411668.731.75.camel@schinagl.nl>
 <20160924202502.GF16901@lukather>
 <1474879585.6096.33.camel@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42424 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932573AbcI0UQb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Sep 2016 16:16:31 -0400
Content-Disposition: inline
In-Reply-To: <1474879585.6096.33.camel@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 26, 2016 at 10:46:25AM +0200, Olliver Schinagl wrote:
> > For the spin_lock part, I was just comparing it to a
> > spin_lock_irqsave, which is pretty expensive since it masks all the
> > interrupts in the system, introducing latencies.
>
> so spin_lock is very expensive and we should avoid if we can?

spin_lock_irqsave, if possible, yes.

> > > but I think we need the ndelay for the else where we do not
> > > have the ready flag (A10 or A13 iirc?)
> >=20
> > Hmmmm, good point. But that would also apply to your second patch
> > then, wouldn't it?
> yeah, you would have an if/else for the case of !hasready.
>=20
> this is what i've been dabbling in the train last week, but haven't
> thought it through yet, let alone tested it:
>=20
>=20
> +=A0=A0=A0=A0=A0=A0=A0if (!(sun4i_pwm->data->has_rdy))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ndelay(pwm_get_period(pwm));
> +=A0=A0=A0=A0=A0=A0=A0else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0do {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi=
n_lock(&sun4i_pwm->ctrl_lock);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0val=
 =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0spi=
n_unlock(&sun4i_pwm->ctrl_lock);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} while (!(val & PWM_RDY(pw=
m->hwpwm)))
>=20
> Here I assumed the spin_lock is cheap to make, expensive to hold for
> long, e.g. reducing the length the spin-lock is active for. the
> alternative was to remove the spin_lock here, and remove unlock-lock
> before-after this block where you basically get a very long lasting
> spin_lock, the alternative.

If you're only reading, why do you need to take the lock?

You probbaly want to have a timeout too.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX6tOcAAoJEBx+YmzsjxAg+0IP/31GX3LiF4mrYkdrg3g6ZcYN
OUHFEXXQXxWErXwJYfq2Q/RwwBEk4f6IgH4dKar73ULjvZTua6dx65s1fNG+CVkU
wbAc4SXv/OrB6meLf0rI1ylWJCADJgNEyzCJuDsPZNx76GcdL3v5jtEOJXpg3/+f
CpJirvKanf5wAxw0W8xTnvNsYrHosMquP585idKYZhArxB8O0L9GLbWWP/qE1mzQ
fhxY7S+um1F+pp1I6+35J2tFE58W5QxmFsW7O+q4wu1dVD3d4wZqMXy5lY1RKmeZ
bItAmwyt9gLvPTzXrGseRtiKMvYsxWYHzI8srJWdeRinwtL+MTxZJ3pFPLu9QDnR
rchP80+kGDFFsDotq3Yui+RfxLhHztFk7WNTNRewoECnnYYjDt/Xwpie+R4TBIIa
ctx8/jQ8trH+bJvGOGHbAphptszEv5j8et/3aAYLDcjKAtGWQhCVdCNL2sWI0mvp
kYk/SPHKFrZ7W/sRX7Jpnid5tScaAKjt97owwmxhhqhtXabAN944WJT3Y51+gCrm
5b6wBsAuIwnSK9YL70LSfuz6PDLjghrc98DZBsgejPnbpCzylNVUXOg41+arCx3D
hxsyLN3NTCD3X3jX/gb5ryoOEw35CBzsrwRzLOmPS1u/j1QCuikam+5dMf0DRhLy
FSA8yJd6DdowZOlLBmFQ
=AiHG
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
