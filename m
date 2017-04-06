From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Date: Thu, 6 Apr 2017 18:18:35 +0200
Message-ID: <20170406161835.GA19312@ulmo.ba.sec>
References: <20170215144531.GA39000@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33745 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbdDFQSj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2017 12:18:39 -0400
Content-Disposition: inline
In-Reply-To: <20170215144531.GA39000@ubuntu>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yang Ling <gnaygnil@gmail.com>
Cc: Marcin Nowakowski <marcin.nowakowski@imgtec.com>, Keguang Zhang <keguang.zhang@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-mips@linux-mips.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 10:45:31PM +0800, Yang Ling wrote:
> Add support for the PWM controller present in Loongson1 family of SoCs.
>=20
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
>=20
> ---
> V2:
>   Remove ls1x_pwm_channel.
>   Remove period_ns/duty_ns check.
>   Add return values check.
> ---
>  drivers/pwm/Kconfig         |   9 +++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-loongson1.c | 148 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 158 insertions(+)
>  create mode 100644 drivers/pwm/pwm-loongson1.c

Looks like this doesn't compile because it uses register definitions
=66rom loongson1.h that aren't what the driver expects. Looks like the
driver wants parameterized ones, but those present in the kernel are
not.

Any plans on fixing that? How did you build-test this?

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljmalgACgkQ3SOs138+
s6HB4BAAnaoA+xlMxsnPD3ufWuKEpsO6y5EQfYXFsbYG/IEW/77M64HQcEZqNYG6
JJTZhK2bstuEfAVXz1uQBGYrQ7xOXliL5jhgONTLCOYpII5UlGI0R+HW8v/vRRF4
aEdvd2C7YV2+2qxFTipDlScaxM8xFBiVYjZw8fJmrFeQrqZ1jsvkMlzzKuFmOtFc
y362HHHQrn7SkXr2VkbBnjX3JEvmCH7vyDkbc9hR3qj4VtT2AHcNbMe5/9npih1c
kLS4xCuWXMHkPzLluyJESeyoZ6g7moIr/LSWnDBVnEsei7Nox/m2sih08kvmQuW2
9lFEWTp+4yRUXUuLwEkR2nfAWgLFs6YB4hCLWbmWJqUYMR9vfTs5dGKMOiwvdPul
NeGcmM7cbYPDp3HgVnPvnkcUFsK7kC6jGqERy4IuO8nMuqSh3PoL4d9VMeAdwRXz
t/6QzUbwqPRH98lz662xstgD2Odg9+Pumq1vOMHUnNe1ifXafNC5dwwLen88jJWb
DuBE8bA4GZSsb1YSdvHf/v+BngNGW0LADZlDdSPv+7xaHnNjDkXriysC64x3ptec
7LGlgkpcqvzMgR8yD4+wiKjN1muhuHUNxC1xn9VYZRtVS92LaqrdrT3h6i8xppZ9
Uma8nbEQO9lCrvXX3jtOkaJhrsQBZSBju1db/h2619oveMRVUPA=
=/Jr6
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
