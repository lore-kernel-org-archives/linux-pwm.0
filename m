From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v10 0/2] pwm: add support for atmel-hlcdc-pwm device
Date: Mon, 17 Nov 2014 12:01:23 +0100
Message-ID: <20141117110122.GA25699@ulmo>
References: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:60086 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbaKQLBa (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Nov 2014 06:01:30 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so2284574wgh.6
        for <linux-pwm@vger.kernel.org>; Mon, 17 Nov 2014 03:01:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1412689095-14259-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 03:38:13PM +0200, Boris Brezillon wrote:
> Hi Thierry,
>=20
> This patch series adds support for the atmel-hlcdc-pwm device provided
> by the atmel-hlcdc MFD driver.
>=20
> Best Regards,
>=20
> Boris
>=20
> Changes since v9:
>  - replace select by depends on
>  - rework commit messages
>  - rework Kconfig description
>=20
> Changes since v8:
>  - rework the enable/disable waiting loop
>  - check return code of regmap functions
>  - fix DT binding doc
>=20
> Changes since v7:
>  - addressed several coding style issues
>=20
>=20
> Boris Brezillon (2):
>   pwm: add support for atmel-hlcdc-pwm device
>   pwm: add DT bindings documentation for atmel-hlcdc-pwm driver
>=20
>  .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  29 +++
>  drivers/pwm/Kconfig                                |  11 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-atmel-hlcdc.c                      | 259 +++++++++++++++=
++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm=
=2Etxt
>  create mode 100644 drivers/pwm/pwm-atmel-hlcdc.c

Applied, thanks.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUadWCAAoJEN0jrNd/PrOhOz4P/3VLS3t+JIgJ0Zs0ZjvMwwGE
QO6iesWXhDMl8BhqmRgL0V4kGDfgm3Gi4Uz/R29I/epUMrY5w2waL6UKp5xFwYKy
y+0iDeN4TC9R3tMm36x00JKuzCJ3kfN00tPGiQJwBqs9EiWepBpJkffBjRWBZzmk
eTKMk7fk6SHmBx5NfwqKux1UAHsZLdd6KVFc9k5FgRr0oY0aDTURuAbme6tcd8pq
XZ505Im/eO8AcSWbA5MHGLWoGu7hU5awXCKycPR5B4q6CIxSutKYmihwO/mkIpz2
kXq0AC6r9Ur0q+ArPyxtxIMFFEH/IszlZfvQHJC3nXZ+b3Hp6CR5YHwWtwIlO3W2
+scJPr2SclS+Rv3MP4yjO/CqWIHrQ+fhwuQTa5jhgL5GBh8Ka6RlN0CnbGhUqS9Z
Np+Ci+x6QxKL5pm+2aRW1UysiFVFwkuaKYO0fe/vDM4vh7/dL8vSyw7L31/zSJnQ
AXi2D1NwRl+WGoj2tmBLF47cSeVJv2VUdWSYvh2T7JxAlHV1UJ+QUieJTAnKocWf
ge5Umi9/5XulF/nnZllSUCtmdsQh7ES0C84EYM5FCNarUAghJMaqVnsPkS3Cw67q
BjgHFo9bzsHETtHeFTCohC+y64WIGCO+wA+WARKDKB4DNR/YWx55kG+nouHwv7dq
Jzs3vd+gMme+7wB3KMSy
=53uv
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
