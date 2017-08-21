From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: tiehrpwm: fix runtime pm imbalance at unbind
Date: Mon, 21 Aug 2017 08:09:48 +0200
Message-ID: <20170821060948.GE18996@ulmo>
References: <20170720104817.25726-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33723 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbdHUGJv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 02:09:51 -0400
Content-Disposition: inline
In-Reply-To: <20170720104817.25726-1-johan@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 12:48:16PM +0200, Johan Hovold wrote:
> Remove unbalanced RPM put at driver unbind which resulted in a negative
> usage count.
>=20
> Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 1 -
>  1 file changed, 1 deletion(-)

Both patches applied to for-4.14/drivers, thanks.

Thierry

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmaeSsACgkQ3SOs138+
s6FnyhAAhZhc2KycB1TFUZ4PGZr+CtvuRCcLHi3OBwJo2HgCdRmisWIKxY6FXsH4
2DPm6uCXUfoisWnZEuivfOqonS0IGi3sYNX27k6J75fPhlOMlThy75SzK8iMrE6O
2zxrtLUNNThLNZZO2wtI/x87r7AvKxbwKCjwKLbWZwL1RNfztxLSf5wk3+bL/30L
4cTDeeWVsr0K9f9Ihmp+JmzUFa2WxAKWYfo8hOUJ25WJrBMIuPq0fSLi73XxrZ9a
6lS6pwrSNbwTIw25B7hMn4IMlRynsWkoFJYQd5mo8P9ke8lO8oQO9ITkdnQVZb9D
+b7zk0TrneEqKC/bu6XJI+cn6ragAYfb0NvI8MVtXvoc/c8JcvP8nMXfk1Jup1Et
PG/esG0thVkTM53l+yD3kArrkY2LlzzwvOAbJs9ZVU0JIUoGpPFYfCJDV7IYqYKC
EMDALR6ZIGsujas2LaXtq6LpoOP3GQbaP32yuD3Ua7QJQWXpzFlRzHRYM1X6yKJm
JutN+9R2kOJLwmhwbLbccCHlebkoY/DKQeXzWnauX9GEistf/qeyqe5cvbk8IiLr
cQcO05tk/p1ndVsfdD4kryrfSYuDj6FJN1Ugd/2RW/SntYEBW6FCJEeiCF6ND+E5
jiiuNqFHUf7dO0kkzfEHhnwQ4oBfnH+UyB1TkQSl/kAmN8SjDSU=
=QX6+
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
