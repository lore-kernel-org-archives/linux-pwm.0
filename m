Return-Path: <thierry.reding@gmail.com>
Date: Thu, 13 Jun 2013 20:31:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/5] pwm: Add Renesas TPU PWM driver
Message-ID: <20130613183130.GC32574@mithrandir>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1371142488-2514-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <1371142488-2514-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2013 at 06:54:44PM +0200, Laurent Pinchart wrote:
> The Timer Pulse Unit (TPU) is a 4-channels 16-bit timer used to generate
> waveforms. This driver exposes PWM functions through the PWM API for
> other drivers to use.
>=20
> The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
> and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Tested-by: Simon Horman <horms@verge.net.au>

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuhACAAoJEN0jrNd/PrOhAsAP/0tT6hMmkQKQxnAlHbITC5FP
2JuKw0CDQY5h2JxgHzLjCBz3w+Jo6HsQjtmvL1KFApV7KHDru/+z2u9p4CEL4461
YQgBgx1NcrwOi+3Vw9YljPMhocX1cTp9RXSdRVRwNWI3Ohs3254Qj+J1ANHjtdSh
d1BNMO06aqUjWT73NR+94qfWOLaP8olp+hJWHBNzhFATVxglqjZTPKmBKfpuHiS/
y856aaYrx1Jx/dZYWsvGFAlETq4kAh+zle4VN7YvHZSwnUIhBFKhMF7X60CjoroB
6e9KvGRrlnM59QwP7hL4kHqc+jr4eEZ38AmNfN9ujb+AkiIJA27YPhkFLD2RhH7a
L2n9m0VHKNBjRTNPqHdF+qf1pZjuk4XedrxF2S5kY5/nrlOi+RXKvSVPmbfdijhK
r90JFSGLxjSoeCQLyS7VTwvEh0nqORkCspSdMnebThBKliQBANETJaHNYpsgoZQT
FQ0bMvyucqYVh5tahojoeSC4vlYoj+FtRAin7TTWmcyiTtucBOt/HBjQbvh9PUuZ
dBoN6Gxep0PnR35A7T6leZSWoWv8BErF0zxxjCmMEX15ohm8A8GJIa+B+3NyusPX
GZ8Dalj1Q0FZcLFH7kofVCZVZfJkTxE+TsCGeSUsfF2e0TOYq1Vt+Ra02jLSF+KG
B3O63cl8Rov6SXY1u2gA
=DRM4
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
