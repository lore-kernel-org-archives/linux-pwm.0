From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-pwm: clock can not unprepare after
 successfully register
Date: Fri, 20 Dec 2013 10:50:29 +0100
Message-ID: <20131220095028.GE27787@ulmo.nvidia.com>
References: <1387424542-5864-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:56710 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755096Ab3LTJwC (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 04:52:02 -0500
Content-Disposition: inline
In-Reply-To: <1387424542-5864-1-git-send-email-voice.shen@atmel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 11:42:22AM +0800, Bo Shen wrote:
> When the PWM controller is registered successfully, the clock can not
> unprepare, so fix it.
>=20
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  drivers/pwm/pwm-atmel.c |    2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStBLkAAoJEN0jrNd/PrOhWvwQALQBEb2ZqLAxCldv8tpNLAQq
4bST2cDVAhk4ct0OIBsu6RpmsnY5cPIfMtMOcuzBw+HRnIzgO/9BJhKZah7W4w4a
ms2quSmf52MSBRfn6mE5tHtXnrff7Xncd3AtId4IrS8uEPvrIOrS18OQDTSW1qaG
0ELjItu5t+nGjFpfG6kxTB7bWOSlT02zmjWNwF1gtgNDUl3XzLS2/es3lUXpJJVQ
84UC5ahjhRzemPLqkN1IqbzEcg4Hr3jLCXAu2bFUPEQabtXqL3uDNJ0iN6xANBia
f0hjtOwgEMq2LRgB03cQDUdfRgg/KQiZXBm6KIAPugQV+nTTQLzOMfjoktRaNnaU
OyT0c4shBLW4dKLxy7bH5w9kXmFvNL9TwQYPj4oFNEgGlJKii0PngIeF5F+A4x/3
e2izJFIgJ87QLq99tORrM8TWMtSsPQOhtE9//85OKz4djsQaxqiLI1nsSOjk20yT
eb91XpFEJR750K7nCnjlyoWDDdPHsb7WUhU1v38ApnUlNIx7kd1iDVd5zMZA2AXJ
g+zFOVnMXNQ3LcLc1jMy51gu8zwghzd9sDOi6mAn+ZNDsV3HwudRI8f4QrvlXyn/
q6ZmUO6yrsL0hr9i1aq6t53YzjiBGD5L69Ak+ZQzGMjfNs5bbnJvY19QXOGG+28F
A4Yzz2y/R7N3wwEwJAyu
=bRhX
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
