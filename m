From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 04/10] pwm: core: use bitops
Date: Fri, 6 Nov 2015 15:46:35 +0100
Message-ID: <20151106144635.GA8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35353 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbbKFOqi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 09:46:38 -0500
Content-Disposition: inline
In-Reply-To: <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 10:32:35PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> The pwm header defines bits manually while there is a nice bitops.h with
> a BIT() macro. Use the BIT() macro to set bits in pwm.h
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  include/linux/pwm.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I don't think this is a useful change. The BIT() macro needs the same
number of characters to type at the expense of requiring an additional
include.

Thierry

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPL1JAAoJEN0jrNd/PrOhT0EP/AlEOEZlkZ2reunUGpzm6GhX
8szsuHF1TXHjB4dqV3BtFa6RmitWADEyAUK21NFRPLr5RWUO3IcqMMJM6SRcmpI9
/aag+0xabrwEjtD6quOgb7+3MKhQoWKQcTIX2CiE2jBm931cQMSohVYwinCKN8l8
5pdOtF1ZOmeStzzX8v+V2AnGvL1+ddtfWU7piDHdFGvX14tgQpdwvoyYOioTsObw
FMD4nh6+qhS6zSNE9MarR0/k3w5lH82Pibc7Ap1CQlKBw5b33p+E07RHAxY5+8wk
hbbHXl1Lfye5Ldqjgs5h8ORzATRU+RRj99lFtZLfgDuE6y/8gWR8HJkkLM3hSaCF
yVBVfWNBCzSJSGKRA1IJKAUv9YZ2gCmOIB2Bx56FcwYLGne+i7lClkwwWe0eA9eE
pLbfZVrMRiD1mxKg5FXZNmCkRQ3xc9gcZVk4HARozkhXU4oE0pMgzbfkicU7I6O2
fWe128PvbtuXum+wlrxhlhItFr2H2pZLr4cUQkKrCfCxjszw6N5jsmJOYq352+zw
dg6IHjiAkedaNvaonTqVpRrEaxQJpgbqggCFL1oYsZDiB6evwOZcxHE5ks1ckkGz
Ptg7eBatLlW1BdQTWU5Jfcv1hfFBIpr2d8FPhjVXZg/0gGFU5NiqHToUk+hkagY2
e23v/Eg8ED1gpyu+mJVM
=Fv7C
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
