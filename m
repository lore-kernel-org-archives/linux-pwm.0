From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] unicore32: nb0916: Use PWM lookup table
Date: Fri, 6 Nov 2015 15:35:12 +0100
Message-ID: <20151106143512.GA11511@ulmo>
References: <1444025323-23904-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35284 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161403AbbKFOfP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 09:35:15 -0500
Content-Disposition: inline
In-Reply-To: <1444025323-23904-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2015 at 08:08:43AM +0200, Thierry Reding wrote:
> Use a PWM lookup table to provide the PWM to the pwm-backlight device.
> The driver has a legacy code path that is required only because boards
> still use the legacy method of requesting PWMs by global ID. Replacing
> these usages allows that legacy fallback to be removed.
>=20
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  arch/unicore32/kernel/puv3-nb0916.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Guan, I've applied this to my PWM tree since you haven't responded to
this. The change is low-risk and badly needed to clean up PWM consumer
drivers.

Thierry

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPLqeAAoJEN0jrNd/PrOhOncP/0Vv3po4vFvuGOv2NucEPVVo
sHHTFsTmkFK5nA3f+JLVQbf0HpePjbuO3LfWKExtBJL7amo3E+yGnNUYKYhD79lx
+GoNbJdL/ISCJqvOQ04ZwYCpPtOaZaRxSlLTxSvtvq7MSWI4T9MXrnHFnhHpLz4a
5Y8ntLroVlTcrU//GjMpL+E/AITIc9cnlUsZkIDghFZkw1WMKNOu8UXyXno+S3J2
kCn9LC8kNIg+b2qJdP1cm08BjDdoGLdM24Stpd5x4+F1Dk1KX40Hduad+gBr7gSA
lq0QpMuKfV4p7HQv59WoRyzFwDPybDkpoCj7kUp+TVG9HR1K/rI6picale8fFVQJ
xfJBeXweLKaDlTVBrzJO8vlP2GMu5+I0axepwzj+P3yc1wdvbBmFQDqAoaiSAG72
QTLlti/R/aHQBMaMTjYVgY7xf334D3tTOVcGNkX0dca+3AsEs6Ubuml2tVTQ7L7u
22XTyRJ5RcvdCmxPzq8wm2VtBAx74XIChfp7O4/ouZDIIInNvOikmCJnUvL2vUAw
7dZx86ArU1rL24jrK7KdHLg/2nItkBhN1cVP8ftBGra/qXnnYl5b3K2jmzqtNbt4
NJ2sqPaaHZ7yF7sUkGSQRcqKuA0qLxC44UOOOA30pk3IJGKy/cGQNcsegiqbr0qM
v0eV98f5vqifzy4qo5bm
=MREH
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
