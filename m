From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 1/1] pwm: lpss: pci: enable PWM module on Intel Edison
Date: Tue, 14 Jun 2016 10:59:17 +0200
Message-ID: <20160614085917.GC24442@ulmo.ba.sec>
References: <1465843939-1221-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34113 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbcFNI7V (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jun 2016 04:59:21 -0400
Received: by mail-wm0-f51.google.com with SMTP id k184so20360091wme.1
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jun 2016 01:59:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1465843939-1221-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 09:52:19PM +0300, Andy Shevchenko wrote:
> Intel Edison has 4 PWM channels on the die with the same IP as in Broxton.
> Enable it.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXX8dlAAoJEN0jrNd/PrOh/yEP/izZve3h3h26NgUifanvoROY
oBiN4NDnoA92LOb1NR/5yLt9UOLi/7mCOEBjumuSbOka0c1ksFlbgac9lC9P5jlf
3O4RAn7UZQiTCqevRWgE9OFPlKyTVmwNaaXk1jbrS+rOaYesc//h4U69j6PwbJTN
jU+t5tBZVxuQurCPkuRsdHa36fuJgL6WPGc6ax9rFJZrvDyTgpvcFA15m/QULS9r
sjfxNaawrO+G06Zy4ZZmNTI4dqRH3sMV/baFDEeIvUkvXVXROCqBODAW+MhiVWRp
OoKqN88Tx89w2TrIHgkpSM4V7kRZrk4imDgVaIkNghbQdnaTpDjpAc/F18GAVOak
lIOnkoUDGZS2T3a6Kpu4n1zEUkegxo0V78IUWwfoQthqknbG1dUzSmkr3+5cdtOX
khxJ5S4hMIkiowiAFSFsRjJ2S28ho9wCZeUDB4N0F5hh7amZoMa85LfAi7FpZkVF
s4O+mK/dQEZ6M7p6JR/gTeVPZtCYjnXKn/MvAr2zAJapKRfFkh5tOVBB2/mmeYdH
8Z7wSbJQlBxzdhJbUxA7dfsOWCXkJCjCMm/AjBHntKib7rgktFZPGQQojjyP8/4O
c2GovtBsWr4jwTw0NmFHzk7ZnR6fKGaCGsN5dU8z7J2fNGIunhvK4x5j6CvlxqxY
HZkt3mBBsSh81bpWEODx
=pJ13
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
