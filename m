From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 0/6] pwm: lpss: Fix and clean up series
Date: Mon, 30 Jan 2017 08:18:08 +0100
Message-ID: <20170130071808.GH3585@ulmo.ba.sec>
References: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33057 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbdA3HZw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 02:25:52 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so14346365wmv.0
        for <linux-pwm@vger.kernel.org>; Sun, 29 Jan 2017 23:25:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170128151044.87572-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Ilkka Koskinen <ilkka.koskinen@intel.com>


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 28, 2017 at 05:10:38PM +0200, Andy Shevchenko wrote:
> There are clean ups and switch to new atomic API (would be considered as
> an improvement).
>=20
> The series tested on various Intel platforms, such as Edison and
> Minnowboard MAX.
>=20
> Since v2:
> - rebase on top of v4.10-rc5
> - replace patch 3 with duplicating board info files in bus drivers
> - eliminate reminders of legacy API
> - incorporate Mika's Gemini Lake patch
> - add new patch from Ilkka
>=20
> Since v1:
> - rebase on top of v4.10-rc2
> - fix typo in commit message of patch 1
> - add Mika's tag
>=20
> Andy Shevchenko (4):
>   pwm: lpss: Avoid potential overflow of base_unit
>   pwm: lpss: Allow duty cycle to be 0
>   pwm: lpss: Switch to new atomic API
>   pwm: lpss: Do not export board infos for different PWM types
>=20
> Ilkka Koskinen (1):
>   pwm: lpss: Avoid reconfiguring while UPDATE bit is still enabled
>=20
> Mika Westerberg (1):
>   pwm: lpss: Add Intel Gemini Lake PCI ID
>=20
>  drivers/pwm/pwm-lpss-pci.c      |  22 +++++++
>  drivers/pwm/pwm-lpss-platform.c |  21 +++++++
>  drivers/pwm/pwm-lpss.c          | 132 ++++++++++++++++++++--------------=
------
>  drivers/pwm/pwm-lpss.h          |   4 --
>  4 files changed, 110 insertions(+), 69 deletions(-)

Applied all six patches, thanks.

Thierry

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO6LAACgkQ3SOs138+
s6FAFg//SXBYvWPTbuJl9NJRxpXT4cqADu8sdG0RVx2JDXflXtWudITCsM+3QuCJ
Ci7i6GDQ+d1HFk1jzRUMKE/Q7qBZfJVcgK7BqrIg9MU62srfnvRBmKc7wUyB+pcN
ZZZhbn4vyxjx3HuRVlsN22rvIevzcC7OoJXNBZv8L/82Gj2HkCjEUnJScJ54JuGf
7RgSiZZ2gX1T3ZNrhYXwcybF3JjVRyFG2EB6x5yY0DNaK4bvN634gn+TpS+mwWyN
0ntpbWHjt9h6e3dns7OUQQDR2HJWNvuL3kW04zdWwD6T5/9WfetRTezrS8kwqfvB
Yg31agYv87DQg02H/oZr1V22/zPpRissHMEafMDhboYxCZ/r6+IEyNiQ3h1LQMy6
W1jbAv3W8TNFWAKnZeRHyVf5/WIsRCrCNBeSXemt453MPhHFC11pCHj7uIwpFIsT
oyDOhzKKTFLZ+k7j0gIrCQdbmON8ZcjUGOqcBOqbVW8WYUJUQlbQAQ9vf/SShgt0
1El6U9S/c6bqWytvmqo9mTNtUa5Ks2eHDfYlNT6CLKSoxvIw19Mu6vz8ZEBsaoXo
LCf7iCaBFbNzn/Gtn8W5X+5dL7lsuivXMFZpneG1AWg4b2z1qFRVC11GC0JZ79QF
ivXOO8u8zEjefBJtUsNWq4Q6LCW+nsTtQbtHD+CFvmoH4OWvAEE=
=98ab
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
