From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: pwm-tipwmss: remove unnecessary OOM messages
Date: Thu, 7 Aug 2014 13:15:18 +0200
Message-ID: <20140807111517.GA31751@ulmo.nvidia.com>
References: <000001cf8ab9$294b0940$7be11bc0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:39822 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbaHGLP0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Aug 2014 07:15:26 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so5277513pab.0
        for <linux-pwm@vger.kernel.org>; Thu, 07 Aug 2014 04:15:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000001cf8ab9$294b0940$7be11bc0$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org, 'Philip Avinash' <avinashphilip@ti.com>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2014 at 02:50:08PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. The following
> checkpatch warning is also removed.
>=20
>   WARNING: Possible unnecessary 'out of memory' message
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-tipwmss.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT41/FAAoJEN0jrNd/PrOh9m4QAKw0OXO5KR+taLzI07/QM/Ny
xdDAWdKiNeJHVy0sFjYoXsZY2VnqZH9d36m/ydM+PyssDtRHQ+G1tqcoInaL8mvK
2f8qK/GOIrElOGlh1g5izx9T+yAVwXuP4fnFl8tamE9sSZVvlejlPdV5dvRJFVFM
dV9F3altj+hLMvOmu/7VequMVMa/BPh7U3tFxqkRbLTH8nbtm9jy3MhFs81y5Cez
ZiWkF2Ox/6ZNFQEFJutPtvbSEEQ2ZfSp/Tyz9TGdWb/6/lqfnwkRTTtmVUvse9Ui
Xp7+1qlI7vGOFgVoClwuwNpc7eSMW0Vhvz7g8stwXx0p2grsNcR346hEZXwGa+pV
KOBl438lk7+hYEiPHtNLhZzLH5bb1Cko4T7AzpXXCBgPf6PDyt1mMKi1FgYKRdRm
EkqsbN9RATG48Wy2saUfL5yJMCVwwnytVL3vMg7enMcIwSQ9JKh79jjxOVxTkTWB
MT1EZ9J01nhbOUZdYBXA4HElyvnT9F/cHPJ30KPTgQCa/Hn3YkwLPV/ekl1pAl5t
VXEr4TFH+gxI9sTq54BNq8y0d41ORAYWsk4oYWtGBYEpPKsZZAlK8VOOz397gpA2
LixaeJjCZHytMdG4UOgQb8eT0cvQ/ftUXbi+hWNnEm7PU5Dridprj0f5jrh++JHB
2csIkF1+LaTqhb3Stmqh
=V+0p
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
