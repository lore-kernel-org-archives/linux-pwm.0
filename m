From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpss: Remove ->free() callback
Date: Wed, 16 Dec 2015 16:40:44 +0100
Message-ID: <20151216154044.GD28947@ulmo>
References: <1449669959-55013-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36876 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbbLPPkr (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2015 10:40:47 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so6553226wmp.0
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2015 07:40:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449669959-55013-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Qipeng Zha <qipeng.zha@intel.com>, linux-pwm@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2015 at 04:05:59PM +0200, Mika Westerberg wrote:
> The LPSS PWM driver calls pwm_lpss_disable() when the PWM device is
> released (for example unexported from sysfs). This in turn calls
> pm_runtime_put() which makes runtime PM count to be unbalanced if the
> device has not been enabled at this point.
>=20
> This is easy to reproduce:
>=20
>   # cd /sys/class/pwm/pwmchip0
>   # echo 0 > export
>   # echo 0 > unexport
>=20
> The count is unbalanced and prevents the PWM device from being powered on
> next time.
>=20
> Fix this by removing ->free() callback. There are no resources to be
> released anyway.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYX8AAoJEN0jrNd/PrOhYboP/iU1gOM57ZrFqewbwWMZo2Uu
rgfQNuux6tfGPIYDLUnAa9y65Ug9WDGLQkqMrt9SRuloE1YqhpAlgnUwiYQPkVB0
Gafukl1KDVrXp9wKdlgoFejYLx4b2I/IL9nsDPSMEZtc7QwVWlJXT74quBjsyqMH
N/hFPQ3vQpu+7lVUB31JvRBFNSSR92ORy1pZdWHg0KudHcUzJPUl+pGpPYqOybAN
UJMqVosGFl0fcLK+aNyGfQqCNSkLjKrZ/0uujnH61RcM3U1+O14eHZBKEkWag/P5
MKPevCuV9I0jn3oBTdH8L/0sbt/h+fzy6kX8w5gi0v4KvDfPB+BGj1LPimUHwcS/
FovXw3gmKlFNMTRSXskfjGeUpevuFQIgjWKrq6qnP6wIEtc4sbqu0XrDlUgjKTdN
43pLFJCdOrGhw9dnHvmwB6pzPISoqNfRY0nusPULsgGafHR4x2qDkdJgg7vxLhmE
VDgqpKCb3Me3RBKmyjnh95TylorOBD3bd/olXvqzHDGNZMYdjqryNSHhrNh1M9qv
33dHz7YjIyn1bAiyimEjHtKNKJKUfCPcsDezoZXuRVLljeoG3kxP8jzdm1Xs7ktX
U2wAHq/jzLH/mkD10ho0Gv1b91TvrQ51jsfNGcIkUJg+WiEnUXdcltlbzore3+6w
bqBXCzlb0MRPjQrBZfo3
=FAwD
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
