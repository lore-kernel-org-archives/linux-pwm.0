From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv2] pwm: lpc-18xx: use pwm_set_chip_data
Date: Mon, 5 Sep 2016 12:15:09 +0200
Message-ID: <20160905101509.GE31424@ulmo.ba.sec>
References: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34593 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932835AbcIEKPN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 06:15:13 -0400
Content-Disposition: inline
In-Reply-To: <1472143629-29890-1-git-send-email-oliver@schinagl.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Ariel D'Alessandro <ariel@vanguardiasur.com>, Joachim Eastwood <manabian@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 06:47:09PM +0200, Olliver Schinagl wrote:
> The lpc18xx driver currently manipulates the pwm_device struct directly
> rather then using the pwm_set_chip_data. While the current method may
> save a clock cycle or two, it is more obvious that data is set to
> the local chip data pointer.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
> Hi,
>=20
> This is a resend of a patch-series I sent last year. There was no technic=
al
> related feedback and so I am re-sending the patch as is. I did rebase it =
to
> Linus's current master.
>=20
> Changes since v1:
> 	- removed wrongfully added sun4i patch
> 	- split patch series into a single patch
> 	- added author
>=20
>  drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Applied with minor bikeshedding.

Thanks,
Thierry

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUWtAAoJEN0jrNd/PrOhK7wQAJ0Cuxu9OidSdSv0SmoCpbIg
VXY+0XoDd6yLIYMRxZiR/HIgB+qZ2x7kgriLwL4o+iQf6sOAvwR4GB7SVMP7wSdh
sBEOAwInt6SaoV5Mf/Vm1OrrzUTYfyoZSvoc5TVjhD7nANYiUcqET+O7BXORqEFI
roiMWunoH2fxvN8Hhgr+02bW6CmTJ7mu/8GOyWetX26HzQUeuvAiumk9ZmZIrvXL
f2jeHK3kaXgAnIH9Y3C5fIcbBcx9VszCBXMiiMngjdRYzNMwjZwT2OW9wYzPA4PC
mPQRyRHDqF834uWah72E7346AEpKKEX7pLo4ZNlFf3JA3s2Q9spZxPCHJX1x0pMM
wc5cHq637kPAi+LDbAaJP7anYvJjeWTsmlkj9AFmqIQB32r/VOS36V1JI47dN+ae
EL1ll/yrSlPUUWZhLpTBdNwfEZKM7wnWSbA1R8s5V4ARDU2v7UbW+K+Sg6cxuHUo
pXrQpgliIYDZZQsmMQyVcE2JtJiXRg/6WM0vDVWT66+vBE8pBPH7dd9//b9uhXof
tF27lMMw/mG1gT4TwKYL2jnWvZ4Qqxd4ZvUJsQ/b0erOMWJGgXMUQzcW3pU6Ylnf
9nHrL6d9uROfNi2sIJtKPfOn3EgtIf58GGAxwWQkaKZhC1qoGXXZLKquhWkbA4jm
7s+aecMYT0ycBL89hMgj
=kyQf
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
