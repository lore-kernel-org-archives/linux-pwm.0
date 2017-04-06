From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/2] pwm: lpss: Split Tangier configuration
Date: Thu, 6 Apr 2017 14:54:20 +0200
Message-ID: <20170406125420.GA7784@ulmo.ba.sec>
References: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35415 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752846AbdDFMyX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 08:54:23 -0400
Received: by mail-wr0-f193.google.com with SMTP id t20so11186265wra.2
        for <linux-pwm@vger.kernel.org>; Thu, 06 Apr 2017 05:54:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170406115401.29172-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org, Ilkka Koskinen <ilkka.koskinen@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2017 at 02:54:00PM +0300, Andy Shevchenko wrote:
> As a preparation for special treatment for Broxton we split Tangier
> configuration.
>=20
> Fixes: b89b4b7a3d0a ("pwm: lpss: pci: Enable PWM module on Intel Edison")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Both patches applied to for-4.11/fixes, thanks.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmOnkACgkQ3SOs138+
s6GCJBAAiXMkdskPu7JUGNeCeyMN7x5AvcuuZ8XJlFXF09WCAErDiC4pxl/zUnTH
3lUD1vIs7ZCmvnQtAubkDFsehwKfzEkZmR3Ke9xpRQ8X7XabGSONslRRvxlz5ymr
hIuKaN0pdyMTsR96M9oQcdB1NNhPhrH7zmOJKoCFpF+745Wv4Wiq7BNBPHP0KunE
yS03O97aei5VD5uDmjIPwc4QJTCsfuZnwRkwEerj3CsfX2oNHCSxkj98VGqs2itQ
ptvx4JjS2VOdCkv3OhZLS9Y8D5EzNK+2Hub4/oq9I03nEMoE4/lBzTm5NVgNHRpY
KsqoiYnRUmtwLVxmnBtvgEEtvcRFBDS+iKNvU5rfCJKPJ1Js+MdPRLrU+C/CxqYb
+4cj/qZkw9CQn6hkuA7+fszdlYnO3VWT7FY57j0t65HVM78SzT4m/1QpiukBrMr+
orqENePEWw3ImhbVOKoFpXzzUv6RoWsGBA+ikFmCLWmp23kVjb+1mEaSllKdk+5k
rrItx3UPvXmMhGxcmikKhUYryql9plIar5fzGLYJ3V2/J4k6pAEFmafT/Ai6iG4p
7nvNo5uVogBwmn33TKHSKjbzngV4IGJ94PBsDMELKNeDKCdJD2KAalmSnLZ8HytM
AZOmx41y3y2p+8PHYrG6A+ZvfzvmpWytq5nmXyMDNH1qBwRHhiE=
=Lib6
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
