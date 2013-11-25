Return-Path: <broonie@sirena.org.uk>
Date: Mon, 25 Nov 2013 15:48:37 +0000
From: Mark Brown <broonie@kernel.org>
Message-ID: <20131125154837.GF14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
 <20131125031029.GC11613@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rEjiS+nMGFQ7Kkj"
Content-Disposition: inline
In-Reply-To: <20131125031029.GC11613@S2101-09.ap.freescale.net>
Subject: Re: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
List-ID: <linux-pwm.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--0rEjiS+nMGFQ7Kkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 25, 2013 at 11:10:32AM +0800, Shawn Guo wrote:

> Hmm, I'm seeing this breakage on v3.13-rc1 now with the following line
> in the kernel log.

>   pwm-backlight backlight.18: dummy supplies not allowed

> What's missing here?

Are you racing with the late initcall to flag that DT is present?  Wei
Ni was looking at hooking this into DT so that when we pass the DT over
we flag that we have full constraints (or provide a notifier to let
subsystems do that) but that ground to a halt.

--0rEjiS+nMGFQ7Kkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk3FSAAoJELSic+t+oim9jlQQAIIhhN3R9W3/c2obafltf2sC
fq2wNrDBSROB68+R9c03lKS/u24Jgkys6JmUA8s75KAcPkhoP48AGipuTMapEN3z
6QyLsgQxAiCGlo69UfHm12i9mzQiRo0uMhKKc3JadO/bmxK4Du0hGQZpF7OKNidb
X6Xd9VNLU/rx9v+UrGo/jE6ihSnibQ4R23lKERJx5QiWgo/fWSRmaoj1GC/mBgj9
QJ12fPxwo8xsvi/0mjzZvNbTJJ+0UKehGIM7THNQIMZC0xQke4ygsrXO32W4YBqv
9on4p3diw04PRo3dDl3ySq2KyTwi20PVG2EITKL6QM0VqC//hhXhgkHv6Ci5hMQI
V9V4xshB4q7dlNokP4/omIWC6HjZmJb6hlbK55amv6cAUHXEkRrtBEsnziGlvDVK
6WE6u/gba6Da+XJ+Oh4522bnAGXPM25rcArDrbKabnopOGsIgtB3msMOwcFCF2V8
0os9JNMMHZL/MnC9C76EYTkQw6QmqAJ6zu4ZT/XxFn9U++2IZXySvzaTbD0Weogv
CVfpcsngGJD2cK7chvaIJtFxMsKfsyRNeqyTeVw3DWfA2+NX7O5I7WgFhiasgZva
WJkgPN328hnausQ3KnMqAebT3uNNcj+u9ij/2PoFpkEcD6SCymKa92yLV4fU6qX6
r6ZwhOBX3baTH/3r1SIl
=SogB
-----END PGP SIGNATURE-----

--0rEjiS+nMGFQ7Kkj--
