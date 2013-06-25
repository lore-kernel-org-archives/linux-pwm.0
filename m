Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38004 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3FYPTH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2013 11:19:07 -0400
Date: Tue, 25 Jun 2013 16:18:52 +0100
From: Mark Brown <broonie@kernel.org>
Message-ID: <20130625151852.GD27646@sirena.org.uk>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1405696.in3RSSDWnX@flatron>
 <20130625102646.GC21137@manwe>
 <1688471.WOi6pAAcEq@amdc1227>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pQjS7IR0m4/DQQ0Q"
Content-Disposition: inline
In-Reply-To: <1688471.WOi6pAAcEq@amdc1227>
Subject: Re: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <t.figa@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>


--pQjS7IR0m4/DQQ0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 01:19:54PM +0200, Tomasz Figa wrote:

> Kukjin, can you amend the comment I mentioned to this patch above the lin=
e=20
> with DEFINE_SPINLOCK or I should send fixed version?

If you're amending stuff please feel free to also add

Tested-by: Mark Brown <broonie@linaro.org>

(for the whole series)

--pQjS7IR0m4/DQQ0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRybTRAAoJELSic+t+oim9arEP/iXfqz/H5YK9uVb0KCnnDuV2
9MDwDNDjBncsjY3EJrOgMgo7oBUAMwr8NfR5LxbDQMHjXiTyQfmMe45IX+fkhaAh
6glQr8oZXZ8koJpXBdLqkETniEDvkV3T6NQDKVUzJrjX0BQEb7cdBjg+OI/w1oTR
OH3STJTJ4Mb6pnyXkGM9KP//54J6R3MjiJ0huBoHS8DjpPXP4cp2fEF7em3u5jgz
zEZpwtasOkyPB9fxquD6BFChe5PdKNWJcshjI6K8BtDCX+HrUNUMP0PyLx7uT11e
1jfB9e6ZlLFfVxTaougCEgQ+K5A44jDJSv/OE2f3OJ5+stlnur5C93HsQoekFcFx
PPP7JulyfvR2b8f3iopujVuTD057vmiescY0zHXEApxMTw3Jz3wkDrH7QMz4msG0
aWa9bJWzaARGByREH+MbAWKGtWfM0df9/No8xRUmVykBn6GiwYElHD12XolCfY32
d/HEwkdiLLO4i8S6MYAFARvyn7EBioX1GuNtjFdTt31khD1ULKWBD4LuWFlgGmW0
DFo8QThDWxAjkPnDzy4HSXN6S6afwo647mj18f24lts+wGvKFJuqLZYtSRYcj7/r
/vRWluRO1vgYYOk4spfa6NsdtHV2fu5mbrlhJx5w3arwb/sCWVUa7MgCECO93VxX
bSfhnDY96nzcytQ/mslD
=h4GN
-----END PGP SIGNATURE-----

--pQjS7IR0m4/DQQ0Q--
