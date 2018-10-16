From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
Date: Tue, 16 Oct 2018 13:13:24 +0200
Message-ID: <20181016111324.GD8852@ulmo>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo>
 <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <CAMgXwTieXNa13_xGp2mkw99+VJm-R1xrxMHSmRLZV-hG5oSdzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMgXwTieXNa13_xGp2mkw99+VJm-R1xrxMHSmRLZV-hG5oSdzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wesley Terpstra <wesley@sifive.com>
Cc: Atish Patra <atish.patra@wdc.com>, Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-pwm@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 04:19:20PM -0700, Wesley Terpstra wrote:
> On Mon, Oct 15, 2018 at 3:57 PM Atish Patra <atish.patra@wdc.com> wrote:
> > >> +SiFive PWM controller
> > >> +
> > >> +Unlike most other PWM controllers, the SiFive PWM controller curren=
tly only
> > >> +supports one period for all channels in the PWM. This is set global=
ly in DTS.
> > >> +The period also has significant restrictions on the values it can a=
chieve,
> > >> +which the driver rounds to the nearest achievable frequency.
> > >
> > > What restrictions are these? If "nearest achievable" is too far off t=
he
> > > target period it might be preferable to error out.
> > >
> >
> > @Wes: Any comments?
>=20
> When I last looked at this driver and hardware, I briefly considered
> throwing up my hands and pretending that this PWM device had no period
> control at all, only duty-cycle. There are several examples of PWM
> controllers in linux already that behave that way.

Can you point those out? So far we've always opted to refuse changing
the period of PWM channels that share a period if it didn't match the
current period.

> Most of the uses of this PWM are only going to care about the
> duty-cycle, not the period. So failing when the period is unachievable
> seems worse to me than just completely eliminating access to period
> control.

I'm not sure we've ever tried to completely take period out of the
picture. You could probably do it if you use only the atomic API because
then you just leave the period untouched. And if you have a post-clock
change you just need to make sure to record the new period and update
the duty cycle so that the ratio remains the same.

I think that could work, but I think it'd be best to be explicit about
it, rather than just handwaving it.

Thierry

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvFx9IACgkQ3SOs138+
s6EG5Q//VozF9Lk+dGPqd7hls3pRBj6SyqljD13wEXsC+zLveuBBDKtOFvJ53yYj
A5PxNzKHGdfFcEm+WWNthJezglWFUBwoeiJVmOkuhHSTAwSXr+bhKjPRzPyRssNe
Av0PZyxQ9yB9XsmZSZrixTtGT6XpAW3MB/9ha3G/PkL6lEM7mI1rCoA1riiZsnpq
gX5v1d8+lizsAJMYIDduyAbyB3+zvpRwtrQSEuM+p5pwpQBZhZiEI18fXOazDGmF
p0FCHWwRTXXlVN2gOk84+Q8/mXRFA35NqbhTJ6yrqavZLd2k7nhwVr69N1bw2DQC
PzdzYM/JD4CowrfzpAnNG6ysqvkzh44zQB0uHhF8dDNQC+JqAYReUNH8/JjbHqd/
cuI21LU5l0mBgMyza9Eal+WwXXMe/tppz9CcHddMEke3RUXDo+MRHDNtphid/sOf
TznJLIAbOiOGsoUfyoHycbEh0xmMiNoqnayt7sUvdzoKSxi+HIwsvVbsPMvlqapM
qGq0t3q/gK19MiEG5yUEhNf3WzhJCGMdJKcnlAzX8chKA2nrmIGvBIr29TUnPo8X
cMmOUncqNkQ3oj9ypACk+9ACXNAAQoupww+fLQZ/0V6lm4BM7JjLRCpsxPqKjYhK
nbW9AskHYjXg5kVVMj7/GwwdXNXV9Q/iWCxax2JxY8bsuXuxnMk=
=DuQI
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
