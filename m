From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [pwm:for-4.11/drivers 1/3] drivers/pwm/pwm-pca9685.c:171:15:
 error: 'offset' redeclared as different kind of symbol
Date: Thu, 19 Jan 2017 00:56:33 +0100
Message-ID: <20170118235633.GA28179@ulmo.ba.sec>
References: <201701182217.IBub4l8v%fengguang.wu@intel.com>
 <20170118153211.GR2023@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33006 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbdASADW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2017 19:03:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so7950556wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2017 16:02:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170118153211.GR2023@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-pwm@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 05:32:11PM +0200, Mika Westerberg wrote:
> On Wed, Jan 18, 2017 at 10:43:20PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/=
linux-pwm.git for-4.11/drivers
> > head:   9a8be0b9496a69ac30a2b2529104459d944d6d6c
> > commit: aba48949e7d5f83dcf08924ce09dd8951b419222 [1/3] pwm: pca9685: Al=
low any of the 16 PWMs to be used as a GPIO
> > config: x86_64-randconfig-x014-201703 (attached as .config)
> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> > reproduce:
> >         git checkout aba48949e7d5f83dcf08924ce09dd8951b419222
> >         # save the attached .config to linux build tree
> >         make ARCH=3Dx86_64=20
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >    drivers/pwm/pwm-pca9685.c: In function 'pca9685_pwm_gpio_set':
> > >> drivers/pwm/pwm-pca9685.c:171:15: error: 'offset' redeclared as diff=
erent kind of symbol
> >      unsigned int offset;
> >                   ^~~~~~
> >    drivers/pwm/pwm-pca9685.c:166:71: note: previous definition of 'offs=
et' was here
> >     static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned i=
nt offset,
> >                                                                        =
   ^~~~~~
>=20
> This was due to the stylistic changes, I think. The original patch did
> compile ;-)
>=20
> Here is the fixup. Let me know if you prefer an incremental patch
> instead.

Yeah, that's what I get for trying to rush things. I've fixed it up by
simply not using a local variable at all for the register offset.

Looks like I might have missed today's linux-next fetch window, so the
same report might come in for next-20160119.

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliAAK4ACgkQ3SOs138+
s6Gncg//Y931EOsNX1FFEBIUmTEoT55SIFIv/Xb1OhdWYr4++q0kCxfXA8zDtk4O
3bhSUz9ZwsW0zNjaOVAVTBAIOaFZrD83hAkDKff/229OUC1/g4E25wqWxPCtF/5Q
+S7LYu8J4uUanedLmmc/60Isbe0INr8h5xbpWkAzcMMw5tl5n7EncZ4i2I5kOAkn
l5qwl4I2M6d8LLg8MSSqU3if1rEM2q+8L14nhqKAlw8nqIG8Wum/bQWYW+Zh9ZO1
trBZ3U5LLQb48RVhQb73214ZWq/rk/4378f6fttAO6syLU1Rc7DDx7iQGhqH0CcO
dpX6UThgvAy376xB+Kms0cI35Ognp7O//x6yyz88/FuiJREoQL8nDOtgv06tUkKu
N8phZy6u5VnP7MIKOv9ImnuMoUgnuCj+QpLA8w+h+jD6MewKNDdMkuf9E2w/xsSk
7qbxvfn6rZnQ7AUtkyTnPvkvcuBi26IFL9fVLcV6prOxU1oHQYYqfbYmH7mPfQC/
NuoIbuOeicdqKv0r8+Xysa9fxxWcTPOAemAYfvevVEw27uLrBuFMQCi5bUb+TtGI
f9GsNEqqCT9xiU7CI9hIPlIbt7wc2l4dUJJenpJlw0YA/HP8vljAbpyN7sqjzmF5
LD34F4LbNjmMR4LAO7ieFzFuaos9jJz6i8kdX7R/8pQeqn+fwWs=
=D/Bm
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
