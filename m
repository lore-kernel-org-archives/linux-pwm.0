From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: tiehrpwm: use dev_err() instead of pr_err()
Date: Fri, 20 Dec 2013 11:08:43 +0100
Message-ID: <20131220100842.GG27787@ulmo.nvidia.com>
References: <000101cefc78$dbab1320$93013960$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:59190 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab3LTKKQ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 05:10:16 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so1104417bkz.14
        for <linux-pwm@vger.kernel.org>; Fri, 20 Dec 2013 02:10:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <000101cefc78$dbab1320$93013960$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pwm@vger.kernel.org, 'Philip Avinash' <avinashphilip@ti.com>


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 02:12:05PM +0900, Jingoo Han wrote:
> Use dev_err() instead of pr_err() to provide a better message
> to userspace.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStBcqAAoJEN0jrNd/PrOhvlAQAKaKxJ2dF4c06tdBgeCod2AN
80QuVum5DZkxmOQXAWcGNEh/fUPJ1F4JV/4W6pNES52mVGcqWfIrpz6LdcnNQz1c
MTauSRqEqMp3u5Lnr8AMVORrpVg8jD1KNkShMWTXX77u0XsUc70WKYTmAnAFYEpZ
oqOjvWuIg04LRWTr8yZgTAgjmMz3gXcoGI84F0W/LRmP8oROtC/kpGGk1gwyxt3F
Gugz6hIbijuSBy84Dz00A4HA25QxEh8b85i4qFtvxVOy6u7uf/PBtIgsVdUA/hGl
JJI8tDfT6093VhvthVjB4y/f0Gk3VsxNdoMV3WR3T7nI9H+P8NKNegO94M01hyDW
AzntdPgPKeZOEgS8eBe9TTX2kP8MAPKrW781HRVlHwGs7wXlc+Vkvgx+knj4fXxr
y6SHlPR3XN0YIEZ0hlZK0LBTL9qzgOwaqB+EqSKITSQsVr3un2AyBJC8euZKPFU3
brSN6Fuy5Wm85y3xIv+U3zF8Hl0k9VSzxR9vtOAwPilr42a4tAe9qdDN2R4Q7vJL
t7o6u9SOAceDKVU3yZVdIpFZaldW0XCCEYzOc4csVxq5r0GKIIVkm+vzMVBTjv97
TgQ8Ta+WDEbtObBzBdzH9PHdxZq7uX2rZf9ExiDVgV48SsSSQGJu+C7iBf5+8xdI
PSm0nltXwE2A/J5gJ8jX
=vr8n
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
