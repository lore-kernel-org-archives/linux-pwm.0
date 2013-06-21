Return-Path: <thierry.reding@gmail.com>
Date: Fri, 21 Jun 2013 11:31:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/5] pwm: Add Renesas TPU PWM driver
Message-ID: <20130621093119.GB31464@manwe>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1371142488-2514-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <1371142488-2514-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-pwm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>


--l76fUT7nc3MelDdI
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

Applied, thanks.

Thierry

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxB1nAAoJEN0jrNd/PrOhuPAP/0Tqu132HiKS10UJOChzeC/k
IeVzOheCVJsejhoN7Uu2kQAM+fynpp6kKmCP413Ay9tRvu5cDjeuy2OVPU7uyc2n
OMdz9+kzYtGfJ5Y6ruf9jEq7KP0X1Px1lLB9frjnkyN7bfn8/3VW2ODPjAUlR5uh
4HTctNO9EWnUMaUDWKIuSSXSdYgbiL1jC3zZDuBXmXn6mjoVzjxD4wyPEVp0CeoW
iDLscCwMDEwgE+WejkOuSzp8m6gaOGQuwm/ZX4wWuoMvhU+1/XRhl8xPEDxabANI
BPo7jy1Yx9cjRxBGyoskseiGP0mGnfg9mTs/bxnFg9Rreo3RnYYk83zo1FysLCjj
e5fITKJ1hZ4fC8u3vqjVi0cb8C2MxogonPqm6GPDidO2uEAYvRd2XWcS5BXBRpIU
84TxJxU3b48QlyMmpJGZC1TnVk94bYSNqfoARjNmJz4KM0Hn46bYGBhZjt08MfNY
MDVu6Fl8dkF9EsbSRPm6LJElD4v5GTkQnrBdp5EGSBMPXW247kzQomyde45RWol3
YSGcUJCjtjFeMVbVIsnfQKPXbWXuKnRXb6L94s1rqxA++GB6u9ABcOJbx3GCuHWP
ztcJsgdNxir10cw+nnASVUQp5w93lk9Cdp8ZLftNbQMTFok+inXlY9eW1Hkk/uTB
eGnfHWQr/rwK1rJzGg/m
=eI0X
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
