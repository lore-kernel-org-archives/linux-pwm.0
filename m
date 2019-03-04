Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37674 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDL5W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Mar 2019 06:57:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so4388249wmg.2
        for <linux-pwm@vger.kernel.org>; Mon, 04 Mar 2019 03:57:20 -0800 (PST)
Date: Mon, 4 Mar 2019 12:57:18 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20190304115718.GA9040@ulmo>
References: <20190304111242.6545-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20190304111242.6545-1-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH] pwm: atmel: Remove useless symbolic definitions
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-pwm@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 12:12:42PM +0100, Thierry Reding wrote:
> The values that these symbols define are only assigned to the per-SoC
> structure where the context is clear, so there's no need for the extra
> symbolic name.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)

Applied.

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9EpwACgkQ3SOs138+
s6GrchAAtXV3x8aALHiK17zwiG/WXIlL5oRJFPBZ+SXJr1I92LNA6C4U/uLSZoO1
HjleZyoZl+53ME4youYBNq2pDoha/5nbXZh8ArLoB1uN9w7bxg5D6IqxE25PyAEm
4Z9tXUIBC0T9nmMPCguj5+NYAXL1r4TntHmumwn9+OXwftg9+6HUET3D40NUdyD0
Apb2qA79NnauWY2GxK1Co2CAPLjgsFcSr3B+BCQBGBgPjtTgz1MrN7sxUV6iBiiL
uVGW1MeQdbBhSgOeh20UkI0VkT7sLUj31JJ9aX6E0/ZUiy3TcRZsgUkZ+LS6zck4
qeulViQJNuCT/E6HzGiffpQMUMRNP+fuw8oNIaN2qOXS4kM9mqrvwg5cwKaLkgxH
888bsHQOXjIb0ydQCBQuLfz9Db/NQYOnrkbNOUKW9Xs9nKTGz6pQYIBFU6bVwSbq
E76A86EjOm8glcKfoA8BpSV3lPjSc0uveAgPtqEd5WZmBTm60/ByGtNV5qxkfuLY
Vwv1u559XwCYkiK+SWbtB82eoFhBV5rS2Pt1oDTuToQFERyoaWKQkIqhSeSjMqjZ
FfvV6vO/pzJe65oG6eWgm+9IDJF/6PwKCsD7KKSH20D6cjc3jJBRCoooI/UHum8+
ZabN20VqEs7i935dNDU8Gg4SO0yIsNSX6iiXrJkuWF1G18zk5ac=
=UGCB
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
