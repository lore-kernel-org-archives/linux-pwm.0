From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver
 documentation
Date: Mon, 30 Apr 2018 10:19:46 +0200
Message-ID: <20180430081946.GH2484@ulmo>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com>
 <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
 <60772240-3c75-7814-9237-d60916a8ceca@suse.de>
 <CAMgXwThYN1E=awkd8yF2aNN+QOLwHkx=UyWqGrOnMxv5jyVj5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMgXwThYN1E=awkd8yF2aNN+QOLwHkx=UyWqGrOnMxv5jyVj5g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wesley Terpstra <wesley@sifive.com>
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 29, 2018 at 02:08:07PM -0700, Wesley Terpstra wrote:
> On Sun, Apr 29, 2018 at 2:01 PM, Andreas F=C3=A4rber <afaerber@suse.de> w=
rote:
> > "pwm0" sounds like a zero-indexed instance of some pwm block. If 0 is
> > the version here, I'd suggest to make it "pwm-0" for example - you might
> > want to take a look at the Xilinx bindings, which use a strict x.yy suf=
fix.
>=20
> That's fine. I'll change it to pwm-0.00 in the next patch series.

This should match the version that you use. If you're internal
versioning uses single digits, or a single version number, then I think
there's no need to use 0.00, because that would just be confusing.
However I think it'd be good to make sure it is discernible as a version
number. Perhaps something like sifive,pwm-v0. That seems to be a fairly
common scheme.

Thierry

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm0aAACgkQ3SOs138+
s6ELZw/+Mci8WW7pIpcPzvO9Q7xNbU4NmKkMr2nPSVEEkPbnUsbeM/V7UhDYbXue
Qp21a6rkiWvIskrKrtWFheerkOgp7UD6YpDnZc3ycEwdVtMs/LcYMtJEuQ5v6Aa5
VBHXy5VDJHGbJt0uA6SXLq4hP8xSYCfSwEk7bmJSLdd/M0NnyJp2+rVHuQKybGK4
ckd6NnKKp0Z0qgchUePVWspkRAZi6uNXme8X3eNIZc+YbPj3wocIMoW1St7vv1uO
ckQl/Vrp3EtoK7fnMARbGPYjcHvgRN5IkJlznvPQS/0LWo4JG+Y+OxgeKRd1PvoN
hZBTSeTwY4dNtE/VoEXQjKp/bd0DTcrLp9OL71CjQMTGOFMq4LyAurJUxHrs7BYY
UVuEeJfLMWjW1f6/l74Efo5HC3lgjOaSQuY1Ki/auO3JVHV0O7NhLFXA1lIbyjOX
NbLxdy4IjOMu9KC0Bm2hz4hjjk2WJjYATCrd+Zh85xnIKyb1+nwI+E3h5Wtyu/t7
P25KiF0atkTW83MdBeER9tsd0e9wEqaiNszxMrTI4UWJwHowV/yCGcrMdR03TTJ6
EtcSO1U/OSxaCU4QPQMmddi6A0Kh91+u0mhITDNuQ5rdWM/4UJLo5t3CVzLkmmpb
0atNW6XLrZcRzjKBYqhncuvhzk6+x77o0sUQlQ4Ke2pE+2K3fFc=
=BA9b
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
