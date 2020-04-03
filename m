From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH -next] pwm: make pwm_apply_state_debug static
Date: Fri, 3 Apr 2020 21:43:31 +0200
Message-ID: <20200403194331.GA201060@ulmo>
References: <20200402065718.32433-1-yanaijie@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35729 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCTng (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:43:36 -0400
Received: by mail-wm1-f50.google.com with SMTP id i19so9021492wmb.0
        for <linux-pwm@vger.kernel.org>; Fri, 03 Apr 2020 12:43:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200402065718.32433-1-yanaijie@huawei.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jason Yan <yanaijie@huawei.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 02:57:18PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
>=20
> drivers/pwm/core.c:467:6: warning: symbol 'pwm_apply_state_debug' was
> not declared. Should it be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/pwm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HkeAACgkQ3SOs138+
s6HyVBAAtZfqkAbBTNmDItMz7Hg9MfpiGTj9ySzWgkyJXEG97AdvuIxvsvv64MyL
nu/bTHnvCti5d024RGET7ymfgkmrBF/jt4WDWUE0tSsFNc2Bh9LtLZDB8L5Mqqtd
YufpMDVhr4VRDLDtS8/APGiK7Wwlhlx6OKphC2JSMWOxXaZOxZ95oqHxgt6S4Y4K
z4PxEI86eDmg9BGEdQLCI7adxASKMpbobkRIe9GrIMq8tl00LICRgm4F5nauXOSA
scFl25EmcTrbCPEmOrjQpHrXZsw26aUKgK7Ch6uwAfMA44aCtccKx1SOEcex8IrX
NfF0c0wg1kwQ1JZ0sgPgIWcO8lhiyntzOzORgcofNAeV5gk4EiN4ViuLyARYcVKD
mrs9OkOwQJJL876tug6BR7Cc5KHFNJYW5+XD37pdPgnXDDa2ixwbkzme/7m8a+9b
WdUkzRoyjDvTZAa/XHaLDF2PAOn8gfLhPTmWkahPDesFNugpd+DIeqW3MeY3bt06
6iMsxjKGaEl+NsUS8JYDLE4o787tnQoF4ky1Qmvj/LbE0ZJdYrTYvDGBk8mqIEPi
rgQjCTIkPBnRkoyCKEDLoj1I7FZpb2mMkfDpN9lQ61pVsQXQzO0Ve4JxkPmKg9r9
FOSVGtXLJ1aCRYcjvPWjO7w4ETSvDJ87hqMol7Mzq2G3AzM9EaQ=
=ZJEc
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
