From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 2/3] pwm: iproc: Add support for Broadcom iproc pwm
 controller
Date: Fri, 8 Jul 2016 17:16:12 +0200
Message-ID: <20160708151612.GB1151@ulmo.ba.sec>
References: <1467698426-27600-1-git-send-email-yendapally.reddy@broadcom.com>
 <1467698426-27600-3-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32949 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbcGHPQR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Jul 2016 11:16:17 -0400
Content-Disposition: inline
In-Reply-To: <1467698426-27600-3-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 02:00:25AM -0400, Yendapally Reddy Dhananjaya Reddy=
 wrote:
> Add support for the PWM controller present in Broadcom's iProc
> family of SoCs.It has been tested on the  Northstar+ bcm958625HR board.
>=20
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadc=
om.com>
> ---
>  drivers/pwm/Kconfig         |  10 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-bcm-iproc.c | 268 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 drivers/pwm/pwm-bcm-iproc.c

I've applied this, but I had to make a couple of changes for coding
style and to squash compiler warnings. Please check the PWM tree's
for-next branch to see if it still works for you.

Thierry

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXf8O6AAoJEN0jrNd/PrOhZEMP/3As0SFkOhXhRa4Mx/nwaxiZ
Nj2eIM8OXfcvrKxLG9JUXGg+Spxx2Gxl6jnX72LSYjXnbE+tJmbphpwAoIN7XKlF
7enn5Gj0feLDz2Sh9AgdD+yQYpSTh/Ki4kDNj38YnvvR5GXjeLhga3W2Kqz+Szbp
VXIqSas+S5UMdsmQcRbBwJQVP+4HD19KJLZSISXP3RRpeSuxUMmQwE/GYTPUW3qv
1YRei3vObW6MVHi9K8gV3YesGO7P1IaJxo33crAO42MAVridIwA5g2XprN7Nw7NN
JGz4J/H9MLiLIFysAdbGBwcwocggFHnamc1Nwvtf0zRBCUYyqMMgaWVAgDS03AHs
XtiIQwLWmKu2fAZXbsNmqcCCS6I9ihyPDU6ad4YFwPx8P+taN6xGC7y0Jqpka5M9
1bXU38pt9EQzvW5/MJkvGxndwkoIM4zZ4qgsUTppC+WUQah2jVQilMSXvp8ubqlG
KEGHn6Q4ifCzQEKLv74P5DPXAPLxU/98v3g6a28k7u+PEr2XfB3f58p02M7pRZqy
mZguEtZ6gdzdkihF9eusqlVmgOIz0S/dzYKPHgMndFD8w+REfwGphbWcXy4r6MCL
ifr1j81wSIJdK4a05+HtxLlJM39MEt27e+9BSA9hfWR8+Q1sLbxGQDqBn0NnV0RA
DLwX0dJ+V22Ejx5jhWPS
=H/2x
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
