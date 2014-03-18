From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: Add CLPS711X PWM support
Date: Tue, 18 Mar 2014 21:23:09 +0100
Message-ID: <20140318202308.GD5917@mithrandir>
References: <1394639585-5673-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:54526 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459AbaCRUXN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Mar 2014 16:23:13 -0400
Content-Disposition: inline
In-Reply-To: <1394639585-5673-1-git-send-email-shc_work@mail.ru>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 07:53:05PM +0400, Alexander Shiyan wrote:
> Add a new driver for the ARM CLPS711X Pulse Width Modulator (PWM) interfa=
ce.
> This CPU contain two 4-bit PWM outputs with constant period, based on CPU
> PLL frequency. PWM polarity is determined by hardware by power on reset.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../bindings/pwm/cirrus,clps711x-pwm.txt           |  16 ++
>  drivers/pwm/Kconfig                                |   9 ++
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-clps711x.c                         | 176 +++++++++++++++=
++++++
>  4 files changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/cirrus,clps711x=
-pwm.txt
>  create mode 100644 drivers/pwm/pwm-clps711x.c

Applied, thanks.

Thierry

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKKssAAoJEN0jrNd/PrOhv38P/RuF9DX1TtczvEtHtyxRT0I4
DSs/ASJlH7ZFAThPFJmg/lkrGiY/S79ElQCRDDzmOV8Kdnd+rvj/TShh1XnUit+w
nDyvuZpMHMgcLjS3XNeIDkhvBK1zopHgvHhWIrOz5s4r6I9pxMVL+NCoUgNoyGcF
o+/J6Cq1mpgZi1oTP1mAtmvTcjtdvOB2mqaqqehf+fypD4echZ36Ol2zSRI2/OFN
6E4DSS3004GzIXboQp6GVQcq4VdYTG0xUULoaCDtXLYywVi66jr0pUyObCZk0Vyb
4MjcHNuWmIb9G2nVpYwpLjebbxwTJWpGfVi0gZrVChhbKJiENwE40F6Jl9sEkhKd
4FhZmcpob/MXVxDtuEVt6OlaAJ8xyZhr0lT9KJR2KdODtfAEdgB6qGI3HbnQFPXq
p8gTPy/vAbtB1KeWDIwE/3LmmiUbxRugtBhDv5IOk+o2YNsCFT2l0HHtNQ7k8AuH
Z2PE80Y7Bctn9G0leSZjK15ug7QfOMqYaBpt1ySzKjCf6mLGnVifByO48oPdBTcR
glOJgIDUT5vnLbyWRRNMEO3qly53PVljo2zOj57OdDInheO+A/7DJXdA09EdHcZr
MiSr8YlojNclPz1gaHc2nByNPtd588HGJ1Vij5As+okVmYecPi1oiZvf/JEHQw99
L9yGKDl3CIQKvb9gN7V7
=8gA/
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
