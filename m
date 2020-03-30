From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Date: Mon, 30 Mar 2020 15:07:43 +0200
Message-ID: <20200330130743.GB2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37095 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgC3NHs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:07:48 -0400
Content-Disposition: inline
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> duty_cycle was only set, never read.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B7x8ACgkQ3SOs138+
s6EaLBAAgAn/lgDB44oc59O/xOFW9osN2zFPkz231wt++SqoKpegoQSRAKbqdpeZ
lMD6fk2mxySvY5syYnQ+BQe4J6of70RJ7ID9+5UgFInF7mx25O+6LmtmgmszQkbF
PutCzVtQ5SDjTGO5SBQ3D+Kwkq4pQarcd+d1oJqncl8zOTiJbKkkD0mKgwmm+eQo
2ZSnp6h7nN1gbsaF0K2DuzCtCWmYw5ZfsOvU+i77wszL7KQQwPUL0TBN2DDl0ROV
Xeh9FvZBfyzObO3v4T/zaN7GO88fnqCC6KU1pJb81LjmdHguo7pylXAm8W5GiSln
xFIwWgQ7Yw0Z/niZCo0jmujYelIckGoDyxvUzwmMPOHWzXMyip5RBHmof3HK/cmK
iCXYX2c9Z/3Lio1FzZGzaJqLMk+29qWg5Ck9E96Q8ClRUBV9uy390tGd30fb8k8M
lot06XClM9cbUYnIOeu7pOKAVmimZiiXE4UMPNr39X4uoJgTxt0mmW9iMgafEn8e
jX6+iBXA8c24DTwtuJMo6BaNvsEkkhVw0qXwV7DObRokRxVUG+98xPDRA/+6dwtz
BGeS7gRq38xnPzIN/vEfnp1qU9ZIFVkbj/rXWMskqDTmZnn27fpamKHYaM57Ad7V
Po4ZkDx/K0H1hv6l+DQ0pABBoOLNr2tv5CbPD/wZP4ulgqdOcCY=
=pidG
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
