From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v9 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 18 Mar 2019 10:51:11 +0100
Message-ID: <20190318095111.GA17565@ulmo>
References: <1552378289-27245-1-git-send-email-yash.shah@sifive.com>
 <1552378289-27245-3-git-send-email-yash.shah@sifive.com>
 <20190312091739.fhv2hb2ll2eamdsn@pengutronix.de>
 <20190312121218.GM31026@ulmo>
 <20190312131712.rxiarnthcfrsgdqn@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190312131712.rxiarnthcfrsgdqn@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yash Shah <yash.shah@sifive.com>, palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 02:17:12PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Mar 12, 2019 at 01:12:18PM +0100, Thierry Reding wrote:
> > On Tue, Mar 12, 2019 at 10:17:39AM +0100, Uwe Kleine-K=C3=B6nig wrote:
[...]
> > > There are a few other things that could be improved, but I think they
> > > could be addressed later. For some of these I don't even know what to
> > > suggest, for some Thierry might not agree it is worth fixing:
> > >=20
> > >  - rounding
> > >    how to round? When should a request declined, when is rounding ok?
> > >    There is still "if (state->period !=3D pwm->approx_period) return =
-EBUSY"
> > >    in this driver. This is better than before, but if state-period =
=3D=3D
> > >    pwm->approx_period + 1 the result (if accepted) might be the same =
as
> > >    without the +1 and so returning -EBUSY for one case and accepting =
the
> > >    other is strange.
> >=20
> > Perhaps a good idea would be to reject a configuration only after we've
> > determined that it is incompatible? If we're really going to end up with
> > the same configuration within a given margin of period or duty cycle and
> > we can't do much about it, there's little point in rejecting such
> > configurations.
>=20
> It seems we agree here. Is this important enough to delay taking this
> driver further? Currently the driver rejects too broad so if it annoys
> someone this can still be fixed later and there is only little harm
> (assuming correct error handling in the consumers).

I don't think it has to be a blocker. As you said, we'd be giving users
more flexibility, not restricting them, so it should be fine to do later
on.

> > >  - don't call PWM API functions designed for consumers (here: pwm_get=
_state)
> >=20
> > Agreed. The driver can just access pwm_device.state directly.
>=20
> I wouldn't do this either. IMHO the driver should only look into its
> hardware registers instead of using framework interna (or consumer API
> calls).

The current hardware state is already the software representation of
what the hardware has programmed. I think it's fair for drivers to make
use of that in order to avoid having to read back from hardware.
Especially if reading back from hardware might require switching on the
module to access registers.

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPagwACgkQ3SOs138+
s6H2nxAArlQ9omVBBACn60oV5Ix/6fZlOeffFJBYaCFea3XjU38SSI1hS3QM75JQ
B55cEC2AKQy4vQykZmTBPGWhit09tKv2MXwLMwKRxEXktC/wxNc1MTh7h9MeiH9M
LJ5iL7wwGjyHlzTTVA5r+lgU2Avg8LdXeex7hgo5rYrDEPu9sDglU7eO7YUKhHX1
QsTeKgLoFE1Ne38PbMBKA3nA9llcm6rdrhLLzss6Q9+wQQSYuPYToSH/pHWqo3BL
86JqYuja7EQf26BJMiA5aOdyq56IdMtD286XDV0+VGEiih9WQZbKuhUKMIHSLH9C
YgN3oPonjvVI6xq1aEHvp1n6sma2vbFKX+nvOeOGmCizRAY/gx/UzC3M44y9JQWO
o0jKCgtnJr+kYn8GFDqgQBNwhwN9GtQ7Bjv+lXqPIdnCUjxgtzLW1VxsXccz5w9+
o1SmJOAmBIfV/bnwhZpMiSoSCl3pnm+ohjBh3Qom2nIJxgmkV5xesPB06phijNZS
ZEzh2hUcpvAr5+tH+WxRysRp7Ee6w0KVzsyrAsezgxth5f78Pw9XRJyPnQy415Pz
4IlmHDoinYvDcOn0ZL6odF8rirlBqZ7lmOK2av0LRix0XVV02Y8FTZ2LPepHOZSV
wXcHzBhpezIG65ICYL6SFBDfiIDLzWuaDr9WIRJn0RYu1LxpdGs=
=X4jv
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
