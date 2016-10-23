From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v3 3/6] pwm: imx: support output polarity inversion
Date: Sun, 23 Oct 2016 08:40:27 +0200
Message-ID: <20161023084027.4a2aae51@jawa>
References: <20161007151129.6043-1-bhuvanchandra.dv@toradex.com>
        <20161007151129.6043-4-bhuvanchandra.dv@toradex.com>
        <5325a332099473a2d8382530f79c5a8e@agner.ch>
        <20161013001540.7f759158@jawa>
        <ff9ba34df2729204c617685dd26ea625@agner.ch>
        <20161013065812.0da91859@jawa>
        <20161020103018.44fb94ea@jawa>
        <1b72dcbc9a021e6fa3aef62f63bbf93f@agner.ch>
        <20161021234939.1a4f51f4@jawa>
        <20161022140118.7a6cb583@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/.PA.JCrjz1wDcU3oPwkxBc1"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161022140118.7a6cb583@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Stefan Agner <stefan@agner.ch>, thierry.reding@gmail.com, mark.rutland@arm.com, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, Lothar Wassmann <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

--Sig_/.PA.JCrjz1wDcU3oPwkxBc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Boris,

> >=20
> > Could you be more specific here?=20
> >=20
> > As I mentioned before, the problem is not with the lack of
> > "atomic" API. =20
>=20
> Below is a quick and dirty I made on top of this patch to show you how
> atomic update can be implemented in this driver.=20

Thank you for example patch.

I will implement the ->apply() callback and post patches very soon :-).

I had two issues with the ->apply() implementation:

- Do my work on top of this patch (https://lkml.org/lkml/2016/10/7/454
  as you did) to avoid rewriting work already done.

- In the example ->apply() implementation for rockchip
  (https://patchwork.kernel.org/patch/7228221/) the ->config() callback
  was not removed when ->apply() was implemented. I was confused with
  such approach, but as you explained in this mail, the solely ->apply()
  is enough.

> It's not tested, and
> probably not working, but it should give you a better idea of what is
> expected.

Thanks for explanation,

=C5=81ukasz Majewski

--Sig_/.PA.JCrjz1wDcU3oPwkxBc1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlgMW2UACgkQf9/hG2YwgjGVUwCgzsr1ctqb82DSgB/xupxIYyHO
dv0An3Z83e9o+R6Ef9WPZTyImBVCr6vO
=3N8k
-----END PGP SIGNATURE-----

--Sig_/.PA.JCrjz1wDcU3oPwkxBc1--
