From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 04/26] pwm.txt: standardize document format
Date: Thu, 6 Jul 2017 08:24:06 +0200
Message-ID: <20170706062406.GC16144@ulmo.fritz.box>
References: <1a82f2bf2de4b016964cb71ff92dc3a472044f40.1497713221.git.mchehab@s-opensource.com>
 <2fb7d94b573b500d99f6d21b477657482cfa0e2e.1497713221.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34190 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbdGFGYM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 02:24:12 -0400
Content-Disposition: inline
In-Reply-To: <2fb7d94b573b500d99f6d21b477657482cfa0e2e.1497713221.git.mchehab@s-opensource.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 17, 2017 at 12:26:44PM -0300, Mauro Carvalho Chehab wrote:
> Each text file under Documentation follows a different
> format. Some doesn't even have titles!
>=20
> Change its representation to follow the adopted standard,
> using ReST markups for it to be parseable by Sphinx:
>=20
> - mark document title;
> - mark literal blocks;
> - better format the parameters.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  Documentation/pwm.txt | 46 ++++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)

Applied, thanks.

Thierry

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld14QACgkQ3SOs138+
s6FE0A//ad1zzrrYNYZgQc00B0OJRCuwmO6d3AtMGUpDboEsUHvdyyM26k9K5N7v
stA67cQMZdrfke17YgX2VGhTAY9TlyFV+CeiQRil177YiIM25qqdW0reQO3sHIdD
xB7hHVZj3yIbLHriCWj31/IiipRANhWMT8MjjBdPqJ2YWEmcczVWNvMcu7AS16mk
Dc4WxwErw5Gkgg+m2rZ0+0ifJrGU7zqK+MTcQhF3HuNRYxQtOnUpFiTTf+K2Iec2
XRt6E/SlTjObnzAcKa6ZaHKHa2Ka3bKMFQiCPzhFgFaTm99p1qqLy/PYxIiT0EPD
cF1FFCUo6EU3cM2ZAAttqoox+U1QIJeBQ/GTvsK9OzghAMFoZFkuxzcouDX2T0Di
3JljTcDARCMAyZ+Yc3jJ/L0WRXfK7n9ZdD7qpsvXBfXczNwhsgQC+vZhQBJJ8UqG
3iXXwxOdt9exjmo5uG41weQQZqqjGKNNmJLInbb6U+xgJDh6/gvWy9+AfuIMELe2
JjO698NZpxEJtZGSss/OC8GbfTU6Yp85nXZrgc1Pz3Wfvmdu7OBNYwQ0BFGnnW4k
PrMZdZB4QRgAb8M28cVPIQj45yMCqtE/8u8TOYjXoAlVxavuI5yIRENdix6tlA3S
BSuyK4F+6ToAa8I5ev25J3lpq8npUusnPa1yUMeI85qbYUHCqDo=
=vFqp
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
