From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: tiehrpwm: don't build PM related functions when
 not needed
Date: Wed, 21 May 2014 12:01:49 +0200
Message-ID: <20140521100147.GA22783@ulmo>
References: <1396439802-6813-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:46974 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaEUKEH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 21 May 2014 06:04:07 -0400
Received: by mail-ee0-f41.google.com with SMTP id t10so1375016eei.0
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2014 03:04:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1396439802-6813-1-git-send-email-wsa@the-dreams.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-pwm@vger.kernel.org, Wolfram Sang <wsa@sang-engineering.com>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2014 at 01:56:21PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Fixes following warnings on AM335X with no PM_SLEEP
>=20
> drivers/pwm/pwm-tiehrpwm.c:534:13: warning: 'ehrpwm_pwm_save_context' def=
ined but not used [-Wunused-function]
> drivers/pwm/pwm-tiehrpwm.c:548:13: warning: 'ehrpwm_pwm_restore_context' =
defined but not used [-Wunused-function]
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches applied, thanks.

Thierry

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfHmLAAoJEN0jrNd/PrOhZmQQALCE+4FnWYIzi5oFmMR6rYgo
DV+ngqQwGb5xXcaLklUqnhBCR/TU9GEaujX17g+dCX86yiWCerWuRjbxji9Vh0+V
sUqHftc8RBEJnug5K2RsJ4NZwxuKshg+aOuFd/nJoRMk8ZxPIlG5RfO9dj0NebhJ
wwUMBWO3yMZYM4eTDdk7u65Jzk1VkMiYBcuZ3hq4mcTOmH3ihpsqkvgkJfSaf9CS
qexNxZVc8THliSSVXmWKopUhTPTtsHFHchjBR6yK1TA77lVXqzBJ2ySDivPZyAaZ
ogtwu+8rxmKf21ccqxaeLlyFQPsociH7M17o62brcwm66hAxISMKtjXvyLU8QDMQ
tknaIbXQ0jCMkVH5M0v4+VDXIb/ZXI89ay8txRAwf09TY6QjQ00iFrrGx6vd0+uL
M+wh994LYyEPEt1UURISmLIDAvzoHU+lD4O36zUUHs1wNSpbJ4U08B6/lLxBrGjz
F8xzvsF+kRhkEWNRRf+bgBYPmcn0VaoEQpTTOYnC1O1QcT7cYkPKe4iANqkjpO2F
m7OCV1pzQgnL35LH8jukCIbsllZS6/Wrm0z1EZ/tI2yDkWA3GW5yf7Of0dPgIxFl
aFZO2yBFDu7CGWzHy3mpkj2iNySCtiYoj5HhQ10KWJ9P/6aiT9kJz+8TTybRx1t2
AGBqVV1+EjzUf9OVtqPS
=wBcj
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
