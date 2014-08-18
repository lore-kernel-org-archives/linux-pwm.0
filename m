From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
Date: Mon, 18 Aug 2014 10:49:12 +0200
Message-ID: <20140818084911.GD31171@ulmo>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
 <20140818083134.GB31171@ulmo>
 <d8843f498fa64ea9b45fc04e9bb5589d@BY2PR0301MB0613.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d8843f498fa64ea9b45fc04e9bb5589d@BY2PR0301MB0613.namprd03.prod.outlook.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2014 at 08:43:56AM +0000, Li.Xiubo@freescale.com wrote:
> > -----Original Message-----
> > From: Thierry Reding [mailto:thierry.reding@gmail.com]
> > Sent: Monday, August 18, 2014 4:32 PM
> > To: Xiubo Li-B47053
> > Cc: linux-pwm@vger.kernel.org; robh+dt@kernel.org; pawel.moll@arm.com;
> > rdunlap@infradead.org; devicetree@vger.kernel.org; linux-doc@vger.kerne=
l.org
> > Subject: Re: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
> >=20
> > On Mon, Aug 18, 2014 at 11:32:32AM +0800, Xiubo Li wrote:
> > >
> > > This is depended on the following patches, which has been applied by
> > > Mark into his Regmap-Tree:
> > > https://lkml.org/lkml/2014/7/15/6
> > > https://lkml.org/lkml/2014/7/15/5
> > > https://lkml.org/lkml/2014/7/15/7
> >=20
> > This doesn't seem to have any build dependencies on the above patches.
>=20
> Yes, you are right.
>=20
>=20
> > So with only this applied to the PWM tree at worst the registers will be
> > accessed in the wrong endianess and the PWM won't work as expected. Does
> > that matter?=20
>=20
> No, I think it's okay, we'll only test our drivers in the Linus's stable =
branch.
>=20
>=20
>=20
> > Or should I request a stable branch from Mark to pull into
> > the PWM tree so that this doesn't happen?
> >=20
> > In linux-next things should be fine since both branches will be merged.
> > I guess there could still be an issue depending on the order in which
> > Linus merges the trees for 3.18, in which case there could be a brief
> > period where Linus' tree runtime-breaks on platforms requiring this. But
> > I'm not sure if that's really an issue.
> >=20
>=20
> The depended patches has been merged into the Linux-next tree just now al=
ready
> today.
>=20
> And then could we guarantee that these ftm-pwm patches to be in order aft=
er the
> depended ones ?

I could merge Mark's regmap tree into the PWM tree to guarantee that.
I'm just wondering if it's worth the trouble since there's no compile-
time dependency so the issue will only show up when running a kernel
built directly from the PWM tree (or some tree that has the PWM tree
merged but not regmap). And even then it will only happen if there's a
device tree for a device that requires special endianess handling.

But it's really your call. If you think it's safer to merge them in the
correct order then I'll ask Mark for a stable regmap branch that I can
pull.

Thierry

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8b4HAAoJEN0jrNd/PrOh0RQP/3gYYKZQgcoYvnQTjHW9459n
VgI+GdThJFB1pTf8VMGMIhtXmX/GjXcOOSGYHI3vvnJlOSQ9utWCDC7t5RONDjoP
hOjQJa771WH44d1xEi+oN1GYBudU5iM8ZLKgHQVcK3DXE/Z4e9wVNwtPRqzBWhbO
7RK9pp6+Ex5HJfqKlv0qMgvaJ4zn1gWFz06Yyk3JIk68yCPUjgZ54IlVaTSpW4iy
3XMFax4LyV72SrB1PiG21lAxwb/Neg3BSFMbPuXtVLLId/RnYsMcv/EeGZzGyRkb
iqb1UlUmZ9ET4hNHjmGV1eZ1XD9ZkHFgk1C4nGc9eijiv3Z9oarI+c+9MaS1rqC4
OribCgmU+/NRjH2F/lPqGqnKjZ0Dz/ZyahlDNe8BRe4HhtzOlwfIs8W2gVM7jXGy
KSpWHNv1OdjG/AarXb/zhb6lSnsYsjn9s8bDJ/NNrBuCzhBfuu5/wPJin1SuE/LN
dOspY3V4HnF3uIzaU3an7sw5i1hKlN+voWcDsF5EFeZ6nodJWnfAJoYwJAiunZuC
vCO8TiKyJTSxzrJo9UCtMhwxGo8T3zswFa8EXns1VJSao2OwDGR05RGyUVlCYDxi
JoKBq2w9GQVmJuVjpK7jjSHvoWaHHMU+fzmnX2tHFRl/IMQJlqaE6io8YdIuHXG9
AKPk56f/oTPFMOq0tUEr
=60Cy
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
