From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linux-stm32] [PATCH] pwm: stm32: Fix the usage of uninitialized
 variable in stm32_pwm_config()
Date: Fri, 4 Oct 2019 21:26:26 +0100
Message-ID: <20191004202626.GG4866@sirena.co.uk>
References: <20191004044649.2405-1-yzhai003@ucr.edu>
 <20191004062336.jidzrytx4z5talro@pengutronix.de>
 <e6824330-d331-798d-0f0a-1952db028900@st.com>
 <20191004200804.ee6kedadchxoznnd@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004200804.ee6kedadchxoznnd@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, Yizhuo <yzhai003@ucr.edu>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Fabrice GASNIER <fabrice.gasnier@st.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 10:08:04PM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, Oct 04, 2019 at 09:09:51AM +0000, Benjamin GAIGNARD wrote:

> > like for the your patch in IIO trigger regmap_read could only failed
> > if the hardware block is no more clocked and in this case we won't=20
> > return of regmap_read.

> I'm not sure this is aligned with how regmap is supposed to be used. I
> think the driver making use of regmap is not supposed to make any
> assumptions about how and when a read or write access can or cannot fail
> and instead is supposed to check all return values. So IMHO the patch
> goes in the right direction.

Yeah, if you're being very good about checking return values you really
should check them all the time in case something comes up - you could
get errors that don't come from the physical access, for example on read
if a register is marked as unreadable, or if physical access is required
but the map has been marked cache only.  That said a lot of people will
just not check anything since it's not common to see errors and errors
that do occur tend to have other quite visible effects like I2C bus
errors or system hangs.

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2XqvEACgkQJNaLcl1U
h9CaBgf9F1R+YrO5gnXlm0rVv4WfDznyoFteVUwcOxUPCYVlAM3Mi0NWZTPV127a
+UDkmY2bVwpdMLseyucXYA8Tsh2QWW0ic2EWzUmckRhNqhRRKHKBrh+rPgnEVVeo
JKovxJ6wOBLnZiBlFSha3kcZgyk++Wk6tN0h1a+ddZyEAdQuXmnzDoSFEPaEm+75
N8gocQZjjSwrUfdywR+qiiijUGZxfMIMXszlpSAAsUQwGUNYsluAJLk1tF3Dx4zW
Ha1NmhZKe3anQv63BN3LPSy3joiGKAdPUlY3iXfH8K6DyS9uK9wiFHdsGAaaCLWb
rzBXzh6DEU1xzh4WaM7DOA5RtyjWDQ==
=l0K8
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
