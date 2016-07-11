From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel: Fix disabling of PWM channels
Date: Mon, 11 Jul 2016 12:16:57 +0200
Message-ID: <20160711101657.GK5823@ulmo.ba.sec>
References: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34915 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684AbcGKKRA (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2016 06:17:00 -0400
Content-Disposition: inline
In-Reply-To: <1463137777-27103-1-git-send-email-guille.rodriguez@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guillermo Rodriguez <guille.rodriguez@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 01:09:37PM +0200, Guillermo Rodriguez wrote:
> When disabling a PWM channel, the PWM clock was being stopped
> immediately after writing to PWM_DIS. As a result, the disabling
> of the PWM channel did not complete properly, and the PWM output
> might be left at the wrong level.
>=20
> Fix this by waiting for the channel to be effectively disabled
> (by checking the PWM_SR register) before disabling the clock.
>=20
> Signed-off-by: Guillermo Rodriguez <guille.rodriguez@gmail.com>
> ---
>  drivers/pwm/pwm-atmel.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

Thierry

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg3IXAAoJEN0jrNd/PrOharoP/AivGHO8FjO+Q/3HopxuXYNd
paoNLjjAj9daGQFbU3O98BfcUwZskREYiidheeyD3SdUo8Kc7jy3WKHwOeLFE5Jl
PEO9sMG77+ah0SkBxv4lfhQanfw7E5gnPOY70S7M5wwPnAZBsgSRRIclo0YMS4ya
nTsCP6P0ZAIjFIlq3uP+i5MUhIirePTIKqUIvZEFPPUa9FrVus0nJuuy1kO8Hd9e
d6OSRk3gkljW+aylHqofBVDymt/45gO8DO7+WZ9vs3qSDAmxnRIBgERCXSKD7BRr
UrTO4zl/YUQahGxjBwo8jQCnX4jRPkHLErdoBihQh1NPZxYJrjgL1oS0AwgMsd5J
FI9VsZWcen6Y/MrjKMreNNCP3FK7BfpJvt3oe1IC6+Zk2+wbV6onHACnUVTsjPL+
2f9rDg+Wf3RLP71Hc+Mkz+6ZFDWl3k7hm73Lq2SA7bwLlY2S0T3CN2V8RyFC/mx5
NB5FglZ/2jKTpyI1M8ioEZ0ZHk2kU1xO+eMHm8Y0TaND062FZFa6WnI3zS7yws9q
OKfg5c9oaIflKWFtuBwEaoPKQbSGMcoEMMgHX9riYtUB2VopwM1KxgCJkeCB2QUV
8vhoFeG49h84cV6iyIzDI1U/zUXrZGvg7+s4rBNX8g+sp9NIh34HUALoQr5sw9Hj
G2IFKnLGioq5P8NlynN1
=gZ5l
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
