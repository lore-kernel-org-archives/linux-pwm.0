From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lp3943: Fix potential memory leak during request
Date: Wed, 26 Feb 2014 16:09:55 +0100
Message-ID: <20140226150955.GI29779@ulmo.nvidia.com>
References: <20140123223220.7d68b5f6@spike>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:47494 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbaBZPJ7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 10:09:59 -0500
Received: by mail-ea0-f176.google.com with SMTP id o10so460767eaj.35
        for <linux-pwm@vger.kernel.org>; Wed, 26 Feb 2014 07:09:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123223220.7d68b5f6@spike>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: Milo Kim <milo.kim@ti.com>, linux-pwm@vger.kernel.org


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 10:32:20PM +0100, Christian Engelmayer wrote:
> Fix a memory leak in the lp3943_pwm_request_map() error handling path.
> Make sure already allocated pwm map memory is freed correctly.
> Detected by Coverity: CID 1162829.
>=20
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> ---
>  drivers/pwm/pwm-lp3943.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I've applied this and sent it off to Linus for inclusion in v3.14-rc5.

Thanks,
Thierry

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDgPDAAoJEN0jrNd/PrOhqSQQAIjEcWukvyTyo6Rsrr/mUR+O
OmZOdBJHupFMu3T4s6P9OGGkAAX07wd+vMwqYYjOku5HgZ2Yny+WOhQozfPJhVrs
YeWCsRmxcRWiF8hsu+/E9Ma2dCWeZ59OZYeX8hFhSk8Wzdo5Ukm/Ox7XUHpDGx8p
2s4hsyKVLNnU1O4U4QaQGePGq32rGXidtybpxzFc42qQh/MHN+tRHE/j9SYMPCpL
EGqlDKkGBFJ0olTLuNM/1M78VoKu+nw0mOuqmyc6ahtukeYN2trC/zfhkns9xv2g
67kFj2TPP3W9Pbyknv7wxaPMBwsQCYHYR+cqEmgoy1M+1Po1n9KdhfZXJiPVmpoF
gB8Jfnu4M6Powl3boi0cIo0Ajk597qqdj36ih49eU3X6J/phfh5nOCtJqruBhPI9
5mpXrAzgoaqMx3NQL7NGPMIaEIqfgyIlDPC35dAakI6oeDpvE8g50BgEyV/DlvTb
MV9kcKDhq+ePibniLujOv+ARueP/BlsH/dj+fO3ddD+6RVZ4F1JFq2bJM1fon8nO
naj+s2OQNJ2qZ0u5bRpnaAXRlP5g830uVM2X0gxfvgOV+IwPZ9QfgtvkJFi1gx8o
z5LwTgncwWd7ID9ljlusdPL6IW+8RdyeGKWwflzGA3vbdigvpJDGhjstZ4JQiNsX
6pO1NFmnsmJAmRUDStVN
=Mo+m
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--
