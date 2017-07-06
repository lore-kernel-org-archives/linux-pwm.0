From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: cros-ec: fix transposed param settings
Date: Thu, 6 Jul 2017 10:16:23 +0200
Message-ID: <20170706081623.GN16144@ulmo.fritz.box>
References: <20170623215247.114305-1-nvaccaro@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cs5saTBZh7UZl2eX"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:35551 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdGFIQc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 04:16:32 -0400
Content-Disposition: inline
In-Reply-To: <20170623215247.114305-1-nvaccaro@chromium.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nick Vaccaro <nvaccaro@google.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--cs5saTBZh7UZl2eX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 02:52:47PM -0700, Nick Vaccaro wrote:
> The __cros_ec_pwm_get_duty() routine was transposing the insize and
> outsize fields when calling cros_ec_cmd_xfer_status().
>=20
> The original code worked without error due to size of the two particular
> parameter blocks passed to cros_ec_cmd_xfer_status(), so this change is
> not fixing an actual runtime problem, just correcting the calling usage.
>=20
> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/pwm/pwm-cros-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--cs5saTBZh7UZl2eX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld8dcACgkQ3SOs138+
s6FLNQ/5Aa3nGPhB+6tsSPTp9SJWG8d3EZhMqmVVI6Zc0b8d085wA4+Tz1/CotrD
wdGdSImLUmjFvwIqj4FrRfxZdOcqQa6Er4chHsZe5O0xI7Tjfz1xTZiaQHvfJccw
/QFDnjZeDBHAnjdTkIb92MqHVjrAxZCOthWdVu9G4c+VSrr210otNtGCKIdB9VZx
qWpvwyBLn7KigSqDws/yn/WoS2m2FAKATQgj+8gAJrRx66950Dukp88eH3rTbx7V
ek7Ilf4XMwtgVGHBxMoisLsCZXmpdkA3Kr71VwmwTv7xKYKSASi240CYmwlNwfTZ
5yXYomEjQsrMxoZBqT6Z2k28dDEzHxtnbWATxxhRtF5hX8Uyke6InqY6vfA3df9G
HQOg6aQBjS/wNNr3sozonpTbk7mCMBd75DM5WFWA0PhZvdO8bbC9Gw7qT785i4EJ
qT3VRNntTmUkUfMdS4Y6QPrnBe7U3ieLgsqHyTfUQxnTPbYDMOhlEW9QvzTyM80m
DQ12l2MXSvLzwwJzpN6oWF9OLNUklUKmd6pRSAUa0N31+riG5oN6ZKpxdmMxixy6
KjNquUDpWX9/waqMMV/rCky+U99jQWPJ/9tUJ/Ww2xQvFeJZpHtVd+d8LGY8/RaH
ed67A6gdUZ8L+IgdQYn5eS0uFJ34ro0rRWGJeLU5IMvZ/cg43+4=
=rtHW
-----END PGP SIGNATURE-----

--cs5saTBZh7UZl2eX--
