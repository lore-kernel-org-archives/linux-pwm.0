From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 11/15] pwm: pwm-renesas-tpu: Enable driver compilation
 with COMPILE_TEST
Date: Fri, 29 Nov 2013 11:53:54 +0100
Message-ID: <20131129105353.GI22771@ulmo.nvidia.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385515117-23664-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 02:18:33AM +0100, Laurent Pinchart wrote:
> This helps increasing build testing coverage.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not sure if this has been answered in any of the various subthreads
before. I've tried to read through them, but I may have missed some. It
was mentioned that iowrite16() wasn't supported on all architectures;
won't this possibly cause randconfig autobuilders to break?

Thierry

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmHJBAAoJEN0jrNd/PrOhinoP/1Qv6lb0wEwjxZ2GLL+NNZW0
jhNrH7V7uz50/vGJBmkdpdVC4RqHzgcp46JwOliDePvVzTtQsTMJw4fFkdADfIVa
+iLCx/l11FG3Re/LLphYh+wkK9ljN88Ov2917ui482la70DBZ86WNAOEvZRB3Xm+
Zl/UQumOV7xRiT2Hdng8h0EFAc6fy5RuXSlJuBoWDxlHESNuW/2BWA+uuEoUxL0t
MxAM2vQks1QyjfhBp2w2hN+Kg3TgBJYAxDFFNfQ0lero3B9qFGLsKAG6iHk2iveh
WTMKK54PK2IM5kGE44R4CvYHUW16+y+CbG43mcbC6f28tsAv0msVbkKB0f4T5JLc
HJU1rECsHzNxX12pcupIxMnDTxpeLhlG/23fXFK8op5q4jXqnXWZgZzq/6i70Hjk
cDwDFhIEZCjTni3WmI/mIoFjwuO2b6hpgdmdfn481tkF+OSN2/Pgg0Z9bVlZu5W4
I2bJfRrxdZbmwuysbU2Xy1k7oLu0dcu3jvLdiT1Zge+gc+45xiV+R1wajAosXbVu
nwhBOasZN5uOKHz3QUZch+l+2y3cG4OVNCkyroKobDoC5FO3rs+xc69vGS3Y3Xsn
4rAk8QuT3FrtBHWsxMT7hQFTkfXfXuXact08X4GITN714L4ePrfKxoSxeiSRn0Ej
86Zsk+axXI7u7K1tD3N9
=d53K
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--
