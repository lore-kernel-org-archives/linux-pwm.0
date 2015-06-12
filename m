From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/5] drivers: pwm: core: Add pwmchip_add_inversed
Date: Fri, 12 Jun 2015 11:45:10 +0200
Message-ID: <20150612094509.GC19400@ulmo.nvidia.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
 <1432670900-27687-2-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432670900-27687-2-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>
Cc: Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2015 at 01:08:16PM -0700, Jonathan Richardson wrote:
> From: Tim Kryger <tim.kryger@gmail.com>
>=20
> Add a new function to register a PWM chip with channels that have their
> initial polarity as inversed.  This benefits drivers of controllers that
> by default operate with inversed polarity by removing the need to modify
> the polarity during initialization.
>=20
> Signed-off-by: Tim Kryger <tim.kryger@gmail.com>
> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
> ---
>  drivers/pwm/core.c  |   36 ++++++++++++++++++++++++++++--------
>  include/linux/pwm.h |    6 ++++++
>  2 files changed, 34 insertions(+), 8 deletions(-)

I had to bikeshed this a little, so I ended up applying a variant that
exports pwmchip_add_with_polarity() instead of having the additional
wrapper. The rationale here is that pwmchip_add_with_polarity() is more
explicit than pwmchip_add_inversed().

Thierry

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVeqohAAoJEN0jrNd/PrOh0V4P/iVaT9XH+43I/9kCp2WjLY2d
jnGDBE/h4AluDtXfpv/kvUI5zJaBPdopq2FbgK2vVGckPOSbvR//PvOmov0869wc
+LsfgxZGw2O1Hc1+CF+rpefD93q7C47iKnOpJKq8fdwNmpR4c2QYlb+WO+NkC4Nk
hpmyw6FMOzbQdmvzRQkum3VLh67Q4JFjRq99+56KfGo7m4MrCId9eFgYJ00gilxt
dDw+96QlIAHYNGC+Ci+farsY9zau91WFFjC9guAcNpTdIM5ROhxTQcAnZ/ly0e7+
SDtniA+Gz1p32L4S0VZQzE2WMzJ7zZHjG+lEB9Phu4IPsxmHZgDWRiGbmJcQ7Yig
Uox7ae6iBTwbp5FHgKFWfoHrIFmon+6YKjGKeuMiffR/LbApwJmgpJLUuuJACqyj
JtuozhvPu0njLojlV3YIC9wV7duR/56S5lxfQId0VKeOj8vjwaLfH25/PYRHDn6h
fpT/S3hHRSxKnaOsraC6RvDGHzx16yWDYTLpe4tv6o4jE+pPv3O1xoFg0b7HdIKU
mZBbSLqC0crTqrJqoFwn33neNx3SMU82DvoqyGCPr3xxGQD/7EYRn1ta/+R9zJPp
RG1/BzIYLe0zeBbPXHUJ5JvZaODFoqdTm/ZqOPrcP779GY8l9430BJdf1bCQAEOh
ZzFLAxtM+onmsHOtPXiw
=3sYg
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
