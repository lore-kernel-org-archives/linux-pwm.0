From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 08:10:20 +0100
Message-ID: <20170130071020.GE3585@ulmo.ba.sec>
References: <CGME20170130045241epcas1p2a5a0625327e4caab59236ec85551f95e@epcas1p2.samsung.com>
 <1485751953-29341-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34135 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbdA3HKY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2017 02:10:24 -0500
Content-Disposition: inline
In-Reply-To: <1485751953-29341-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 10:22:33AM +0530, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
>=20
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/pwm/pwm-sun4i.c |    4 ++++
>  drivers/pwm/pwm-tegra.c |    5 +++++
>  2 files changed, 9 insertions(+)

Both of these drivers will only run on purely OF systems, so this check
is unnecessary.

Thierry

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliO5twACgkQ3SOs138+
s6GhWhAAuYPweIDoZgmOms25t+vRqYAuuocTTOrBEuk3cwgTapKoObqJ/tTLJU1s
txlzvRdzjc5F0/XrADYHM35lnbPOmYEkMpDr3NZwKHMMRzTY2EBn1W5E9EiwyH7V
AwuXWwf3T3qTOakklS6EmhII8EtQFP+kBvZASMk2huz7QqSgcM2rCsuCLuEL8Y+n
0ThS7hKrVkYM7xI3aqQPY+LSVJ7k961H3DPKvIVVhRxFoUWpEuMwestUmE3EW9fS
CfNw7sC4fthN8DPot50NtX2+5YvEEE5yTW0ne+0FX7E4wkvSDwLJbxoauPMZH8f+
LK3mRup2iHFbZZoV+0gn24Jdm9Dx+dyrqC64TOg//YLqNhG/kvm4+nm+cmrnthZr
E9ZlVWnos0nK7FFrkcbo0V6Ymrl1mdnd0RDyePtb/OOwHP+evcAnF7qzTcLGPCgc
6iQCodX1uSSdPgnJBsWKG5TgbiKWXOalXaWFXlbhE2sfR31jgPUX1/4aswJQh7x9
W7yHVjTckkebAY0P21bXZvYrntUksJA5oYVYBw62v0Sk7jynYRp0h34SVn9WfLg4
Sa5B0AQaNoPX1YA59u8lZIdl2tiYJfele/ZNl58oVR4A/Ugwqg+UGZWk6MHyoFcv
4nAB6MwEbqHWwiG+09PQqm+MTPl0vdCpQS9LbvRm99nRkZaTwPM=
=DhXH
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
